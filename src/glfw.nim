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

import ./glfw/private/logo

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
type
  GLFWMonitor* = ptr object
    ## Opaque GLFWmonitor object
  GLFWWindow* = ptr object
    ## Opaque GLFWwindow object
  GLFWCursor* = ptr object
    ## Opaque GLFWcursor object
  GLFWVidMode* = object
    ## This describes a single video mode.
    width*: int32
    height*: int32
    redBits*: int32
    greenBits*: int32
    blueBits*: int32
    refreshRate*: int32
  GLFWGammaRamp* = object
    ## This describes the gamma ramp for a monitor.
    red*: uint16
    green*: uint16
    blue*: uint16
    size*: uint32
  GLFWImage* = object
    ## This describes a single 2D image.
    width*: int32
    height*: int32
    pixels*: ptr cuchar
  GLFWGamepadState* = object
    ## This describes the input state of a gamepad.
    buttons*: array[15, bool]
    axes*: array[6, float32]

type
  GLFWGlProc* = pointer
  GLFWVkProc* = pointer
  GLFWErrorFun* = proc(error: int32, description: cstring): void {.cdecl.}
  GLFWWindowposFun* = proc(window: GLFWWindow, xpos: int32, ypos: int32): void {.cdecl.}
  GLFWWindowsizeFun* = proc(window: GLFWWindow, width: int32, height: int32): void {.cdecl.}
  GLFWWindowcloseFun* = proc(window: GLFWWindow): void {.cdecl.}
  GLFWWindowrefreshFun* = proc(window: GLFWWindow): void {.cdecl.}
  GLFWWindowfocusFun* = proc(window: GLFWWindow, focused: bool): void {.cdecl.}
  GLFWWindowiconifyFun* = proc(window: GLFWWindow, iconified: bool): void {.cdecl.}
  GLFWWindowmaximizeFun* = proc(window: GLFWWindow, iconified: int32): void {.cdecl.}
  GLFWFramebuffersizeFun* = proc(window: GLFWWindow, width: int32, height: int32): void {.cdecl.}
  GLFWWindowcontentscaleFun* = proc(window: GLFWWindow, xscale: float, yscale: float): void {.cdecl.}
  GLFWMousebuttonFun* = proc(window: GLFWWindow, button: int32, action: int32, mods: int32): void {.cdecl.}
  GLFWCursorposFun* = proc(window: GLFWWindow, xpos: float64, ypos: float64): void {.cdecl.}
  GLFWCursorenterFun* = proc(window: GLFWWindow, entered: bool): void {.cdecl.}
  GLFWScrollFun* = proc(window: GLFWWindow, xoffset: float64, yoffset: float64): void {.cdecl.}
  GLFWKeyFun* = proc(window: GLFWWindow, key: int32, scancode: int32, action: int32, mods: int32): void {.cdecl.}
  GLFWCharFun* = proc(window: GLFWWindow, codepoint: uint32): void {.cdecl.}
  GLFWCharmodsFun* = proc(window: GLFWWindow, codepoint: uint32, mods: int32): void {.cdecl.}
  GLFWDropFun* = proc(window: GLFWWindow, count: int32, paths: ptr cstring): void {.cdecl.}
  GLFWMonitorFun* = proc(monitor: GLFWMonitor, event: int32): void {.cdecl.}
  GLFWJoystickFun* = proc(jid: int32, event: int32): void {.cdecl.}

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

# Procs
when defined(glfwDLL):
  {.push dynlib: glfw_dll, cdecl.}
else:
  {.push cdecl.}

proc glfwInit*(): bool {.importc: "glfwInit".}
proc glfwTerminate*(): void {.importc: "glfwTerminate".}
proc glfwInitHint*(hint: int32, value: int32): void {.importc: "glfwInitHint".}
proc glfwGetVersion*(major: ptr int32, minor: ptr int32, rev: ptr int32): void {.importc: "glfwGetVersion".}
proc glfwGetVersionString*(): cstring {.importc: "glfwGetVersionString".}
proc glfwGetError*(description: ptr cstring): int32 {.importc: "glfwGetError".}
proc glfwSetErrorCallback*(cbfun: GLFWErrorfun): GLFWErrorfun {.importc: "glfwSetErrorCallback".}
proc glfwGetMonitors*(count: ptr int32): UncheckedArray[GLFWMonitor] {.importc: "glfwGetMonitors".}
proc glfwGetPrimaryMonitor*(): GLFWMonitor {.importc: "glfwGetPrimaryMonitor".}
proc getMonitorPos*(monitor: GLFWMonitor, xpos: ptr int32, ypos: ptr int32): void {.importc: "glfwGetMonitorPos".}
proc getMonitorWorkarea*(monitor: GLFWMonitor, xpos: ptr int32, ypos: ptr int32, width: ptr int32, height: ptr int32): void {.importc: "glfwGetMonitorWorkarea".}
proc getMonitorPhysicalSize*(monitor: GLFWMonitor, widthMM: ptr int32, heightMM: ptr int32): void {.importc: "glfwGetMonitorPhysicalSize".}
proc getMonitorContentScale*(monitor: GLFWMonitor, xscale: ptr float, yscale: ptr float): void {.importc: "glfwGetMonitorContentScale".}
proc getMonitorName*(monitor: GLFWMonitor): cstring {.importc: "glfwGetMonitorName".}
proc setMonitorUserPointer*(monitor: GLFWMonitor, pointer: pointer): void {.importc: "glfwSetMonitorUserPointer".}
proc getMonitorUserPointer*(monitor: GLFWMonitor): pointer {.importc: "glfwGetMonitorUserPointer".}
proc glfwSetMonitorCallback*(cbfun: GLFWMonitorfun): GLFWMonitorfun {.importc: "glfwSetMonitorCallback".}
proc getVideoModes*(monitor: GLFWMonitor, count: ptr int32): ptr GLFWVidmode {.importc: "glfwGetVideoModes".}
proc getVideoMode*(monitor: GLFWMonitor): ptr GLFWVidmode {.importc: "glfwGetVideoMode".}
proc setGamma*(monitor: GLFWMonitor, gamma: float): void {.importc: "glfwSetGamma".}
proc getGammaRamp*(monitor: GLFWMonitor): ptr GLFWGammaramp {.importc: "glfwGetGammaRamp".}
proc setGammaRamp*(monitor: GLFWMonitor, ramp: ptr GLFWGammaramp): void {.importc: "glfwSetGammaRamp".}
proc glfwDefaultWindowHints*(): void {.importc: "glfwDefaultWindowHints".}
proc glfwWindowHint*(hint: int32, value: int32): void {.importc: "glfwWindowHint".}
proc glfwWindowHintString*(hint: int32, value: cstring): void {.importc: "glfwWindowHintString".}
proc glfwCreateWindowC*(width: int32, height: int32, title: cstring, monitor: GLFWMonitor, share: GLFWWindow): GLFWWindow {.importc: "glfwCreateWindow".}
proc destroyWindow*(window: GLFWWindow): void {.importc: "glfwDestroyWindow".}
proc windowShouldClose*(window: GLFWWindow): bool {.importc: "glfwWindowShouldClose".}
proc setWindowShouldClose*(window: GLFWWindow, value: bool): void {.importc: "glfwSetWindowShouldClose".}
proc setWindowTitle*(window: GLFWWindow, title: cstring): void {.importc: "glfwSetWindowTitle".}
proc setWindowIcon*(window: GLFWWindow, count: int32, images: ptr GLFWImage): void {.importc: "glfwSetWindowIcon".}
proc getWindowPos*(window: GLFWWindow, xpos: ptr int32, ypos: ptr int32): void {.importc: "glfwGetWindowPos".}
proc setWindowPos*(window: GLFWWindow, xpos: int32, ypos: int32): void {.importc: "glfwSetWindowPos".}
proc getWindowSize*(window: GLFWWindow, width: ptr int32, height: ptr int32): void {.importc: "glfwGetWindowSize".}
proc setWindowSizeLimits*(window: GLFWWindow, minwidth: int32, minheight: int32, maxwidth: int32, maxheight: int32): void {.importc: "glfwSetWindowSizeLimits".}
proc setWindowAspectRatio*(window: GLFWWindow, numer: int32, denom: int32): void {.importc: "glfwSetWindowAspectRatio".}
proc setWindowSize*(window: GLFWWindow, width: int32, height: int32): void {.importc: "glfwSetWindowSize".}
proc getFramebufferSize*(window: GLFWWindow, width: ptr int32, height: ptr int32): void {.importc: "glfwGetFramebufferSize".}
proc getWindowFrameSize*(window: GLFWWindow, left: ptr int32, top: ptr int32, right: ptr int32, bottom: ptr int32): void {.importc: "glfwGetWindowFrameSize".}
proc getWindowContentScale*(window: GLFWWindow, xscale: ptr float, yscale: ptr float): void {.importc: "glfwGetWindowContentScale".}
proc getWindowOpacity*(window: GLFWWindow): float {.importc: "glfwGetWindowOpacity".}
proc setWindowOpacity*(window: GLFWWindow, opacity: float): void {.importc: "glfwSetWindowOpacity".}
proc iconifyWindow*(window: GLFWWindow): void {.importc: "glfwIconifyWindow".}
proc restoreWindow*(window: GLFWWindow): void {.importc: "glfwRestoreWindow".}
proc maximizeWindow*(window: GLFWWindow): void {.importc: "glfwMaximizeWindow".}
proc showWindow*(window: GLFWWindow): void {.importc: "glfwShowWindow".}
proc hideWindow*(window: GLFWWindow): void {.importc: "glfwHideWindow".}
proc focusWindow*(window: GLFWWindow): void {.importc: "glfwFocusWindow".}
proc requestWindowAttention*(window: GLFWWindow): void {.importc: "glfwRequestWindowAttention".}
proc getWindowMonitor*(window: GLFWWindow): GLFWMonitor {.importc: "glfwGetWindowMonitor".}
proc setWindowMonitor*(window: GLFWWindow, monitor: GLFWMonitor, xpos: int32, ypos: int32, width: int32, height: int32, refreshRate: int32): void {.importc: "glfwSetWindowMonitor".}
proc getWindowAttrib*(window: GLFWWindow, attrib: int32): int32 {.importc: "glfwGetWindowAttrib".}
proc setWindowAttrib*(window: GLFWWindow, attrib: int32, value: int32): void {.importc: "glfwSetWindowAttrib".}
proc setWindowUserPointer*(window: GLFWWindow, pointer: pointer): void {.importc: "glfwSetWindowUserPointer".}
proc getWindowUserPointer*(window: GLFWWindow): pointer {.importc: "glfwGetWindowUserPointer".}
proc setWindowPosCallback*(window: GLFWWindow, cbfun: GLFWWindowposfun): GLFWWindowposfun {.importc: "glfwSetWindowPosCallback".}
proc setWindowSizeCallback*(window: GLFWWindow, cbfun: GLFWWindowsizefun): GLFWWindowsizefun {.importc: "glfwSetWindowSizeCallback".}
proc setWindowCloseCallback*(window: GLFWWindow, cbfun: GLFWWindowclosefun): GLFWWindowclosefun {.importc: "glfwSetWindowCloseCallback".}
proc setWindowRefreshCallback*(window: GLFWWindow, cbfun: GLFWWindowrefreshfun): GLFWWindowrefreshfun {.importc: "glfwSetWindowRefreshCallback".}
proc setWindowFocusCallback*(window: GLFWWindow, cbfun: GLFWWindowfocusfun): GLFWWindowfocusfun {.importc: "glfwSetWindowFocusCallback".}
proc setWindowIconifyCallback*(window: GLFWWindow, cbfun: GLFWWindowiconifyfun): GLFWWindowiconifyfun {.importc: "glfwSetWindowIconifyCallback".}
proc setWindowMaximizeCallback*(window: GLFWWindow, cbfun: GLFWWindowmaximizefun): GLFWWindowmaximizefun {.importc: "glfwSetWindowMaximizeCallback".}
proc setFramebufferSizeCallback*(window: GLFWWindow, cbfun: GLFWFramebuffersizefun): GLFWFramebuffersizefun {.importc: "glfwSetFramebufferSizeCallback".}
proc setWindowContentScaleCallback*(window: GLFWWindow, cbfun: GLFWWindowcontentscalefun): GLFWWindowcontentscalefun {.importc: "glfwSetWindowContentScaleCallback".}
proc glfwPollEvents*(): void {.importc: "glfwPollEvents".}
proc glfwWaitEvents*(): void {.importc: "glfwWaitEvents".}
proc glfwWaitEventsTimeout*(timeout: float64): void {.importc: "glfwWaitEventsTimeout".}
proc glfwPostEmptyEvent*(): void {.importc: "glfwPostEmptyEvent".}
proc getInputMode*(window: GLFWWindow, mode: int32): int32 {.importc: "glfwGetInputMode".}
proc setInputMode*(window: GLFWWindow, mode: int32, value: int32): void {.importc: "glfwSetInputMode".}
proc glfwRawMouseMotionSupported*(): int32 {.importc: "glfwRawMouseMotionSupported".}
proc glfwGetKeyName*(key: int32, scancode: int32): cstring {.importc: "glfwGetKeyName".}
proc glfwGetKeyScancode*(key: int32): int32 {.importc: "glfwGetKeyScancode".}
proc getKey*(window: GLFWWindow, key: int32): int32 {.importc: "glfwGetKey".}
proc getMouseButton*(window: GLFWWindow, button: int32): int32 {.importc: "glfwGetMouseButton".}
proc getCursorPos*(window: GLFWWindow, xpos: ptr float64, ypos: ptr float64): void {.importc: "glfwGetCursorPos".}
proc setCursorPos*(window: GLFWWindow, xpos: float64, ypos: float64): void {.importc: "glfwSetCursorPos".}
proc createCursor*(image: ptr GLFWImage, xhot: int32, yhot: int32): GLFWCursor {.importc: "glfwCreateCursor".}
proc glfwCreateStandardCursor*(shape: int32): GLFWCursor {.importc: "glfwCreateStandardCursor".}
proc destroyCursor*(cursor: GLFWCursor): void {.importc: "glfwDestroyCursor".}
proc setCursor*(window: GLFWWindow, cursor: GLFWCursor): void {.importc: "glfwSetCursor".}
proc setKeyCallback*(window: GLFWWindow, cbfun: GLFWKeyfun): GLFWKeyfun {.importc: "glfwSetKeyCallback".}
proc setCharCallback*(window: GLFWWindow, cbfun: GLFWCharfun): GLFWCharfun {.importc: "glfwSetCharCallback".}
proc setCharModsCallback*(window: GLFWWindow, cbfun: GLFWCharmodsfun): GLFWCharmodsfun {.importc: "glfwSetCharModsCallback".}
proc setMouseButtonCallback*(window: GLFWWindow, cbfun: GLFWMousebuttonfun): GLFWMousebuttonfun {.importc: "glfwSetMouseButtonCallback".}
proc setCursorPosCallback*(window: GLFWWindow, cbfun: GLFWCursorposfun): GLFWCursorposfun {.importc: "glfwSetCursorPosCallback".}
proc setCursorEnterCallback*(window: GLFWWindow, cbfun: GLFWCursorenterfun): GLFWCursorenterfun {.importc: "glfwSetCursorEnterCallback".}
proc setScrollCallback*(window: GLFWWindow, cbfun: GLFWScrollfun): GLFWScrollfun {.importc: "glfwSetScrollCallback".}
proc setDropCallback*(window: GLFWWindow, cbfun: GLFWDropfun): GLFWDropfun {.importc: "glfwSetDropCallback".}
proc glfwJoystickPresent*(jid: bool): bool {.importc: "glfwJoystickPresent".}
proc glfwGetJoystickAxes*(jid: int32, count: ptr int32): ptr float {.importc: "glfwGetJoystickAxes".}
proc glfwGetJoystickButtons*(jid: int32, count: ptr int32): ptr cuchar {.importc: "glfwGetJoystickButtons".}
proc glfwGetJoystickHats*(jid: int32, count: ptr int32): ptr cuchar {.importc: "glfwGetJoystickHats".}
proc glfwGetJoystickName*(jid: int32): cstring {.importc: "glfwGetJoystickName".}
proc glfwGetJoystickGUID*(jid: int32): cstring {.importc: "glfwGetJoystickGUID".}
proc glfwSetJoystickUserPointer*(jid: int32, pointer: pointer): void {.importc: "glfwSetJoystickUserPointer".}
proc glfwGetJoystickUserPointer*(jid: int32): pointer {.importc: "glfwGetJoystickUserPointer".}
proc glfwJoystickIsGamepad*(jid: int32): int32 {.importc: "glfwJoystickIsGamepad".}
proc glfwSetJoystickCallback*(cbfun: GLFWJoystickfun): GLFWJoystickfun {.importc: "glfwSetJoystickCallback".}
proc glfwUpdateGamepadMappings*(string: cstring): int32 {.importc: "glfwUpdateGamepadMappings".}
proc glfwGetGamepadName*(jid: int32): cstring {.importc: "glfwGetGamepadName".}
proc glfwGetGamepadState*(jid: bool, state: ptr GLFWGamepadstate): bool {.importc: "glfwGetGamepadState".}
proc setClipboardString*(window: GLFWWindow, string: cstring): void {.importc: "glfwSetClipboardString".}
proc getClipboardString*(window: GLFWWindow): cstring {.importc: "glfwGetClipboardString".}
proc glfwGetTime*(): float64 {.importc: "glfwGetTime".}
proc glfwSetTime*(time: float64): void {.importc: "glfwSetTime".}
proc glfwGetTimerValue*(): uint64 {.importc: "glfwGetTimerValue".}
proc glfwGetTimerFrequency*(): uint64 {.importc: "glfwGetTimerFrequency".}
proc makeContextCurrent*(window: GLFWWindow): void {.importc: "glfwMakeContextCurrent".}
proc glfwGetCurrentContext*(): GLFWWindow {.importc: "glfwGetCurrentContext".}
proc swapBuffers*(window: GLFWWindow): void {.importc: "glfwSwapBuffers".}
proc glfwSwapInterval*(interval: int32): void {.importc: "glfwSwapInterval".}
proc glfwExtensionSupported*(extension: cstring): int32 {.importc: "glfwExtensionSupported".}
proc glfwGetProcAddress*(procname: cstring): GLFWGlproc {.importc: "glfwGetProcAddress".}
proc glfwVulkanSupported*(): int32 {.importc: "glfwVulkanSupported".}
proc glfwGetRequiredInstanceExtensions*(count: ptr uint32): ptr cstring {.importc: "glfwGetRequiredInstanceExtensions".}

{.pop.}

proc glfwCreateWindow*(width: int32, height: int32, title: cstring = "NimGL", monitor: GLFWMonitor = nil, share: GLFWWindow = nil, icon: bool = true): GLFWWindow =
  ## Creates a window and its associated OpenGL or OpenGL ES
  ## Utility to create the window with a proper icon.
  result = glfwCreateWindowC(width, height, title, monitor, share)
  if not icon: return result
  var image = GLFWImage(pixels: cast[ptr cuchar](nimglLogo[0].addr), width: nimglLogoWidth, height: nimglLogoHeight)
  result.setWindowIcon(1, image.addr)
