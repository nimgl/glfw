# Written by Leonardo Mariscal <leo@ldmd.mx>, 2019

import strutils, streams, sequtils, ./utils, strformat

proc title*(str: string): string =
  if str.len < 1:
    result = ""
  else:
    if str == "GLFW":
      return "GLFW"
    result = $str[0]
    for s in str[1 ..< str.len]:
      result.add(s.toLowerAscii())

proc title*(oa: openArray[string]): string =
  var parts = oa.map(title)
  result = parts.join()

proc genConstants*(output: var string) =
  let header = newFileStream("src/glfw/private/glfw/include/GLFW/glfw3.h", fmRead)
  output.add("\n# Constants and Enums\n")

  var line = ""
  var inEnum = "something"
  while header.readLine(line):
    if line.startsWith("#define"):
      let parts = line.split(' ').filter(proc (x: string): bool = x != "" and x != "#define")
      if parts.len < 2:
        continue
      var name = parts[0]
      var value = parts[1].replace("(", "")
      var possibleEnums = ["KEY", "MOUSE", "JOYSTICK", "GAMEPAD", "HAT"]

      let constType = name.split('_')[1]
      if possibleEnums.contains(constType) and name != "GLFW_JOYSTICK_HAT_BUTTONS":
        var nameTrim = 1
        var enumName = "GLFWKey"
        if constType == "MOUSE":
          enumName = "GLFWMouseButton"
        elif constType == "JOYSTICK":
          enumName = "GLFWJoystick"
        elif constType == "HAT":
          enumName = "GLFWHat"
        elif constType == "GAMEPAD":
          nameTrim = 2
          if name.split('_')[2] == "BUTTON":
            enumName = "GLFWGamepadButton"
          else:
            enumName = "GLFWGamepadAxis"

        if inEnum != enumName:
          inEnum = enumName
          output.add("type\n  {enumName}* {{.pure, size: int32.sizeof.}} = enum\n".fmt)

        var nameParts = name.split('_')
        nameParts.delete(0, nameTrim) # Change depending on enum
        name = nameParts.title()
        if name[0].isDigit():
          name = "K" & name
        if name.contains("Last"):
          continue
        if not value[0].isDigit():
          continue
        output.add("    {name} = {value}\n".fmt)
      else:
        if inEnum != "":
          output.add("const\n")
          inEnum = ""
        name = name.split('_').title()
        if name == "GLFWCursor":
          name = "GLFWCursorSpecial"
          output.add("  {name}* = {value} ## Originally GLFW_CURSOR but conflicts with GLFWCursor type\n".fmt)
          continue
        output.add("  {name}* = {value}\n".fmt)
  header.close()

proc genTypes*(output: var string) =
  let header = newFileStream("src/glfw/private/glfw/include/GLFW/glfw3.h", fmRead)
  output.add("\n# Type Definitions\n")
  output.add("{.push header: \"<GLFW/glfw3.h>\".}\n\n")
  output.add("type\n")

  var line = ""
  while header.readLine(line):
    if line.startsWith("typedef"):
      let parts = line.split(" ").filter(proc (x: string): bool = x != "" and x != "typedef")
      if parts[0] != "struct":
        continue
      if parts[1] == "GLFWvidmode":
        output.add(typeDefinitions)
        break

      var name = parts[1]
      name[4] = name[4].toUpperAscii()
      output.add("  {name}* {{.importc: \"{parts[1]}\".}} = ptr object\n".fmt)
      output.add("    ## Opaque {parts[2][0 ..< parts[2].len-1]} object\n".fmt)

  header.setPosition(0)
  while header.readLine(line):
    if line.startsWith("typedef"):
      let parts = line.split(" ").filter(proc (x: string): bool = x != "" and x != "typedef")
      if parts[0] == "struct":
        continue
      echo line

  output.add("\n{.pop.}")
  header.close()

proc glfwGenerate*() =
  var output = srcHeader

  output.genConstants()
  output.genTypes()

  writeFile("src/glfw.nim", output)

if isMainModule:
  glfwGenerate()
