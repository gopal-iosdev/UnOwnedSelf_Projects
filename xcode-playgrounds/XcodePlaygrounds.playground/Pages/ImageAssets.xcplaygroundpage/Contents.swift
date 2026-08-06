/*:
 [← Previous](@previous)  |  [Home](Introduction)  |  [Next →](@next)
 
 ## Using Image assets in Xcode Playgrounds
 
 ### PNG vs JPEG in Xcode Playgrounds
 
 `UIImage(named:)` picks up a loose `.png` file in `Resources/` by name alone,
 but a loose `.jpeg`/`.jpg` file needs the extension included in the name string.
 This isn't officially documented — just observed behavior.
 
 ### SVG image assets in Xcode Playgrounds
 
 `UIImage(named:)`, `UIImage(data:)`, and `UIImage(contentsOfFile:)` all fail to load a loose `.svg` file.
 SVG only renders when it's added through an Asset Catalog with "Preserve Vector Data" enabled -
 there's no runtime SVG rasterization path for loose files in `Resources/`.
 
 ### Asset Catalog

 Drop a `.xcassets` into `Resources/` and every format resolves — PNG, JPEG, and the `.svg`
 that fails as a loose file — through both `UIImage(named:)` and SwiftUI's `Image("name")`.
 Loose files in `Resources/` only work with `UIImage(named:)`: `Image("name")` reads asset
 catalogs only, so it never sees them.
 
 */

import UIKit
import SwiftUI
import PlaygroundSupport

//: `Resources/` folder

let swiftLogoJPEG = UIImage(named: "Swift_logo_color_jpeg") // nil - fails without the extension

let swiftLogoPNG = UIImage(named: "Swift_logo_color") // works - no extension needed for PNG

let swiftLogoJPEGWorking = UIImage(named: "Swift_logo_color_jpeg.jpeg") // works - extension included

let swiftLogoSVG = UIImage(named: "Swift_logo_color_svg.svg") // nil - SVG isn't supported outside an Asset Catalog

let swiftLogoPNGViaImage = Image("Swift_logo_color") // empty - Image() only reads asset catalogs

//: `AssetCatalog`

let swiftLogoPNGFromAssetCatalogViaUIImage = UIImage(named: "Swift_logo_color_asset_catalog") // works

let swiftLogoPNGFromAssetCatalog = Image( "Swift_logo_color_asset_catalog") // works

let swiftLogoJPEGFromAssetCatalog = Image( "Swift_logo_color_jpeg_asset_catalog") // works

let swiftLogoSVGFromAssetCatalog = Image( "Swift_logo_color_svg_asset_catalog") // works

struct AssetComparisonSwiftUIView: View {
    var body: some View {
        HStack(spacing: 20) {
            VStack(spacing: 20) {
                Text("Resources folder")
                    .font(.callout)
                    .bold()
                    .underline()
                    .foregroundStyle(.red)
                Text("✅ UIImage: PNG, no extension").font(.headline)
                preview(swiftLogoPNG)

                Text("❌ UIImage: JPEG, no extension").font(.headline)
                preview(swiftLogoJPEG)

                Text("✅ UIImage: JPEG with extension").font(.headline)
                preview(swiftLogoJPEGWorking)

                Text("❌ UIImage: SVG").font(.headline)
                preview(swiftLogoSVG)

                Text("❌ Image: PNG").font(.headline)
                preview(swiftLogoPNGViaImage)
            }
            Divider()
            VStack(spacing: 20) {
                Text("Asset Catalog")
                    .font(.callout)
                    .bold()
                    .underline()
                    .foregroundStyle(.green)
                Text("✅ UIImage: PNG").font(.headline)
                preview(swiftLogoPNGFromAssetCatalogViaUIImage)

                Text("✅ Image: PNG").font(.headline)
                preview(swiftLogoPNGFromAssetCatalog)

                Text("✅ Image: JPEG").font(.headline)
                preview(swiftLogoJPEGFromAssetCatalog)

                Text("✅ Image: SVG").font(.headline)
                preview(swiftLogoSVGFromAssetCatalog)
            }
        }
        .padding(10)
        .border(Color.gray, width: 2)
        .cornerRadius(5)
    }
}

PlaygroundPage.current.setLiveView(AssetComparisonSwiftUIView())
