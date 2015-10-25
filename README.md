# PonyDebuggerApp
A host app for Pony Debugger

### Motivation:
I _love_ how with Reveal I can include one breakpoint in Xcode and Reveal is included in every iOS/tvOS app I debug. I wish there was the same for PonyDebugger.

### Currently:

This Mac app hosts `PonyDebugger.framework` and `SocketRocket.framework` at the minute. It does this via a `post_install` hook in the Podfile.

This means you can add a symbolic breakpoint on `UIApplicationMain` that runs `expr (void*)dlopen("/Applications/PonyDebugger.app/Contents/Resources/PonyDebugger.framework", 0x2);` and another for `expr (void*)dlopen("/Applications/PonyDebugger.app/Contents/Resources/SocketRocket.framework", 0x2);`.

Aims:
 * Have the Mac app run `ponyd` for you, and close it when the app closes
 * Have the Mac app host something that means you only need to use one of the above commands, and that it also runs the default "start script."
 * (far off) Have the Mac app host `ponyd` and friends.

PRs welcome on any of these ^
