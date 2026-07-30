//: [Previous](@previous)

import UIKit
import SwiftUI
import PlaygroundSupport

/*:
 ## SVG Not Supported in Xcode Playgrounds
 `UIImage(named:)`, `UIImage(data:)`, and `UIImage(contentsOfFile:)` all fail to load a loose `.svg` file.
 SVG only renders when it's added through an Asset Catalog with "Preserve Vector Data" enabled -
 there's no runtime SVG rasterization path for loose files in `Resources/`.
 */
let swiftLogoSVG = UIImage(named: "Swift_logo_color_svg.svg") // nil - SVG isn't supported outside an Asset Catalog

let comparisonView = VStack(spacing: 20) {
    Text("Fails: SVG isn't supported outside an Asset Catalog").font(.headline)
    preview(swiftLogoSVG)
}

PlaygroundPage.current.setLiveView(comparisonView)

//: [Next](@next)
