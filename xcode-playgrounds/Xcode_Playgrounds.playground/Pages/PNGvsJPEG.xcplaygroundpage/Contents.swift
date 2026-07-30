//: [Previous](@previous)

import UIKit
import SwiftUI
import PlaygroundSupport

/*:
 ## PNG vs JPEG in Xcode Playgrounds
 `UIImage(named:)` picks up a loose `.png` file in `Resources/` by name alone,
 but a loose `.jpeg`/`.jpg` file needs the extension included in the name string.
 This isn't officially documented — just observed behavior.
 */
let swiftLogoJPEG = UIImage(named: "Swift_logo_color_jpeg") // nil - fails without the extension

let swiftLogoPNG = UIImage(named: "Swift_logo_color") // works - no extension needed for PNG

let swiftLogoJPEGWorking = UIImage(named: "Swift_logo_color_jpeg.jpeg") // works - extension included

let comparisonView = VStack(spacing: 20) {
    Text("Works: PNG without extension").font(.headline)
    preview(swiftLogoPNG)

    Text("Fails: JPEG without extension").font(.headline)
    preview(swiftLogoJPEG)

    Text("Works: JPEG with extension").font(.headline)
    preview(swiftLogoJPEGWorking)
}

PlaygroundPage.current.setLiveView(comparisonView)

//: [Next](@next)
