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
  {.pragma: glfw_lib, dynlib: glfw_dll, cdecl.}
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

  {.pragma: glfw_lib, cdecl.}

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