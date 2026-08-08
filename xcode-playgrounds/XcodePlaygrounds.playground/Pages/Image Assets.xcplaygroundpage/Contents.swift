/*:
 [← Previous](@previous)  |  [Home](Introduction)  |  [Next →](@next)
 
 ## Image Assets

 ### PNG vs JPEG

 `UIImage(named:)` picks up a loose `.png` file in `Resources/` by name alone,
 but a loose `.jpeg`/`.jpg` file needs the extension included in the name string.
 This isn't officially documented — just observed behavior.

 ### SVG

 `UIImage(named:)`, `UIImage(data:)`, and `UIImage(contentsOfFile:)` all fail to load a loose `.svg` file.
 SVG only renders when it's added through an Asset Catalog with "Preserve Vector Data" enabled -
 there's no runtime SVG rasterization path for loose files in `Resources/`.
 
 ### Asset Catalog

 Drop a `.xcassets` into `Resources/` and every format resolves — PNG, JPEG, and the `.svg`
 that fails as a loose file — through both `UIImage(named:)` and SwiftUI's `Image("name")`.
 Loose files in `Resources/` only work with `UIImage(named:)`: `Image("name")` reads asset
 catalogs only, so it never sees them.

 > **Observed behavior** — after adding a new asset to `Resources/`, quit and relaunch
 > Xcode before running the page. Until you do, the asset often won't be found even though
 > it's sitting right there in the folder.
 
 */
import UIKit
import SwiftUI
import PlaygroundSupport

//: ### Loose files in `Resources/`

let pngFromResources = UIImage(named: "Swift_logo_color") // works - no extension needed for PNG

let jpegFromResources = UIImage(named: "Swift_logo_color_jpeg") // nil - fails without the extension

let jpegFromResourcesWithExt = UIImage(named: "Swift_logo_color_jpeg.jpeg") // works - extension included

let svgFromResources = UIImage(named: "Swift_logo_color_svg.svg") // nil - no runtime SVG decoder

let pngFromResourcesAsImage = Image("Swift_logo_color") // empty - Image() only reads asset catalogs

/*:
 ### From the Asset Catalog

 Each imageset is deliberately named differently from the file inside it -
 `Swift_logo_color_asset_catalog.imageset` holds `Swift_logo_color.png`. Since no file on disk
 is called `Swift_logo_color_asset_catalog.png`, these lookups succeeding proves the catalog's
 asset *names* are being resolved, not filenames.
 */

let pngFromCatalog = UIImage(named: "Swift_logo_color_asset_catalog") // works

let pngFromCatalogAsImage = Image("Swift_logo_color_asset_catalog") // works

let jpegFromCatalogAsImage = Image("Swift_logo_color_jpeg_asset_catalog") // works

let svgFromCatalogAsImage = Image("Swift_logo_color_svg_asset_catalog") // works

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
                preview(pngFromResources)

                Text("❌ UIImage: JPEG, no extension").font(.headline)
                preview(jpegFromResources)

                Text("✅ UIImage: JPEG with extension").font(.headline)
                preview(jpegFromResourcesWithExt)

                Text("❌ UIImage: SVG").font(.headline)
                preview(svgFromResources)

                Text("❌ Image: PNG").font(.headline)
                preview(pngFromResourcesAsImage)
            }
            Divider()
            VStack(spacing: 20) {
                Text("Asset Catalog")
                    .font(.callout)
                    .bold()
                    .underline()
                    .foregroundStyle(.green)
                Text("✅ UIImage: PNG").font(.headline)
                preview(pngFromCatalog)

                Text("✅ Image: PNG").font(.headline)
                preview(pngFromCatalogAsImage)

                Text("✅ Image: JPEG").font(.headline)
                preview(jpegFromCatalogAsImage)

                Text("✅ Image: SVG").font(.headline)
                preview(svgFromCatalogAsImage)
            }
        }
        .padding(10)
        .border(Color.gray, width: 2)
        .cornerRadius(5)
    }
}


demo(
    "Running Image Assets as live view inside a Playground",
    expecting: "AssetComparisonSwiftUIView to preview successfully as live view in this playground"
) {
    PlaygroundPage.current.setLiveView(AssetComparisonSwiftUIView())
}
