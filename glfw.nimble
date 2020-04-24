# Package

version     = "3.3.4"
author      = "Leonardo Mariscal"
description = "GLFW bindings for Nim"
license     = "MIT"
srcDir      = "src"
skipDirs    = @["tests"]

# Dependencies

requires "nim >= 1.0.0"

task gen, "Generate bindings from source":
  exec("nim c -r tools/generator.nim")

task test, "Create window demo":
  exec("nim c -r tests/test.nim")
