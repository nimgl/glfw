# Copyright 2019, NimGL contributors.

import unittest
import glfw, glfw/native

proc keyProc(window: GLFWWindow, key: int32, scancode: int32, action: int32, mods: int32): void {.cdecl.} =
  if key == GLFWKey.Escape and action == GLFWPress:
    window.setWindowShouldClose(true)

suite "GLFW":
  var window: GLFWWindow

  test "init":
    check glfwInit()

  test "window create":
    window = glfwCreateWindow(800, 600, "NimGL")
    check window != nil

    discard window.setKeyCallback(keyProc)
    window.makeContextCurrent()

    when defined(windows):
      var hwnd = window.getWGLContext()
      if hwnd == nil:
        echo "oh no"

  test "main loop":
    while not window.windowShouldClose:
      glfwPollEvents()
      window.swapBuffers()

  test "window destroy":
    window.destroyWindow()

  test "terminate":
    glfwTerminate()
