/*:
 # Xcode Playgrounds

 A hands-on companion to the blog post ["Getting Real Work Out of Xcode Playgrounds"](https://unownedself.com/tools/xcode-playgrounds/).

 ## Contents

 ### Seeing your work
 - [LiveView SwiftUI](LiveView%20SwiftUI) - rendering a SwiftUI view in the live view
 - [LiveView UIKit](LiveView%20UIKit) - the same thing with a `UIViewController`

 ### Loading assets
 - [Image Assets](Image%20Assets) - loose files vs an Asset Catalog, and which APIs see which
 - [Color Assets](Color%20Assets) - colorsets, and whether light/dark appearances survive
 - [Audio Assets](Audio%20Assets) - `AVAudioPlayer` from `Resources/` and from a Data Set
 - [Video Assets](Video%20Assets) - why `AVPlayer` needs a detour, and why `AVKit` won't load

 ### Testing
 - [Running XCTest](Running%20XCTest) - running a test suite without a test target

 ---

 > **Observed behavior** — after adding any file to a `Resources/` folder, quit and relaunch Xcode
 > before running. Until you do, lookups return `nil` for files that are plainly there. This is the
 > single most likely reason an asset "doesn't load", and it applies to every asset type.
 */
