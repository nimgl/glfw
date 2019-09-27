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
##
## Also, sorry to let you know that all the refs in this documentation are
## broken so ignore links.

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
    ## @brief The major version number of the GLFW library.
    ##
    ## This is incremented when the API is changed in non-compatible ways.
    ## @ingroup init
  GLFWVersionMinor* = 3
    ## @brief The minor version number of the GLFW library.
    ##
    ## This is incremented when features are added to the API but it remains
    ## backward-compatible.
    ## @ingroup init
  GLFWVersionRevision* = 0
    ## @brief The revision number of the GLFW library.
    ##
    ## This is incremented when a bug fix release is made that does not contain any
    ## API changes.
    ## @ingroup init
  GLFWTrue* = 1
    ## @brief One.
    ##
    ## This is only semantic sugar for the number 1.  You can instead use `1` or
    ## `true` or `_True` or `GL_TRUE` or `VK_TRUE` or anything else that is equal
    ## to one.
    ##
    ## @ingroup init
  GLFWFalse* = 0
    ## @brief Zero.
    ##
    ## This is only semantic sugar for the number 0.  You can instead use `0` or
    ## `false` or `_False` or `GL_FALSE` or `VK_FALSE` or anything else that is
    ## equal to zero.
    ##
    ## @ingroup init
  GLFWRelease* = 0
    ## @brief The key or mouse button was released.
    ##
    ## The key or mouse button was released.
    ##
    ## @ingroup input
  GLFWPress* = 1
    ## @brief The key or mouse button was pressed.
    ##
    ## The key or mouse button was pressed.
    ##
    ## @ingroup input
  GLFWRepeat* = 2
    ## @brief The key was held down until it repeated.
    ##
    ## The key was held down until it repeated.
    ##
    ## @ingroup input
type
  GLFWHat* {.pure, size: int32.sizeof.} = enum
    ## @defgroup hat_state Joystick hat states
    ## @brief Joystick hat states.
    ##
    ## See [joystick hat input](@ref joystick_hat) for how these are used.
    ##
    ## @ingroup input
    Centered = 0
    Up = 1
    Right = 2
    Down = 4
    Left = 8
type
  GLFWKey* {.pure, size: int32.sizeof.} = enum
    ## @defgroup keys Keyboard keys
    ## @brief Keyboard key IDs.
    ##
    ## See [key input](@ref input_key) for how these are used.
    ##
    ## These key codes are inspired by the _USB HID Usage Tables v1.12_ (p. 53-60),
    ## but re-arranged to map to 7-bit ASCII for printable keys (function keys are
    ## put in the 256+ range).
    ##
    ## The naming of the key codes follow these rules:
    ##  - The US keyboard layout is used
    ##  - Names of printable alpha-numeric characters are used (e.g. "A", "R",
    ##    "3", etc.)
    ##  - For non-alphanumeric characters, Unicode:ish names are used (e.g.
    ##    "COMMA", "LEFT_SQUARE_BRACKET", etc.). Note that some names do not
    ##    correspond to the Unicode standard (usually for brevity)
    ##  - Keys that lack a clear US mapping are named "WORLD_x"
    ##  - For non-printable keys, custom names are used (e.g. "F4",
    ##    "BACKSPACE", etc.)
    ##
    ## @ingroup input
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
    ## @brief If this bit is set one or more Shift keys were held down.
    ##
    ## If this bit is set one or more Shift keys were held down.
  GLFWModControl* = 0x0002
    ## @brief If this bit is set one or more Control keys were held down.
    ##
    ## If this bit is set one or more Control keys were held down.
  GLFWModAlt* = 0x0004
    ## @brief If this bit is set one or more Alt keys were held down.
    ##
    ## If this bit is set one or more Alt keys were held down.
  GLFWModSuper* = 0x0008
    ## @brief If this bit is set one or more Super keys were held down.
    ##
    ## If this bit is set one or more Super keys were held down.
  GLFWModCapsLock* = 0x0010
    ## @brief If this bit is set the Caps Lock key is enabled.
    ##
    ## If this bit is set the Caps Lock key is enabled and the @ref
    ## GLFW_LOCK_KEY_MODS input mode is set.
  GLFWModNumLock* = 0x0020
    ## @brief If this bit is set the Num Lock key is enabled.
    ##
    ## If this bit is set the Num Lock key is enabled and the @ref
    ## GLFW_LOCK_KEY_MODS input mode is set.
type
  GLFWMouseButton* {.pure, size: int32.sizeof.} = enum
    ## @defgroup buttons Mouse buttons
    ## @brief Mouse button IDs.
    ##
    ## See [mouse button input](@ref input_mouse_button) for how these are used.
    ##
    ## @ingroup input
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
    ## @defgroup joysticks Joysticks
    ## @brief Joystick IDs.
    ##
    ## See [joystick input](@ref joystick) for how these are used.
    ##
    ## @ingroup input
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
    ## @defgroup gamepad_buttons Gamepad buttons
    ## @brief Gamepad buttons.
    ##
    ## See @ref gamepad for how these are used.
    ##
    ## @ingroup input
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
    ## @defgroup gamepad_axes Gamepad axes
    ## @brief Gamepad axes.
    ##
    ## See @ref gamepad for how these are used.
    ##
    ## @ingroup input
    LeftX = 0
    LeftY = 1
    RightX = 2
    RightY = 3
    LeftTrigger = 4
    RightTrigger = 5
const
  GLFWNoError* = 0
    ## @brief No error has occurred.
    ##
    ## No error has occurred.
    ##
    ## @analysis Yay.
  GLFWNotInitialized* = 0x00010001
    ## @brief GLFW has not been initialized.
    ##
    ## This occurs if a GLFW function was called that must not be called unless the
    ## library is [initialized](@ref intro_init).
    ##
    ## @analysis Application programmer error.  Initialize GLFW before calling any
    ## function that requires initialization.
  GLFWNoCurrentContext* = 0x00010002
    ## @brief No context is current for this thread.
    ##
    ## This occurs if a GLFW function was called that needs and operates on the
    ## current OpenGL or OpenGL ES context but no context is current on the calling
    ## thread.  One such function is @ref glfwSwapInterval.
    ##
    ## @analysis Application programmer error.  Ensure a context is current before
    ## calling functions that require a current context.
  GLFWInvalidEnum* = 0x00010003
    ## @brief One of the arguments to the function was an invalid enum value.
    ##
    ## One of the arguments to the function was an invalid enum value, for example
    ## requesting @ref GLFW_RED_BITS with @ref glfwGetWindowAttrib.
    ##
    ## @analysis Application programmer error.  Fix the offending call.
  GLFWInvalidValue* = 0x00010004
    ## @brief One of the arguments to the function was an invalid value.
    ##
    ## One of the arguments to the function was an invalid value, for example
    ## requesting a non-existent OpenGL or OpenGL ES version like 2.7.
    ##
    ## Requesting a valid but unavailable OpenGL or OpenGL ES version will instead
    ## result in a @ref GLFW_VERSION_UNAVAILABLE error.
    ##
    ## @analysis Application programmer error.  Fix the offending call.
  GLFWOutOfMemory* = 0x00010005
    ## @brief A memory allocation failed.
    ##
    ## A memory allocation failed.
    ##
    ## @analysis A bug in GLFW or the underlying operating system.  Report the bug
    ## to our [issue tracker](https://github.com/glfw/glfw/issues).
  GLFWApiUnavailable* = 0x00010006
    ## @brief GLFW could not find support for the requested API on the system.
    ##
    ## GLFW could not find support for the requested API on the system.
    ##
    ## @analysis The installed graphics driver does not support the requested
    ## API, or does not support it via the chosen context creation backend.
    ## Below are a few examples.
    ##
    ## @par
    ## Some pre-installed Windows graphics drivers do not support OpenGL.  AMD only
    ## supports OpenGL ES via EGL, while Nvidia and Intel only support it via
    ## a WGL or GLX extension.  macOS does not provide OpenGL ES at all.  The Mesa
    ## EGL, OpenGL and OpenGL ES libraries do not interface with the Nvidia binary
    ## driver.  Older graphics drivers do not support Vulkan.
  GLFWVersionUnavailable* = 0x00010007
    ## @brief The requested OpenGL or OpenGL ES version is not available.
    ##
    ## The requested OpenGL or OpenGL ES version (including any requested context
    ## or framebuffer hints) is not available on this machine.
    ##
    ## @analysis The machine does not support your requirements.  If your
    ## application is sufficiently flexible, downgrade your requirements and try
    ## again.  Otherwise, inform the user that their machine does not match your
    ## requirements.
    ##
    ## @par
    ## Future invalid OpenGL and OpenGL ES versions, for example OpenGL 4.8 if 5.0
    ## comes out before the 4.x series gets that far, also fail with this error and
    ## not @ref GLFW_INVALID_VALUE, because GLFW cannot know what future versions
    ## will exist.
  GLFWPlatformError* = 0x00010008
    ## @brief A platform-specific error occurred that does not match any of the
    ## more specific categories.
    ##
    ## A platform-specific error occurred that does not match any of the more
    ## specific categories.
    ##
    ## @analysis A bug or configuration error in GLFW, the underlying operating
    ## system or its drivers, or a lack of required resources.  Report the issue to
    ## our [issue tracker](https://github.com/glfw/glfw/issues).
  GLFWFormatUnavailable* = 0x00010009
    ## @brief The requested format is not supported or available.
    ##
    ## If emitted during window creation, the requested pixel format is not
    ## supported.
    ##
    ## If emitted when querying the clipboard, the contents of the clipboard could
    ## not be converted to the requested format.
    ##
    ## @analysis If emitted during window creation, one or more
    ## [hard constraints](@ref window_hints_hard) did not match any of the
    ## available pixel formats.  If your application is sufficiently flexible,
    ## downgrade your requirements and try again.  Otherwise, inform the user that
    ## their machine does not match your requirements.
    ##
    ## @par
    ## If emitted when querying the clipboard, ignore the error or report it to
    ## the user, as appropriate.
  GLFWNoWindowContext* = 0x0001000A
    ## @brief The specified window does not have an OpenGL or OpenGL ES context.
    ##
    ## A window that does not have an OpenGL or OpenGL ES context was passed to
    ## a function that requires it to have one.
    ##
    ## @analysis Application programmer error.  Fix the offending call.
  GLFWFocused* = 0x00020001
    ## @brief Input focus window hint and attribute
    ##
    ## Input focus [window hint](@ref GLFW_FOCUSED_hint) or
    ## [window attribute](@ref GLFW_FOCUSED_attrib).
  GLFWIconified* = 0x00020002
    ## @brief Window iconification window attribute
    ##
    ## Window iconification [window attribute](@ref GLFW_ICONIFIED_attrib).
  GLFWResizable* = 0x00020003
    ## @brief Window resize-ability window hint and attribute
    ##
    ## Window resize-ability [window hint](@ref GLFW_RESIZABLE_hint) and
    ## [window attribute](@ref GLFW_RESIZABLE_attrib).
  GLFWVisible* = 0x00020004
    ## @brief Window visibility window hint and attribute
    ##
    ## Window visibility [window hint](@ref GLFW_VISIBLE_hint) and
    ## [window attribute](@ref GLFW_VISIBLE_attrib).
  GLFWDecorated* = 0x00020005
    ## @brief Window decoration window hint and attribute
    ##
    ## Window decoration [window hint](@ref GLFW_DECORATED_hint) and
    ## [window attribute](@ref GLFW_DECORATED_attrib).
  GLFWAutoIconify* = 0x00020006
    ## @brief Window auto-iconification window hint and attribute
    ##
    ## Window auto-iconification [window hint](@ref GLFW_AUTO_ICONIFY_hint) and
    ## [window attribute](@ref GLFW_AUTO_ICONIFY_attrib).
  GLFWFloating* = 0x00020007
    ## @brief Window decoration window hint and attribute
    ##
    ## Window decoration [window hint](@ref GLFW_FLOATING_hint) and
    ## [window attribute](@ref GLFW_FLOATING_attrib).
  GLFWMaximized* = 0x00020008
    ## @brief Window maximization window hint and attribute
    ##
    ## Window maximization [window hint](@ref GLFW_MAXIMIZED_hint) and
    ## [window attribute](@ref GLFW_MAXIMIZED_attrib).
  GLFWCenterCursor* = 0x00020009
    ## @brief Cursor centering window hint
    ##
    ## Cursor centering [window hint](@ref GLFW_CENTER_CURSOR_hint).
  GLFWTransparentFramebuffer* = 0x0002000A
    ## @brief Window framebuffer transparency hint and attribute
    ##
    ## Window framebuffer transparency
    ## [window hint](@ref GLFW_TRANSPARENT_FRAMEBUFFER_hint) and
    ## [window attribute](@ref GLFW_TRANSPARENT_FRAMEBUFFER_attrib).
  GLFWHovered* = 0x0002000B
    ## @brief Mouse cursor hover window attribute.
    ##
    ## Mouse cursor hover [window attribute](@ref GLFW_HOVERED_attrib).
  GLFWFocusOnShow* = 0x0002000C
    ## @brief Input focus on calling show window hint and attribute
    ##
    ## Input focus [window hint](@ref GLFW_FOCUS_ON_SHOW_hint) or
    ## [window attribute](@ref GLFW_FOCUS_ON_SHOW_attrib).
  GLFWRedBits* = 0x00021001
    ## @brief Framebuffer bit depth hint.
    ##
    ## Framebuffer bit depth [hint](@ref GLFW_RED_BITS).
  GLFWGreenBits* = 0x00021002
    ## @brief Framebuffer bit depth hint.
    ##
    ## Framebuffer bit depth [hint](@ref GLFW_GREEN_BITS).
  GLFWBlueBits* = 0x00021003
    ## @brief Framebuffer bit depth hint.
    ##
    ## Framebuffer bit depth [hint](@ref GLFW_BLUE_BITS).
  GLFWAlphaBits* = 0x00021004
    ## @brief Framebuffer bit depth hint.
    ##
    ## Framebuffer bit depth [hint](@ref GLFW_ALPHA_BITS).
  GLFWDepthBits* = 0x00021005
    ## @brief Framebuffer bit depth hint.
    ##
    ## Framebuffer bit depth [hint](@ref GLFW_DEPTH_BITS).
  GLFWStencilBits* = 0x00021006
    ## @brief Framebuffer bit depth hint.
    ##
    ## Framebuffer bit depth [hint](@ref GLFW_STENCIL_BITS).
  GLFWAccumRedBits* = 0x00021007
    ## @brief Framebuffer bit depth hint.
    ##
    ## Framebuffer bit depth [hint](@ref GLFW_ACCUM_RED_BITS).
  GLFWAccumGreenBits* = 0x00021008
    ## @brief Framebuffer bit depth hint.
    ##
    ## Framebuffer bit depth [hint](@ref GLFW_ACCUM_GREEN_BITS).
  GLFWAccumBlueBits* = 0x00021009
    ## @brief Framebuffer bit depth hint.
    ##
    ## Framebuffer bit depth [hint](@ref GLFW_ACCUM_BLUE_BITS).
  GLFWAccumAlphaBits* = 0x0002100A
    ## @brief Framebuffer bit depth hint.
    ##
    ## Framebuffer bit depth [hint](@ref GLFW_ACCUM_ALPHA_BITS).
  GLFWAuxBuffers* = 0x0002100B
    ## @brief Framebuffer auxiliary buffer hint.
    ##
    ## Framebuffer auxiliary buffer [hint](@ref GLFW_AUX_BUFFERS).
  GLFWStereo* = 0x0002100C
    ## @brief OpenGL stereoscopic rendering hint.
    ##
    ## OpenGL stereoscopic rendering [hint](@ref GLFW_STEREO).
  GLFWSamples* = 0x0002100D
    ## @brief Framebuffer MSAA samples hint.
    ##
    ## Framebuffer MSAA samples [hint](@ref GLFW_SAMPLES).
  GLFWSrgbCapable* = 0x0002100E
    ## @brief Framebuffer sRGB hint.
    ##
    ## Framebuffer sRGB [hint](@ref GLFW_SRGB_CAPABLE).
  GLFWRefreshRate* = 0x0002100F
    ## @brief Monitor refresh rate hint.
    ##
    ## Monitor refresh rate [hint](@ref GLFW_REFRESH_RATE).
  GLFWDoublebuffer* = 0x00021010
    ## @brief Framebuffer double buffering hint.
    ##
    ## Framebuffer double buffering [hint](@ref GLFW_DOUBLEBUFFER).
  GLFWClientApi* = 0x00022001
    ## @brief Context client API hint and attribute.
    ##
    ## Context client API [hint](@ref GLFW_CLIENT_API_hint) and
    ## [attribute](@ref GLFW_CLIENT_API_attrib).
  GLFWContextVersionMajor* = 0x00022002
    ## @brief Context client API major version hint and attribute.
    ##
    ## Context client API major version [hint](@ref GLFW_CLIENT_API_hint) and
    ## [attribute](@ref GLFW_CLIENT_API_attrib).
  GLFWContextVersionMinor* = 0x00022003
    ## @brief Context client API minor version hint and attribute.
    ##
    ## Context client API minor version [hint](@ref GLFW_CLIENT_API_hint) and
    ## [attribute](@ref GLFW_CLIENT_API_attrib).
  GLFWContextRevision* = 0x00022004
    ## @brief Context client API revision number hint and attribute.
    ##
    ## Context client API revision number [hint](@ref GLFW_CLIENT_API_hint) and
    ## [attribute](@ref GLFW_CLIENT_API_attrib).
  GLFWContextRobustness* = 0x00022005
    ## @brief Context robustness hint and attribute.
    ##
    ## Context client API revision number [hint](@ref GLFW_CLIENT_API_hint) and
    ## [attribute](@ref GLFW_CLIENT_API_attrib).
  GLFWOpenglForwardCompat* = 0x00022006
    ## @brief OpenGL forward-compatibility hint and attribute.
    ##
    ## OpenGL forward-compatibility [hint](@ref GLFW_CLIENT_API_hint) and
    ## [attribute](@ref GLFW_CLIENT_API_attrib).
  GLFWOpenglDebugContext* = 0x00022007
    ## @brief OpenGL debug context hint and attribute.
    ##
    ## OpenGL debug context [hint](@ref GLFW_CLIENT_API_hint) and
    ## [attribute](@ref GLFW_CLIENT_API_attrib).
  GLFWOpenglProfile* = 0x00022008
    ## @brief OpenGL profile hint and attribute.
    ##
    ## OpenGL profile [hint](@ref GLFW_CLIENT_API_hint) and
    ## [attribute](@ref GLFW_CLIENT_API_attrib).
  GLFWContextReleaseBehavior* = 0x00022009
    ## @brief Context flush-on-release hint and attribute.
    ##
    ## Context flush-on-release [hint](@ref GLFW_CLIENT_API_hint) and
    ## [attribute](@ref GLFW_CLIENT_API_attrib).
  GLFWContextNoError* = 0x0002200A
    ## @brief Context error suppression hint and attribute.
    ##
    ## Context error suppression [hint](@ref GLFW_CLIENT_API_hint) and
    ## [attribute](@ref GLFW_CLIENT_API_attrib).
  GLFWContextCreationApi* = 0x0002200B
    ## @brief Context creation API hint and attribute.
    ##
    ## Context creation API [hint](@ref GLFW_CLIENT_API_hint) and
    ## [attribute](@ref GLFW_CLIENT_API_attrib).
  GLFWScaleToMonitor* = 0x0002200C
    ## @brief Window content area scaling window
    ## [window hint](@ref GLFW_SCALE_TO_MONITOR).
  GLFWCocoaRetinaFramebuffer* = 0x00023001
    ## @brief macOS specific
    ## [window hint](@ref GLFW_COCOA_RETINA_FRAMEBUFFER_hint).
  GLFWCocoaFrameName* = 0x00023002
    ## @brief macOS specific
    ## [window hint](@ref GLFW_COCOA_FRAME_NAME_hint).
  GLFWCocoaGraphicsSwitching* = 0x00023003
    ## @brief macOS specific
    ## [window hint](@ref GLFW_COCOA_GRAPHICS_SWITCHING_hint).
  GLFWX11ClassName* = 0x00024001
    ## @brief X11 specific
    ## [window hint](@ref GLFW_X11_CLASS_NAME_hint).
  GLFWX11InstanceName* = 0x00024002
    ## @brief X11 specific
    ## [window hint](@ref GLFW_X11_CLASS_NAME_hint).
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
    ## @brief The regular arrow cursor shape.
    ##
    ## The regular arrow cursor.
  GLFWIbeamCursor* = 0x00036002
    ## @brief The text input I-beam cursor shape.
    ##
    ## The text input I-beam cursor shape.
  GLFWCrosshairCursor* = 0x00036003
    ## @brief The crosshair shape.
    ##
    ## The crosshair shape.
  GLFWHandCursor* = 0x00036004
    ## @brief The hand shape.
    ##
    ## The hand shape.
  GLFWHresizeCursor* = 0x00036005
    ## @brief The horizontal resize arrow shape.
    ##
    ## The horizontal resize arrow shape.
  GLFWVresizeCursor* = 0x00036006
    ## @brief The vertical resize arrow shape.
    ##
    ## The vertical resize arrow shape.
  GLFWConnected* = 0x00040001
  GLFWDisconnected* = 0x00040002
  GLFWJoystickHatButtons* = 0x00050001
    ## @brief Joystick hat buttons init hint.
    ##
    ## Joystick hat buttons [init hint](@ref GLFW_JOYSTICK_HAT_BUTTONS).
  GLFWCocoaChdirResources* = 0x00051001
    ## @brief macOS specific init hint.
    ##
    ## macOS specific [init hint](@ref GLFW_COCOA_CHDIR_RESOURCES_hint).
  GLFWCocoaMenubar* = 0x00051002
    ## @brief macOS specific init hint.
    ##
    ## macOS specific [init hint](@ref GLFW_COCOA_MENUBAR_hint).
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
    ## @brief Client API function pointer type.
    ##
    ## Generic function pointer used for returning client API function pointers
    ## without forcing a cast from a regular pointer.
    ##
    ## @sa @ref context_glext
    ## @sa @ref glfwGetProcAddress
    ##
    ## @since Added in version 3.0.
    ##
    ## @ingroup context
  GLFWVkProc* = proc(): void {.cdecl.}
    ## @brief Vulkan API function pointer type.
    ##
    ## Generic function pointer used for returning Vulkan API function pointers
    ## without forcing a cast from a regular pointer.
    ##
    ## @sa @ref vulkan_proc
    ## @sa @ref glfwGetInstanceProcAddress
    ##
    ## @since Added in version 3.2.
    ##
    ## @ingroup vulkan
  GLFWErrorFun* = proc(error: int32, description: cstring): void {.cdecl.}
    ## @brief The function signature for error callbacks.
    ##
    ## This is the function signature for error callback functions.
    ##
    ## @param[in] error An [error code](@ref errors).
    ## @param[in] description A UTF-8 encoded string describing the error.
    ##
    ## @sa @ref error_handling
    ## @sa @ref glfwSetErrorCallback
    ##
    ## @since Added in version 3.0.
    ##
    ## @ingroup init
  GLFWWindowposFun* = proc(window: GLFWWindow, xpos: int32, ypos: int32): void {.cdecl.}
    ## @brief The function signature for window position callbacks.
    ##
    ## This is the function signature for window position callback functions.
    ##
    ## @param[in] window The window that was moved.
    ## @param[in] xpos The new x-coordinate, in screen coordinates, of the
    ## upper-left corner of the content area of the window.
    ## @param[in] ypos The new y-coordinate, in screen coordinates, of the
    ## upper-left corner of the content area of the window.
    ##
    ## @sa @ref window_pos
    ## @sa @ref glfwSetWindowPosCallback
    ##
    ## @since Added in version 3.0.
    ##
    ## @ingroup window
  GLFWWindowsizeFun* = proc(window: GLFWWindow, width: int32, height: int32): void {.cdecl.}
    ## @brief The function signature for window resize callbacks.
    ##
    ## This is the function signature for window size callback functions.
    ##
    ## @param[in] window The window that was resized.
    ## @param[in] width The new width, in screen coordinates, of the window.
    ## @param[in] height The new height, in screen coordinates, of the window.
    ##
    ## @sa @ref window_size
    ## @sa @ref glfwSetWindowSizeCallback
    ##
    ## @since Added in version 1.0.
    ## @glfw3 Added window handle parameter.
    ##
    ## @ingroup window
  GLFWWindowcloseFun* = proc(window: GLFWWindow): void {.cdecl.}
    ## @brief The function signature for window close callbacks.
    ##
    ## This is the function signature for window close callback functions.
    ##
    ## @param[in] window The window that the user attempted to close.
    ##
    ## @sa @ref window_close
    ## @sa @ref glfwSetWindowCloseCallback
    ##
    ## @since Added in version 2.5.
    ## @glfw3 Added window handle parameter.
    ##
    ## @ingroup window
  GLFWWindowrefreshFun* = proc(window: GLFWWindow): void {.cdecl.}
    ## @brief The function signature for window content refresh callbacks.
    ##
    ## This is the function signature for window refresh callback functions.
    ##
    ## @param[in] window The window whose content needs to be refreshed.
    ##
    ## @sa @ref window_refresh
    ## @sa @ref glfwSetWindowRefreshCallback
    ##
    ## @since Added in version 2.5.
    ## @glfw3 Added window handle parameter.
    ##
    ## @ingroup window
  GLFWWindowfocusFun* = proc(window: GLFWWindow, focused: int32): void {.cdecl.}
    ## @brief The function signature for window focus/defocus callbacks.
    ##
    ## This is the function signature for window focus callback functions.
    ##
    ## @param[in] window The window that gained or lost input focus.
    ## @param[in] focused `GLFW_TRUE` if the window was given input focus, or
    ## `GLFW_FALSE` if it lost it.
    ##
    ## @sa @ref window_focus
    ## @sa @ref glfwSetWindowFocusCallback
    ##
    ## @since Added in version 3.0.
    ##
    ## @ingroup window
  GLFWWindowiconifyFun* = proc(window: GLFWWindow, iconified: int32): void {.cdecl.}
    ## @brief The function signature for window iconify/restore callbacks.
    ##
    ## This is the function signature for window iconify/restore callback
    ## functions.
    ##
    ## @param[in] window The window that was iconified or restored.
    ## @param[in] iconified `GLFW_TRUE` if the window was iconified, or
    ## `GLFW_FALSE` if it was restored.
    ##
    ## @sa @ref window_iconify
    ## @sa @ref glfwSetWindowIconifyCallback
    ##
    ## @since Added in version 3.0.
    ##
    ## @ingroup window
  GLFWWindowmaximizeFun* = proc(window: GLFWWindow, iconified: int32): void {.cdecl.}
    ## @brief The function signature for window maximize/restore callbacks.
    ##
    ## This is the function signature for window maximize/restore callback
    ## functions.
    ##
    ## @param[in] window The window that was maximized or restored.
    ## @param[in] iconified `GLFW_TRUE` if the window was maximized, or
    ## `GLFW_FALSE` if it was restored.
    ##
    ## @sa @ref window_maximize
    ## @sa glfwSetWindowMaximizeCallback
    ##
    ## @since Added in version 3.3.
    ##
    ## @ingroup window
  GLFWFramebuffersizeFun* = proc(window: GLFWWindow, width: int32, height: int32): void {.cdecl.}
    ## @brief The function signature for framebuffer resize callbacks.
    ##
    ## This is the function signature for framebuffer resize callback
    ## functions.
    ##
    ## @param[in] window The window whose framebuffer was resized.
    ## @param[in] width The new width, in pixels, of the framebuffer.
    ## @param[in] height The new height, in pixels, of the framebuffer.
    ##
    ## @sa @ref window_fbsize
    ## @sa @ref glfwSetFramebufferSizeCallback
    ##
    ## @since Added in version 3.0.
    ##
    ## @ingroup window
  GLFWWindowcontentscaleFun* = proc(window: GLFWWindow, xscale: float, yscale: float): void {.cdecl.}
    ## @brief The function signature for window content scale callbacks.
    ##
    ## This is the function signature for window content scale callback
    ## functions.
    ##
    ## @param[in] window The window whose content scale changed.
    ## @param[in] xscale The new x-axis content scale of the window.
    ## @param[in] yscale The new y-axis content scale of the window.
    ##
    ## @sa @ref window_scale
    ## @sa @ref glfwSetWindowContentScaleCallback
    ##
    ## @since Added in version 3.3.
    ##
    ## @ingroup window
  GLFWMousebuttonFun* = proc(window: GLFWWindow, button: int32, action: int32, mods: int32): void {.cdecl.}
    ## @brief The function signature for mouse button callbacks.
    ##
    ## This is the function signature for mouse button callback functions.
    ##
    ## @param[in] window The window that received the event.
    ## @param[in] button The [mouse button](@ref buttons) that was pressed or
    ## released.
    ## @param[in] action One of `GLFW_PRESS` or `GLFW_RELEASE`.
    ## @param[in] mods Bit field describing which [modifier keys](@ref mods) were
    ## held down.
    ##
    ## @sa @ref input_mouse_button
    ## @sa @ref glfwSetMouseButtonCallback
    ##
    ## @since Added in version 1.0.
    ## @glfw3 Added window handle and modifier mask parameters.
    ##
    ## @ingroup input
  GLFWCursorposFun* = proc(window: GLFWWindow, xpos: float64, ypos: float64): void {.cdecl.}
    ## @brief The function signature for cursor position callbacks.
    ##
    ## This is the function signature for cursor position callback functions.
    ##
    ## @param[in] window The window that received the event.
    ## @param[in] xpos The new cursor x-coordinate, relative to the left edge of
    ## the content area.
    ## @param[in] ypos The new cursor y-coordinate, relative to the top edge of the
    ## content area.
    ##
    ## @sa @ref cursor_pos
    ## @sa @ref glfwSetCursorPosCallback
    ##
    ## @since Added in version 3.0.  Replaces `GLFWmouseposfun`.
    ##
    ## @ingroup input
  GLFWCursorenterFun* = proc(window: GLFWWindow, entered: int32): void {.cdecl.}
    ## @brief The function signature for cursor enter/leave callbacks.
    ##
    ## This is the function signature for cursor enter/leave callback functions.
    ##
    ## @param[in] window The window that received the event.
    ## @param[in] entered `GLFW_TRUE` if the cursor entered the window's content
    ## area, or `GLFW_FALSE` if it left it.
    ##
    ## @sa @ref cursor_enter
    ## @sa @ref glfwSetCursorEnterCallback
    ##
    ## @since Added in version 3.0.
    ##
    ## @ingroup input
  GLFWScrollFun* = proc(window: GLFWWindow, xoffset: float64, yoffset: float64): void {.cdecl.}
    ## @brief The function signature for scroll callbacks.
    ##
    ## This is the function signature for scroll callback functions.
    ##
    ## @param[in] window The window that received the event.
    ## @param[in] xoffset The scroll offset along the x-axis.
    ## @param[in] yoffset The scroll offset along the y-axis.
    ##
    ## @sa @ref scrolling
    ## @sa @ref glfwSetScrollCallback
    ##
    ## @since Added in version 3.0.  Replaces `GLFWmousewheelfun`.
    ##
    ## @ingroup input
  GLFWKeyFun* = proc(window: GLFWWindow, key: int32, scancode: int32, action: int32, mods: int32): void {.cdecl.}
    ## @brief The function signature for keyboard key callbacks.
    ##
    ## This is the function signature for keyboard key callback functions.
    ##
    ## @param[in] window The window that received the event.
    ## @param[in] key The [keyboard key](@ref keys) that was pressed or released.
    ## @param[in] scancode The system-specific scancode of the key.
    ## @param[in] action `GLFW_PRESS`, `GLFW_RELEASE` or `GLFW_REPEAT`.
    ## @param[in] mods Bit field describing which [modifier keys](@ref mods) were
    ## held down.
    ##
    ## @sa @ref input_key
    ## @sa @ref glfwSetKeyCallback
    ##
    ## @since Added in version 1.0.
    ## @glfw3 Added window handle, scancode and modifier mask parameters.
    ##
    ## @ingroup input
  GLFWCharFun* = proc(window: GLFWWindow, codepoint: uint32): void {.cdecl.}
    ## @brief The function signature for Unicode character callbacks.
    ##
    ## This is the function signature for Unicode character callback functions.
    ##
    ## @param[in] window The window that received the event.
    ## @param[in] codepoint The Unicode code point of the character.
    ##
    ## @sa @ref input_char
    ## @sa @ref glfwSetCharCallback
    ##
    ## @since Added in version 2.4.
    ## @glfw3 Added window handle parameter.
    ##
    ## @ingroup input
  GLFWCharmodsFun* = proc(window: GLFWWindow, codepoint: uint32, mods: int32): void {.cdecl.}
    ## @brief The function signature for Unicode character with modifiers
    ## callbacks.
    ##
    ## This is the function signature for Unicode character with modifiers callback
    ## functions.  It is called for each input character, regardless of what
    ## modifier keys are held down.
    ##
    ## @param[in] window The window that received the event.
    ## @param[in] codepoint The Unicode code point of the character.
    ## @param[in] mods Bit field describing which [modifier keys](@ref mods) were
    ## held down.
    ##
    ## @sa @ref input_char
    ## @sa @ref glfwSetCharModsCallback
    ##
    ## @deprecated Scheduled for removal in version 4.0.
    ##
    ## @since Added in version 3.1.
    ##
    ## @ingroup input
  GLFWDropFun* = proc(window: GLFWWindow, count: int32, paths: cstring): void {.cdecl.}
    ## @brief The function signature for file drop callbacks.
    ##
    ## This is the function signature for file drop callbacks.
    ##
    ## @param[in] window The window that received the event.
    ## @param[in] count The number of dropped files.
    ## @param[in] paths The UTF-8 encoded file and/or directory path names.
    ##
    ## @sa @ref path_drop
    ## @sa @ref glfwSetDropCallback
    ##
    ## @since Added in version 3.1.
    ##
    ## @ingroup input
  GLFWMonitorFun* = proc(monitor: GLFWMonitor, event: int32): void {.cdecl.}
    ## @brief The function signature for monitor configuration callbacks.
    ##
    ## This is the function signature for monitor configuration callback functions.
    ##
    ## @param[in] monitor The monitor that was connected or disconnected.
    ## @param[in] event One of `GLFW_CONNECTED` or `GLFW_DISCONNECTED`.  Remaining
    ## values reserved for future use.
    ##
    ## @sa @ref monitor_event
    ## @sa @ref glfwSetMonitorCallback
    ##
    ## @since Added in version 3.0.
    ##
    ## @ingroup monitor
  GLFWJoystickFun* = proc(jid: int32, event: int32): void {.cdecl.}
    ## @brief The function signature for joystick configuration callbacks.
    ##
    ## This is the function signature for joystick configuration callback
    ## functions.
    ##
    ## @param[in] jid The joystick that was connected or disconnected.
    ## @param[in] event One of `GLFW_CONNECTED` or `GLFW_DISCONNECTED`.  Remaining
    ## values reserved for future use.
    ##
    ## @sa @ref joystick_event
    ## @sa @ref glfwSetJoystickCallback
    ##
    ## @since Added in version 3.2.
    ##
    ## @ingroup input
