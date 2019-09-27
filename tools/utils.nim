# Written by Leonardo Mariscal <leo@ldmd.mx>, 2019

const srcHeader* = """
# Copyright 2019, NimGL contributors.

## GLFW Bindings
## ====
## WARNING: This is a generated file. Do not edit
## Any edits will be overwritten by the generator.
##
## The aim is to achieve as much compatibility with C as possible.
## All procedures which have a GLFW object in the arguments won't have the glfw prefix.
## Turning ``glfwMakeContextCurrent(window)`` into ``window.makeContextCurrent()``.
##
## You can check the original documentation `here <http://www.glfw.org/docs/latest/>`_.

import strutils, ./glfw/private/logo

proc currentSourceDir(): string =
  result = currentSourcePath().replace("\\", "/")
  result = result[0 ..< result.rfind("/")]
  echo result

{.passC: "-I" & currentSourceDir() & "/glfw/private/glfw/include/".}
{.pragma: glfw_header, header: "GLFW/glfw3.h".}

when defined(glfwDLL):
  when defined(windows):
    const glfw_dll* = "glfw3.dll"
  elif defined(macosx):
    const glfw_dll* = "libglfw3.dylib"
  else:
    const glfw_dll* = "libglfw.so.3"
else:
  {.compile: "glfw/private/glfw/src/vulkan.c".}

  # Thanks to ephja for making this build system
  when defined(windows):
    {.passC: "-D_GLFW_WIN32 -DGLFW_EXPOSE_NATIVE_WIN32",
      passL: "-lopengl32 -lgdi32",
      compile: "glfw/private/glfw/src/win32_init.c",
      compile: "glfw/private/glfw/src/win32_joystick.c",
      compile: "glfw/private/glfw/src/win32_monitor.c",
      compile: "glfw/private/glfw/src/win32_time.c",
      compile: "glfw/private/glfw/src/win32_thread.c",
      compile: "glfw/private/glfw/src/win32_window.c",
      compile: "glfw/private/glfw/src/wgl_context.c",
      compile: "glfw/private/glfw/src/egl_context.c",
      compile: "glfw/private/glfw/src/osmesa_context.c".}
  elif defined(macosx):
    {.passC: "-D_GLFW_COCOA -D_GLFW_USE_CHDIR -D_GLFW_USE_MENUBAR -D_GLFW_USE_RETINA",
      passL: "-framework Cocoa -framework OpenGL -framework IOKit -framework CoreVideo",
      compile: "glfw/private/glfw/src/cocoa_init.m",
      compile: "glfw/private/glfw/src/cocoa_joystick.m",
      compile: "glfw/private/glfw/src/cocoa_monitor.m",
      compile: "glfw/private/glfw/src/cocoa_window.m",
      compile: "glfw/private/glfw/src/cocoa_time.c",
      compile: "glfw/private/glfw/src/posix_thread.c",
      compile: "glfw/private/glfw/src/nsgl_context.m",
      compile: "glfw/private/glfw/src/egl_context.c",
      compile: "glfw/private/glfw/src/osmesa_context.c".}
  else:
    {.passL: "-pthread -lGL -lX11 -lXrandr -lXxf86vm -lXi -lXcursor -lm -lXinerama".}

    when defined(mir):
      {.passC: "-D_GLFW_MIR",
        compile: "glfw/private/glfw/src/mir_init.c",
        compile: "glfw/private/glfw/src/mir_monitor.c",
        compile: "glfw/private/glfw/src/mir_window.c".}
    elif defined(wayland):
      {.passC: "-D_GLFW_WAYLAND",
        compile: "glfw/private/glfw/src/wl_init.c",
        compile: "glfw/private/glfw/src/wl_monitor.c",
        compile: "glfw/private/glfw/src/wl_window.c".}
    else:
      {.passC: "-D_GLFW_X11",
        compile: "glfw/private/glfw/src/x11_init.c",
        compile: "glfw/private/glfw/src/x11_monitor.c",
        compile: "glfw/private/glfw/src/x11_window.c",
        compile: "glfw/private/glfw/src/glx_context.c".}

    {.compile: "glfw/private/glfw/src/xkb_unicode.c",
      compile: "glfw/private/glfw/src/linux_joystick.c",
      compile: "glfw/private/glfw/src/posix_time.c",
      compile: "glfw/private/glfw/src/egl_context.c",
      compile: "glfw/private/glfw/src/osmesa_context.c",
      compile: "glfw/private/glfw/src/posix_thread.c".}

  {.compile: "glfw/private/glfw/src/context.c",
    compile: "glfw/private/glfw/src/init.c",
    compile: "glfw/private/glfw/src/input.c",
    compile: "glfw/private/glfw/src/monitor.c",
    compile: "glfw/private/glfw/src/window.c".}
"""

const preProcs* = """
when defined(glfwDLL):
  {.push dynlib: glfw_dll, cdecl.}
else:
  {.push nodecl.}
"""

const typeDefinitions* = """
  GLFWVidMode* {.importc: "GLFWvidmode".} = object
    ## This describes a single video mode.
    width*: int32
    height*: int32
    redBits*: int32
    greenBits*: int32
    blueBits*: int32
    refreshRate*: int32
  GLFWGammaRamp* {.importc: "GLFWgammaramp".} = object
    ## This describes the gamma ramp for a monitor.
    red*: uint16
    green*: uint16
    blue*: uint16
    size*: uint32
  GLFWImage* {.importc: "GLFWimage".} = object
    ## This describes a single 2D image.
    width*: int32
    height*: int32
    pixels*: ptr cuchar
  GLFWGamepadState* {.importc: "GLFWgamepadstate".} = object
    ## This describes the input state of a gamepad.
    buttons*: array[15, bool]
    axes*: array[6, float32]
"""

let boolProcs* = [
  "GLFWWindowfocusFun", "GLFWWindowiconifyFun", "GLFWCursorenterFun", "glfwInit",
  "setWindowShouldClose", "windowShouldClose", "glfwJoystickPresent", "glfwGetGamepadState"
]

const converters* = """
converter toGLFWKey*(x: int32): GLFWKey = GLFWKey(x)
converter toint32*(x: GLFWKey): int32 = x.int32
converter toGLFWHat*(x: int32): GLFWHat = GLFWHat(x)
converter toint32*(x: GLFWHat): int32 = x.int32
converter toGLFWMouseButton*(x: int32): GLFWMouseButton = GLFWMouseButton(x)
converter toint32*(x: GLFWMouseButton): int32 = x.int32
converter toGLFWJoystick*(x: int32): GLFWJoystick = GLFWJoystick(x)
converter toint32*(x: GLFWJoystick): int32 = x.int32
converter toGLFWGamepadButton*(x: int32): GLFWGamepadButton = GLFWGamepadButton(x)
converter toint32*(x: GLFWGamepadButton): int32 = x.int32
converter toGLFWGamepadAxis*(x: int32): GLFWGamepadAxis = GLFWGamepadAxis(x)
converter toint32*(x: GLFWGamepadAxis): int32 = x.int32
"""

const createWindowProc* = """
proc glfwCreateWindow*(width: int32, height: int32, title: cstring = "NimGL", monitor: GLFWMonitor = nil, share: GLFWWindow = nil, icon: bool = true): GLFWWindow =
  ## Creates a window and its associated OpenGL or OpenGL ES
  ## Utility to create the window with a proper icon.
  result = glfwCreateWindowC(width, height, title, monitor, share)
  if not icon: return result
  var image = GLFWImage(pixels: cast[ptr cuchar](nimglLogo[0].addr), width: nimglLogoWidth, height: nimglLogoHeight)
  result.setWindowIcon(1, image.addr)
"""
