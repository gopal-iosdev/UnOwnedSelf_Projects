//: [Previous](@previous)

import UIKit
import SwiftUI
import PlaygroundSupport

/*:
 ## `Image("name")` Doesn't Work in Xcode Playgrounds
 SwiftUI's `Image(_:)` string initializer only resolves names from an Asset Catalog (`.xcassets`),
 and Asset Catalogs aren't supported inside a `.playground` bundle at all - there's no build phase
 for `actool` to compile one into. So `Image("name")` can never load a loose file from `Resources/`,
 not just without extra setup.

 `swiftLogo` (via the `UIImage(named:)` bridge) renders correctly below.
 `swiftLogoNamed` (via `Image("name")`) renders empty, since `"Swift_logo_color"` is never found.

 Note: a playground page only has a single live view slot - calling `setLiveView` twice just
 replaces the first view. To compare both at once, they're composed into one `VStack` below.
 */
let swiftLogoPNGUIImage = UIImage(named: "Swift_logo_color")!

let swiftLogo = Image(uiImage: swiftLogoPNGUIImage)

let swiftLogoNamed = Image("Swift_logo_color", bundle: .main)

let comparisonView = VStack(spacing: 20) {
    VStack(spacing: 20) {
        Text("Works: Image(uiImage:)").font(.headline)
        preview(swiftLogo, size: 200)
    }

    VStack(spacing: 20) {
        Text("Fails: Image(\"name\")").font(.headline)
        preview(swiftLogoNamed, size: 200)
    }
}

PlaygroundPage.current.setLiveView(comparisonView)

//: [Next](@next)
