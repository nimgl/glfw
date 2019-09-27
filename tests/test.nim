# Copyright 2019, NimGL contributors.

# import unittest
# import glfw

# proc keyProc(window: GLFWWindow, key: GLFWKey, scancode: int32, action: GLFWKeyAction, mods: GLFWKeyMod): void {.cdecl.} =
#   if key == keyESCAPE and action == kaPress:
#     window.setWindowShouldClose(true)

# suite "GLFW":
#   var window: GLFWWindow

#   test "init":
#     check glfwInit()

#   test "window create":
#     window = glfwCreateWindow(800, 600, "NimGL", nil, nil)
#     check window != nil

#     discard window.setKeyCallback(keyProc)
#     window.makeContextCurrent()

#   test "main loop":
#     while not window.windowShouldClose:
#       glfwPollEvents()
#       window.swapBuffers()

#   test "window destroy":
#     window.destroyWindow()

#   test "terminate":
#     glfwTerminate()

import glfw

var window: GLFWWindow

assert glfwInit() == 1

window = glfwCreateWindow(640, 480, "NimGL", nil, nil)
assert window != nil

window.glfwMakeContextCurrent()

while not window.glfwWindowShouldClose() == 1:
  window.glfwSwapBuffers()
  glfwPollEvents()

window.glfwDestroyWindow()
glfwTerminate()
