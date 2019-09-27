# Package

version     = "3.3.0"
author      = "Leonardo Mariscal"
description = "GLFW bindings for Nim"
license     = "MIT"
srcDir      = "src"
skipDirs    = @["tests"]

# Dependencies

requires "nim >= 1.0.0"

task gen, "Generate bindings from source":
  exec("nim c -r tools/generator.nim")
