# Written by Leonardo Mariscal <leo@ldmd.mx>, 2019

import strutils, streams, sequtils, ./utils, strformat

var opaqueTypes: seq[string]

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

proc formatDoc(doc: string): string =
  result = ""
  var line = ""
  for x in doc.split("\n"):
    line = x
    if line == "":
      continue

    var spaces = line.split('#')[0].count(' ')
    if line.contains("@ref"):
      if line.contains('(') and line.contains(')'):
        var left = line.split("(")
        var right = line.split(")")
        line = left[0] & right[1]
      else:
        line = line.replace("@ref", "")
      line = line.replace("[", "")
      line = line.replace("]", "")

    result = result.replace("|", "")
    result.add(line & "\n")
    # for i in 0 ..< spaces:
    #   result.add(' ')
    # result.add("##\n")

proc translateType*(name: string): string =
  result = name.replace("const ", "")
  result = result.replace("unsigned ", "u")
  result = result.replace("signed ", "")

  var depth = result.count('*')
  result = result.replace(" ", "")
  result = result.replace("*", "")
  result = result.replace("&", "")
  result = result.replace("_t", "")

  result = result.replace("int32", "int")
  if not result.contains("int64"):
    result = result.replace("int", "int32")
  result = result.replace("double", "float64")
  result = result.replace("size_t", "uint") # uint matches pointer size just like size_t

  if result.contains("char") and not result.contains("Wchar"):
    if result.contains("uchar"):
      result = "cuchar"
    elif depth > 0:
      result = result.replace("char", "cstring")
      depth.dec
      if result.startsWith("u"):
        result = result[1 ..< result.len]
    else:
      result = result.replace("char", "int8")

  if depth > 0 and result.contains("void"):
    result = result.replace("void", "pointer")
    depth.dec

  if result.startsWith("GLFW"):
    result[4] = result[4].toUpperAscii()

  if opaqueTypes.contains(result):
    depth.dec
  for d in 0 ..< depth:
    result = "ptr " & result
    if result == "ptr GLFWMonitor":
      result = "UncheckedArray[GLFWMonitor]"

proc genConstants*(output: var string) =
  let header = newFileStream("src/glfw/private/glfw/include/GLFW/glfw3.h", fmRead)
  output.add("\n# Constants and Enums\n")

  var inEnum = "something"
  var isDocumentation = false
  var documentation = ""
  var line = ""
  while header.readLine(line):
    if line.startsWith("/*!"):
      isDocumentation = true
      documentation = ""

    if isDocumentation and not line.startsWith("typedef"):
      line = line.replace("/*!", "    ##")
      line = line.replace(" * ", "    ##")
      line = line.replace(" *", "    ##")
      if not line.startsWith("#define") and not line.startsWith("    ## @{"):
        if line != "    ##/" or not line.contains("##/"):
          documentation.add(line & "\n")
        else:
          isDocumentation = false

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
          if documentation.startsWith("    ## @}"):
            documentation = ""
          output.add(documentation.formatDoc())

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

        if documentation.startsWith("    ## @}"):
          documentation = ""
        if documentation.replace("\n", "") == "":
          documentation = ""
        output.add(documentation.formatDoc())
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
      opaqueTypes.add(name)

  output.add("\n{.pop.}\n")
  output.add("\ntype\n")

  var isDocumentation = false
  var documentation = ""
  header.setPosition(0)
  while header.readLine(line):
    if line.startsWith("/*!"):
      isDocumentation = true
      documentation = ""

    if isDocumentation and not line.startsWith("typedef"):
      line = line.replace("/*!", "    ##")
      line = line.replace(" * ", "    ##")
      line = line.replace(" *", "    ##")
      if not line.startsWith("#define") and not line.startsWith("    ## @{"):
        if line != "    ##/" or not line.contains("##/"):
          documentation.add(line & "\n")
        else:
          isDocumentation = false

    if line.startsWith("typedef"):
      line = line.replace("* ", "*")
      line = line.replace("unsigned int", "uint32")
      line = line.replace("const char", "char")
      let parts = line.split(" ").filter(proc (x: string): bool = x != "" and x != "typedef")
      if parts[0] == "struct":
        continue

      let procType = parts[0]

      var procParts = parts[1].split(')')
      var procName = procParts[0][2 ..< procParts[0].len]
      procName[4] = procName[4].toUpperAscii()
      procName = procName.replace("fun", "Fun")
      procName = procName.replace("proc", "Proc")

      procParts[1] = procParts[1][1 ..< procParts[1].len]
      var argsTypes = procParts[1].split(',')
      argsTypes = argsTypes.map(translateType)
      argsTypes = argsTypes.filter(proc (x: string): bool = x != "void" and x != "")

      var argsNames: seq[string]

      for docLine in documentation.split("\n"):
        if not docLine.startsWith("    ## @param[in] "):
          continue
        var docType = docLine["    ## @param[in] ".len ..< docLine.len]
        var docParts = docType.split(" ")
        argsNames.add(docParts[0])

      var procSig = "  {procName}* = proc(".fmt
      for i in 0 ..< argsTypes.len:
        if boolProcs.contains(procName):
          argsTypes[i] = argsTypes[i].replace("int32", "bool")
        procSig.add("{argsNames[i]}: {argsTypes[i]}, ".fmt)
      if argsTypes.len > 0:
        procSig = procSig[0 ..< procSig.len - 2]
      procSig.add("): {procType} {{.cdecl.}}\n".fmt)

      if procName == "GLFWGlProc" or procname == "GLFWVkProc":
        output.add("  {procName}* = pointer\n".fmt)
      else:
        output.add(procSig)
      output.add(documentation.formatDoc())

  header.close()

proc genProcs*(output: var string) =
  let header = newFileStream("src/glfw/private/glfw/include/GLFW/glfw3.h", fmRead)
  output.add("\n" & converters)
  output.add("\n# Procs\n")
  output.add(preProcs & "\n")

  var isDocumentation = false
  var documentation = ""
  var line = ""
  var counter = 0# remove
  while header.readLine(line):
    if line.startsWith("/*!"):
      isDocumentation = true
      documentation = ""

    if isDocumentation and not line.startsWith("GLFWAPI"):
      line = line.replace("/*!", "  ##")
      line = line.replace(" * ", "  ##")
      line = line.replace(" *", "  ##")
      if not line.startsWith("#define") and not line.startsWith("  ## @{"):
        if line != "  ##/" or not line.contains("##/"):
          documentation.add(line & "\n")
        else:
          isDocumentation = false

    if not line.startsWith("GLFWAPI"):
      continue
    line = line[0 ..< line.len - 2]
    var parts = line.split(' ').filter(proc (x: string): bool = x != "" and x != "GLFWAPI" and x != "const")

    counter.inc
    # if counter != 4:
    #   continue

    var returnType = parts[0]
    if returnType == "unsigned":
      returnType = "u" & parts[1]
      parts.delete(0, 0)
    returnType = returnType.translateType()

    let originalName = parts[1].split('(')[0]
    var argsLine = line.split("(")[1]
    var argsTypes = argsLine.split(",")
    argsTypes = argsTypes.filter(proc (x: string): bool = x != "void" and x != "")
    argsTypes.apply(proc (x: var string) =
      x = x.replace("const", "")
      while x.startsWith(" "):
        x = x[1 ..< x.len]
    )
    var argsNames: seq[string]
    for i in 0 ..< argsTypes.len:
      var argParts = argsTypes[i].split(' ')
      argsTypes[i] = argParts[0]
      argsNames.add(argParts[1])

    # Vulkan specific types ignore TODO implement this
    var vkBreak = returnType.startsWith("Vk")
    for arg in argsTypes:
      if arg.startsWith("Vk"):
        vkBreak = true
    if vkBreak:
      echo "ignored >> " & line
      continue

    var procName = originalName
    if argsTypes.len > 0 and argsTypes[0].toLowerAscii().startsWith("glfw") and
      not argsTypes[0].toLowerAscii().contains("fun"):

      procName = procName[4 ..< procName.len]
      procName[0] = procName[0].toLowerAscii()

    argsTypes = argsTypes.map(translateType)
    if procName == "glfwCreateWindow":
      procName = "glfwCreateWindowC"
    var procSig = "proc {procName}*(".fmt
    for i in 0 ..< argsTypes.len:
      if boolProcs.contains(procName):
        argsTypes[i] = argsTypes[i].replace("int32", "bool")
      procSig.add("{argsNames[i]}: {argsTypes[i]}, ".fmt)
    if argsTypes.len > 0:
      procSig = procSig[0 ..< procSig.len - 2]

    if boolProcs.contains(procName):
      returnType = returnType.replace("int32", "bool")
    procSig.add("): {returnType} {{.importc: \"{originalName}\".}}".fmt)

    output.add(procSig & "\n")
    output.add(documentation.formatDoc())

  output.add("\n{.pop.}\n")
  output.add("\n" & createWindowProc)
  header.close()

proc glfwGenerate*() =
  var output = srcHeader

  output.genConstants()
  output.genTypes()
  output.genProcs()

  writeFile("src/glfw.nim", output)

if isMainModule:
  glfwGenerate()
