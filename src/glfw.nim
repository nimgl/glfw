# Copyright 2019, NimGL contributors.

## GLFW Bindings
## ====
## WARNING: This is a generated file. Do not edit
## Any edits will be overwritten by the generator.
##
## The aim is to achieve as much compatibility with C as possible.
## All procedures which have an object in the arguments won't have the glfw prefix.
## Turning ``glfwMakeContextCurrent(window)`` into ``window.makeContextCurrent()``.
##
## You can check the original documentation `here <http://www.glfw.org/docs/latest/>`_.
# Sorry for all whitespace in the documentation but I tried with \n and | and failed miserably.

import strutils

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

# Constants and Enums
const
  GLFWVersionMajor* = 3
  GLFWVersionMinor* = 3
  GLFWVersionRevision* = 0
  GLFWTrue* = 1
  GLFWFalse* = 0
  GLFWRelease* = 0
  GLFWPress* = 1
  GLFWRepeat* = 2
type
  GLFWHat* {.pure, size: int32.sizeof.} = enum
    Centered = 0
    Up = 1
    Right = 2
    Down = 4
    Left = 8
type
  GLFWKey* {.pure, size: int32.sizeof.} = enum
    Space = 32
    Apostrophe = 39
    Comma = 44
    Minus = 45
    Period = 46
    Slash = 47
    K0 = 48
    K1 = 49
    K2 = 50
    K3 = 51
    K4 = 52
    K5 = 53
    K6 = 54
    K7 = 55
    K8 = 56
    K9 = 57
    Semicolon = 59
    Equal = 61
    A = 65
    B = 66
    C = 67
    D = 68
    E = 69
    F = 70
    G = 71
    H = 72
    I = 73
    J = 74
    K = 75
    L = 76
    M = 77
    N = 78
    O = 79
    P = 80
    Q = 81
    R = 82
    S = 83
    T = 84
    U = 85
    V = 86
    W = 87
    X = 88
    Y = 89
    Z = 90
    LeftBracket = 91
    Backslash = 92
    RightBracket = 93
    GraveAccent = 96
    World1 = 161
    World2 = 162
    Escape = 256
    Enter = 257
    Tab = 258
    Backspace = 259
    Insert = 260
    Delete = 261
    Right = 262
    Left = 263
    Down = 264
    Up = 265
    PageUp = 266
    PageDown = 267
    Home = 268
    End = 269
    CapsLock = 280
    ScrollLock = 281
    NumLock = 282
    PrintScreen = 283
    Pause = 284
    F1 = 290
    F2 = 291
    F3 = 292
    F4 = 293
    F5 = 294
    F6 = 295
    F7 = 296
    F8 = 297
    F9 = 298
    F10 = 299
    F11 = 300
    F12 = 301
    F13 = 302
    F14 = 303
    F15 = 304
    F16 = 305
    F17 = 306
    F18 = 307
    F19 = 308
    F20 = 309
    F21 = 310
    F22 = 311
    F23 = 312
    F24 = 313
    F25 = 314
    Kp0 = 320
    Kp1 = 321
    Kp2 = 322
    Kp3 = 323
    Kp4 = 324
    Kp5 = 325
    Kp6 = 326
    Kp7 = 327
    Kp8 = 328
    Kp9 = 329
    KpDecimal = 330
    KpDivide = 331
    KpMultiply = 332
    KpSubtract = 333
    KpAdd = 334
    KpEnter = 335
    KpEqual = 336
    LeftShift = 340
    LeftControl = 341
    LeftAlt = 342
    LeftSuper = 343
    RightShift = 344
    RightControl = 345
    RightAlt = 346
    RightSuper = 347
    Menu = 348
const
  GLFWModShift* = 0x0001
  GLFWModControl* = 0x0002
  GLFWModAlt* = 0x0004
  GLFWModSuper* = 0x0008
  GLFWModCapsLock* = 0x0010
  GLFWModNumLock* = 0x0020
type
  GLFWMouseButton* {.pure, size: int32.sizeof.} = enum
    Button1 = 0
    Button2 = 1
    Button3 = 2
    Button4 = 3
    Button5 = 4
    Button6 = 5
    Button7 = 6
    Button8 = 7
type
  GLFWJoystick* {.pure, size: int32.sizeof.} = enum
    K1 = 0
    K2 = 1
    K3 = 2
    K4 = 3
    K5 = 4
    K6 = 5
    K7 = 6
    K8 = 7
    K9 = 8
    K10 = 9
    K11 = 10
    K12 = 11
    K13 = 12
    K14 = 13
    K15 = 14
    K16 = 15
type
  GLFWGamepadButton* {.pure, size: int32.sizeof.} = enum
    A = 0
    B = 1
    X = 2
    Y = 3
    LeftBumper = 4
    RightBumper = 5
    Back = 6
    Start = 7
    Guide = 8
    LeftThumb = 9
    RightThumb = 10
    DpadUp = 11
    DpadRight = 12
    DpadDown = 13
    DpadLeft = 14
type
  GLFWGamepadAxis* {.pure, size: int32.sizeof.} = enum
    LeftX = 0
    LeftY = 1
    RightX = 2
    RightY = 3
    LeftTrigger = 4
    RightTrigger = 5
const
  GLFWNoError* = 0
  GLFWNotInitialized* = 0x00010001
  GLFWNoCurrentContext* = 0x00010002
  GLFWInvalidEnum* = 0x00010003
  GLFWInvalidValue* = 0x00010004
  GLFWOutOfMemory* = 0x00010005
  GLFWApiUnavailable* = 0x00010006
  GLFWVersionUnavailable* = 0x00010007
  GLFWPlatformError* = 0x00010008
  GLFWFormatUnavailable* = 0x00010009
  GLFWNoWindowContext* = 0x0001000A
  GLFWFocused* = 0x00020001
  GLFWIconified* = 0x00020002
  GLFWResizable* = 0x00020003
  GLFWVisible* = 0x00020004
  GLFWDecorated* = 0x00020005
  GLFWAutoIconify* = 0x00020006
  GLFWFloating* = 0x00020007
  GLFWMaximized* = 0x00020008
  GLFWCenterCursor* = 0x00020009
  GLFWTransparentFramebuffer* = 0x0002000A
  GLFWHovered* = 0x0002000B
  GLFWFocusOnShow* = 0x0002000C
  GLFWRedBits* = 0x00021001
  GLFWGreenBits* = 0x00021002
  GLFWBlueBits* = 0x00021003
  GLFWAlphaBits* = 0x00021004
  GLFWDepthBits* = 0x00021005
  GLFWStencilBits* = 0x00021006
  GLFWAccumRedBits* = 0x00021007
  GLFWAccumGreenBits* = 0x00021008
  GLFWAccumBlueBits* = 0x00021009
  GLFWAccumAlphaBits* = 0x0002100A
  GLFWAuxBuffers* = 0x0002100B
  GLFWStereo* = 0x0002100C
  GLFWSamples* = 0x0002100D
  GLFWSrgbCapable* = 0x0002100E
  GLFWRefreshRate* = 0x0002100F
  GLFWDoublebuffer* = 0x00021010
  GLFWClientApi* = 0x00022001
  GLFWContextVersionMajor* = 0x00022002
  GLFWContextVersionMinor* = 0x00022003
  GLFWContextRevision* = 0x00022004
  GLFWContextRobustness* = 0x00022005
  GLFWOpenglForwardCompat* = 0x00022006
  GLFWOpenglDebugContext* = 0x00022007
  GLFWOpenglProfile* = 0x00022008
  GLFWContextReleaseBehavior* = 0x00022009
  GLFWContextNoError* = 0x0002200A
  GLFWContextCreationApi* = 0x0002200B
  GLFWScaleToMonitor* = 0x0002200C
  GLFWCocoaRetinaFramebuffer* = 0x00023001
  GLFWCocoaFrameName* = 0x00023002
  GLFWCocoaGraphicsSwitching* = 0x00023003
  GLFWX11ClassName* = 0x00024001
  GLFWX11InstanceName* = 0x00024002
  GLFWNoApi* = 0
  GLFWOpenglApi* = 0x00030001
  GLFWOpenglEsApi* = 0x00030002
  GLFWNoRobustness* = 0
  GLFWNoResetNotification* = 0x00031001
  GLFWLoseContextOnReset* = 0x00031002
  GLFWOpenglAnyProfile* = 0
  GLFWOpenglCoreProfile* = 0x00032001
  GLFWOpenglCompatProfile* = 0x00032002
  GLFWCursorSpecial* = 0x00033001 ## Originally GLFW_CURSOR but conflicts with GLFWCursor type
  GLFWStickyKeys* = 0x00033002
  GLFWStickyMouseButtons* = 0x00033003
  GLFWLockKeyMods* = 0x00033004
  GLFWRawMouseMotion* = 0x00033005
  GLFWCursorNormal* = 0x00034001
  GLFWCursorHidden* = 0x00034002
  GLFWCursorDisabled* = 0x00034003
  GLFWAnyReleaseBehavior* = 0
  GLFWReleaseBehaviorFlush* = 0x00035001
  GLFWReleaseBehaviorNone* = 0x00035002
  GLFWNativeContextApi* = 0x00036001
  GLFWEglContextApi* = 0x00036002
  GLFWOsmesaContextApi* = 0x00036003
  GLFWArrowCursor* = 0x00036001
  GLFWIbeamCursor* = 0x00036002
  GLFWCrosshairCursor* = 0x00036003
  GLFWHandCursor* = 0x00036004
  GLFWHresizeCursor* = 0x00036005
  GLFWVresizeCursor* = 0x00036006
  GLFWConnected* = 0x00040001
  GLFWDisconnected* = 0x00040002
  GLFWJoystickHatButtons* = 0x00050001
  GLFWCocoaChdirResources* = 0x00051001
  GLFWCocoaMenubar* = 0x00051002
  GLFWDontCare* = -1

# Type Definitions
{.push header: "<GLFW/glfw3.h>".}

type
  GLFWMonitor* {.importc: "GLFWmonitor".} = ptr object
    ## Opaque GLFWmonitor object
  GLFWWindow* {.importc: "GLFWwindow".} = ptr object
    ## Opaque GLFWwindow object
  GLFWCursor* {.importc: "GLFWcursor".} = ptr object
    ## Opaque GLFWcursor object
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

{.pop.}

type
  GLFWGlProc* = proc(): void {.cdecl.}
  GLFWVkProc* = proc(): void {.cdecl.}
  GLFWErrorFun* = proc(error: int32, description: cstring): void {.cdecl.}
  GLFWWindowposFun* = proc(window: GLFWWindow, xpos: int32, ypos: int32): void {.cdecl.}
  GLFWWindowsizeFun* = proc(window: GLFWWindow, width: int32, height: int32): void {.cdecl.}
  GLFWWindowcloseFun* = proc(window: GLFWWindow): void {.cdecl.}
  GLFWWindowrefreshFun* = proc(window: GLFWWindow): void {.cdecl.}
  GLFWWindowfocusFun* = proc(window: GLFWWindow, focused: int32): void {.cdecl.}
  GLFWWindowiconifyFun* = proc(window: GLFWWindow, iconified: int32): void {.cdecl.}
  GLFWWindowmaximizeFun* = proc(window: GLFWWindow, iconified: int32): void {.cdecl.}
  GLFWFramebuffersizeFun* = proc(window: GLFWWindow, width: int32, height: int32): void {.cdecl.}
  GLFWWindowcontentscaleFun* = proc(window: GLFWWindow, xscale: float, yscale: float): void {.cdecl.}
  GLFWMousebuttonFun* = proc(window: GLFWWindow, button: int32, action: int32, mods: int32): void {.cdecl.}
  GLFWCursorposFun* = proc(window: GLFWWindow, xpos: float64, ypos: float64): void {.cdecl.}
  GLFWCursorenterFun* = proc(window: GLFWWindow, entered: int32): void {.cdecl.}
  GLFWScrollFun* = proc(window: GLFWWindow, xoffset: float64, yoffset: float64): void {.cdecl.}
  GLFWKeyFun* = proc(window: GLFWWindow, key: int32, scancode: int32, action: int32, mods: int32): void {.cdecl.}
  GLFWCharFun* = proc(window: GLFWWindow, codepoint: uint32): void {.cdecl.}
  GLFWCharmodsFun* = proc(window: GLFWWindow, codepoint: uint32, mods: int32): void {.cdecl.}
  GLFWDropFun* = proc(window: GLFWWindow, count: int32, paths: cstring): void {.cdecl.}
  GLFWMonitorFun* = proc(monitor: GLFWMonitor, event: int32): void {.cdecl.}
  GLFWJoystickFun* = proc(jid: int32, event: int32): void {.cdecl.}

# Procs
when defined(glfwDLL):
  {.push dynlib: glfw_dll, cdecl.}
else:
  {.push cdecl.}

proc glfwInit*(): int32 {.importc: "glfwInit".} # 1
proc glfwTerminate*(): void {.importc: "glfwTerminate".} # 2
proc glfwInitHint*(hint: int32, value: int32): void {.importc: "glfwInitHint".} # 3
proc glfwGetVersion*(major: int32, minor: int32, rev: int32): void {.importc: "glfwGetVersion".} # 4
proc glfwGetVersionString*(): cstring {.importc: "glfwGetVersionString".} # 5
proc glfwGetError*(description: cstring): int32 {.importc: "glfwGetError".} # 6
proc glfwSetErrorCallback*(cbfun: GLFWErrorfun): GLFWErrorfun {.importc: "glfwSetErrorCallback".} # 7
proc glfwGetMonitors*(count: int32): GLFWMonitor {.importc: "glfwGetMonitors".} # 8
proc glfwGetPrimaryMonitor*(): GLFWMonitor {.importc: "glfwGetPrimaryMonitor".} # 9
proc glfwGetMonitorPos*(monitor: GLFWMonitor, xpos: int32, ypos: int32): void {.importc: "glfwGetMonitorPos".} # 10
proc glfwGetMonitorWorkarea*(monitor: GLFWMonitor, xpos: int32, ypos: int32, width: int32, height: int32): void {.importc: "glfwGetMonitorWorkarea".} # 11
proc glfwGetMonitorPhysicalSize*(monitor: GLFWMonitor, widthMM: int32, heightMM: int32): void {.importc: "glfwGetMonitorPhysicalSize".} # 12
proc glfwGetMonitorContentScale*(monitor: GLFWMonitor, xscale: float, yscale: float): void {.importc: "glfwGetMonitorContentScale".} # 13
proc glfwGetMonitorName*(monitor: GLFWMonitor): cstring {.importc: "glfwGetMonitorName".} # 14
proc glfwSetMonitorUserPointer*(monitor: GLFWMonitor, pointer: pointer): void {.importc: "glfwSetMonitorUserPointer".} # 15
proc glfwGetMonitorUserPointer*(monitor: GLFWMonitor): pointer {.importc: "glfwGetMonitorUserPointer".} # 16
proc glfwSetMonitorCallback*(cbfun: GLFWMonitorfun): GLFWMonitorfun {.importc: "glfwSetMonitorCallback".} # 17
proc glfwGetVideoModes*(monitor: GLFWMonitor, count: int32): GLFWVidmode {.importc: "glfwGetVideoModes".} # 18
proc glfwGetVideoMode*(monitor: GLFWMonitor): GLFWVidmode {.importc: "glfwGetVideoMode".} # 19
proc glfwSetGamma*(monitor: GLFWMonitor, gamma: float): void {.importc: "glfwSetGamma".} # 20
proc glfwGetGammaRamp*(monitor: GLFWMonitor): GLFWGammaramp {.importc: "glfwGetGammaRamp".} # 21
proc glfwSetGammaRamp*(monitor: GLFWMonitor, ramp: GLFWGammaramp): void {.importc: "glfwSetGammaRamp".} # 22
proc glfwDefaultWindowHints*(): void {.importc: "glfwDefaultWindowHints".} # 23
proc glfwWindowHint*(hint: int32, value: int32): void {.importc: "glfwWindowHint".} # 24
proc glfwWindowHintString*(hint: int32, value: cstring): void {.importc: "glfwWindowHintString".} # 25
proc glfwCreateWindow*(width: int32, height: int32, title: cstring, monitor: GLFWMonitor, share: GLFWWindow): GLFWWindow {.importc: "glfwCreateWindow".} # 26
proc glfwDestroyWindow*(window: GLFWWindow): void {.importc: "glfwDestroyWindow".} # 27
proc glfwWindowShouldClose*(window: GLFWWindow): int32 {.importc: "glfwWindowShouldClose".} # 28
proc glfwSetWindowShouldClose*(window: GLFWWindow, value: int32): void {.importc: "glfwSetWindowShouldClose".} # 29
proc glfwSetWindowTitle*(window: GLFWWindow, title: cstring): void {.importc: "glfwSetWindowTitle".} # 30
proc glfwSetWindowIcon*(window: GLFWWindow, count: int32, images: GLFWImage): void {.importc: "glfwSetWindowIcon".} # 31
proc glfwGetWindowPos*(window: GLFWWindow, xpos: int32, ypos: int32): void {.importc: "glfwGetWindowPos".} # 32
proc glfwSetWindowPos*(window: GLFWWindow, xpos: int32, ypos: int32): void {.importc: "glfwSetWindowPos".} # 33
proc glfwGetWindowSize*(window: GLFWWindow, width: int32, height: int32): void {.importc: "glfwGetWindowSize".} # 34
proc glfwSetWindowSizeLimits*(window: GLFWWindow, minwidth: int32, minheight: int32, maxwidth: int32, maxheight: int32): void {.importc: "glfwSetWindowSizeLimits".} # 35
proc glfwSetWindowAspectRatio*(window: GLFWWindow, numer: int32, denom: int32): void {.importc: "glfwSetWindowAspectRatio".} # 36
proc glfwSetWindowSize*(window: GLFWWindow, width: int32, height: int32): void {.importc: "glfwSetWindowSize".} # 37
proc glfwGetFramebufferSize*(window: GLFWWindow, width: int32, height: int32): void {.importc: "glfwGetFramebufferSize".} # 38
proc glfwGetWindowFrameSize*(window: GLFWWindow, left: int32, top: int32, right: int32, bottom: int32): void {.importc: "glfwGetWindowFrameSize".} # 39
proc glfwGetWindowContentScale*(window: GLFWWindow, xscale: float, yscale: float): void {.importc: "glfwGetWindowContentScale".} # 40
proc glfwGetWindowOpacity*(window: GLFWWindow): float {.importc: "glfwGetWindowOpacity".} # 41
proc glfwSetWindowOpacity*(window: GLFWWindow, opacity: float): void {.importc: "glfwSetWindowOpacity".} # 42
proc glfwIconifyWindow*(window: GLFWWindow): void {.importc: "glfwIconifyWindow".} # 43
proc glfwRestoreWindow*(window: GLFWWindow): void {.importc: "glfwRestoreWindow".} # 44
proc glfwMaximizeWindow*(window: GLFWWindow): void {.importc: "glfwMaximizeWindow".} # 45
proc glfwShowWindow*(window: GLFWWindow): void {.importc: "glfwShowWindow".} # 46
proc glfwHideWindow*(window: GLFWWindow): void {.importc: "glfwHideWindow".} # 47
proc glfwFocusWindow*(window: GLFWWindow): void {.importc: "glfwFocusWindow".} # 48
proc glfwRequestWindowAttention*(window: GLFWWindow): void {.importc: "glfwRequestWindowAttention".} # 49
proc glfwGetWindowMonitor*(window: GLFWWindow): GLFWMonitor {.importc: "glfwGetWindowMonitor".} # 50
proc glfwSetWindowMonitor*(window: GLFWWindow, monitor: GLFWMonitor, xpos: int32, ypos: int32, width: int32, height: int32, refreshRate: int32): void {.importc: "glfwSetWindowMonitor".} # 51
proc glfwGetWindowAttrib*(window: GLFWWindow, attrib: int32): int32 {.importc: "glfwGetWindowAttrib".} # 52
proc glfwSetWindowAttrib*(window: GLFWWindow, attrib: int32, value: int32): void {.importc: "glfwSetWindowAttrib".} # 53
proc glfwSetWindowUserPointer*(window: GLFWWindow, pointer: pointer): void {.importc: "glfwSetWindowUserPointer".} # 54
proc glfwGetWindowUserPointer*(window: GLFWWindow): pointer {.importc: "glfwGetWindowUserPointer".} # 55
proc glfwSetWindowPosCallback*(window: GLFWWindow, cbfun: GLFWWindowposfun): GLFWWindowposfun {.importc: "glfwSetWindowPosCallback".} # 56
proc glfwSetWindowSizeCallback*(window: GLFWWindow, cbfun: GLFWWindowsizefun): GLFWWindowsizefun {.importc: "glfwSetWindowSizeCallback".} # 57
proc glfwSetWindowCloseCallback*(window: GLFWWindow, cbfun: GLFWWindowclosefun): GLFWWindowclosefun {.importc: "glfwSetWindowCloseCallback".} # 58
proc glfwSetWindowRefreshCallback*(window: GLFWWindow, cbfun: GLFWWindowrefreshfun): GLFWWindowrefreshfun {.importc: "glfwSetWindowRefreshCallback".} # 59
proc glfwSetWindowFocusCallback*(window: GLFWWindow, cbfun: GLFWWindowfocusfun): GLFWWindowfocusfun {.importc: "glfwSetWindowFocusCallback".} # 60
proc glfwSetWindowIconifyCallback*(window: GLFWWindow, cbfun: GLFWWindowiconifyfun): GLFWWindowiconifyfun {.importc: "glfwSetWindowIconifyCallback".} # 61
proc glfwSetWindowMaximizeCallback*(window: GLFWWindow, cbfun: GLFWWindowmaximizefun): GLFWWindowmaximizefun {.importc: "glfwSetWindowMaximizeCallback".} # 62
proc glfwSetFramebufferSizeCallback*(window: GLFWWindow, cbfun: GLFWFramebuffersizefun): GLFWFramebuffersizefun {.importc: "glfwSetFramebufferSizeCallback".} # 63
proc glfwSetWindowContentScaleCallback*(window: GLFWWindow, cbfun: GLFWWindowcontentscalefun): GLFWWindowcontentscalefun {.importc: "glfwSetWindowContentScaleCallback".} # 64
proc glfwPollEvents*(): void {.importc: "glfwPollEvents".} # 65
proc glfwWaitEvents*(): void {.importc: "glfwWaitEvents".} # 66
proc glfwWaitEventsTimeout*(timeout: float64): void {.importc: "glfwWaitEventsTimeout".} # 67
proc glfwPostEmptyEvent*(): void {.importc: "glfwPostEmptyEvent".} # 68
proc glfwGetInputMode*(window: GLFWWindow, mode: int32): int32 {.importc: "glfwGetInputMode".} # 69
proc glfwSetInputMode*(window: GLFWWindow, mode: int32, value: int32): void {.importc: "glfwSetInputMode".} # 70
proc glfwRawMouseMotionSupported*(): int32 {.importc: "glfwRawMouseMotionSupported".} # 71
proc glfwGetKeyName*(key: int32, scancode: int32): cstring {.importc: "glfwGetKeyName".} # 72
proc glfwGetKeyScancode*(key: int32): int32 {.importc: "glfwGetKeyScancode".} # 73
proc glfwGetKey*(window: GLFWWindow, key: int32): int32 {.importc: "glfwGetKey".} # 74
proc glfwGetMouseButton*(window: GLFWWindow, button: int32): int32 {.importc: "glfwGetMouseButton".} # 75
proc glfwGetCursorPos*(window: GLFWWindow, xpos: float64, ypos: float64): void {.importc: "glfwGetCursorPos".} # 76
proc glfwSetCursorPos*(window: GLFWWindow, xpos: float64, ypos: float64): void {.importc: "glfwSetCursorPos".} # 77
proc glfwCreateCursor*(image: GLFWImage, xhot: int32, yhot: int32): GLFWCursor {.importc: "glfwCreateCursor".} # 78
proc glfwCreateStandardCursor*(shape: int32): GLFWCursor {.importc: "glfwCreateStandardCursor".} # 79
proc glfwDestroyCursor*(cursor: GLFWCursor): void {.importc: "glfwDestroyCursor".} # 80
proc glfwSetCursor*(window: GLFWWindow, cursor: GLFWCursor): void {.importc: "glfwSetCursor".} # 81
proc glfwSetKeyCallback*(window: GLFWWindow, cbfun: GLFWKeyfun): GLFWKeyfun {.importc: "glfwSetKeyCallback".} # 82
proc glfwSetCharCallback*(window: GLFWWindow, cbfun: GLFWCharfun): GLFWCharfun {.importc: "glfwSetCharCallback".} # 83
proc glfwSetCharModsCallback*(window: GLFWWindow, cbfun: GLFWCharmodsfun): GLFWCharmodsfun {.importc: "glfwSetCharModsCallback".} # 84
proc glfwSetMouseButtonCallback*(window: GLFWWindow, cbfun: GLFWMousebuttonfun): GLFWMousebuttonfun {.importc: "glfwSetMouseButtonCallback".} # 85
proc glfwSetCursorPosCallback*(window: GLFWWindow, cbfun: GLFWCursorposfun): GLFWCursorposfun {.importc: "glfwSetCursorPosCallback".} # 86
proc glfwSetCursorEnterCallback*(window: GLFWWindow, cbfun: GLFWCursorenterfun): GLFWCursorenterfun {.importc: "glfwSetCursorEnterCallback".} # 87
proc glfwSetScrollCallback*(window: GLFWWindow, cbfun: GLFWScrollfun): GLFWScrollfun {.importc: "glfwSetScrollCallback".} # 88
proc glfwSetDropCallback*(window: GLFWWindow, cbfun: GLFWDropfun): GLFWDropfun {.importc: "glfwSetDropCallback".} # 89
proc glfwJoystickPresent*(jid: int32): int32 {.importc: "glfwJoystickPresent".} # 90
proc glfwGetJoystickAxes*(jid: int32, count: int32): float {.importc: "glfwGetJoystickAxes".} # 91
proc glfwGetJoystickButtons*(jid: int32, count: int32): cuchar {.importc: "glfwGetJoystickButtons".} # 92
proc glfwGetJoystickHats*(jid: int32, count: int32): cuchar {.importc: "glfwGetJoystickHats".} # 93
proc glfwGetJoystickName*(jid: int32): cstring {.importc: "glfwGetJoystickName".} # 94
proc glfwGetJoystickGUID*(jid: int32): cstring {.importc: "glfwGetJoystickGUID".} # 95
proc glfwSetJoystickUserPointer*(jid: int32, pointer: pointer): void {.importc: "glfwSetJoystickUserPointer".} # 96
proc glfwGetJoystickUserPointer*(jid: int32): pointer {.importc: "glfwGetJoystickUserPointer".} # 97
proc glfwJoystickIsGamepad*(jid: int32): int32 {.importc: "glfwJoystickIsGamepad".} # 98
proc glfwSetJoystickCallback*(cbfun: GLFWJoystickfun): GLFWJoystickfun {.importc: "glfwSetJoystickCallback".} # 99
proc glfwUpdateGamepadMappings*(string: cstring): int32 {.importc: "glfwUpdateGamepadMappings".} # 100
proc glfwGetGamepadName*(jid: int32): cstring {.importc: "glfwGetGamepadName".} # 101
proc glfwGetGamepadState*(jid: int32, state: GLFWGamepadstate): int32 {.importc: "glfwGetGamepadState".} # 102
proc glfwSetClipboardString*(window: GLFWWindow, string: cstring): void {.importc: "glfwSetClipboardString".} # 103
proc glfwGetClipboardString*(window: GLFWWindow): cstring {.importc: "glfwGetClipboardString".} # 104
proc glfwGetTime*(): float64 {.importc: "glfwGetTime".} # 105
proc glfwSetTime*(time: float64): void {.importc: "glfwSetTime".} # 106
proc glfwGetTimerValue*(): uint64 {.importc: "glfwGetTimerValue".} # 107
proc glfwGetTimerFrequency*(): uint64 {.importc: "glfwGetTimerFrequency".} # 108
proc glfwMakeContextCurrent*(window: GLFWWindow): void {.importc: "glfwMakeContextCurrent".} # 109
proc glfwGetCurrentContext*(): GLFWWindow {.importc: "glfwGetCurrentContext".} # 110
proc glfwSwapBuffers*(window: GLFWWindow): void {.importc: "glfwSwapBuffers".} # 111
proc glfwSwapInterval*(interval: int32): void {.importc: "glfwSwapInterval".} # 112
proc glfwExtensionSupported*(extension: cstring): int32 {.importc: "glfwExtensionSupported".} # 113
proc glfwGetProcAddress*(procname: cstring): GLFWGlproc {.importc: "glfwGetProcAddress".} # 114
proc glfwVulkanSupported*(): int32 {.importc: "glfwVulkanSupported".} # 115
proc glfwGetRequiredInstanceExtensions*(count: uint32): cstring {.importc: "glfwGetRequiredInstanceExtensions".} # 116

{.pop.}
