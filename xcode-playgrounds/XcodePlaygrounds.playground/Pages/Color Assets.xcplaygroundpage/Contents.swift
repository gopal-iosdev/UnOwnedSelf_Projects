/*:
 [← Previous](@previous)  |  [Home](Introduction)  |  [Next →](@next)

 ## Color Assets

 ### No loose-file equivalent

 Unlike images, a color can't live as a loose file in `Resources/` - there's no such thing as a
 standalone color file to drop in. A colorset only exists inside an Asset Catalog, so the
 Resources-vs-Catalog comparison from the Image Assets page doesn't apply here.

 ### Light and dark appearances

 `SwiftBrandOrange` defines two appearances: `#F05138` for Any, `#FF8A65` for Dark. Both resolve
 correctly in a playground - the two columns below render different oranges.

 The two APIs need different mechanisms to get there. SwiftUI's `Color("name")` follows the
 `colorScheme` environment value, while `UIColor(named:)` resolves against a `UITraitCollection` -
 so forcing an appearance in UIKit means calling `resolvedColor(with:)` explicitly.
 */
import UIKit
import SwiftUI
import PlaygroundSupport

//: ### From the Asset Catalog

let colorFromCatalog = UIColor(named: "SwiftBrandOrange") // works

let colorFromCatalogAsColor = Color("SwiftBrandOrange") // works

//: `UIColor` ignores SwiftUI's environment, so each appearance is resolved explicitly.

let colorFromCatalogResolvedLight = colorFromCatalog?
    .resolvedColor(with: UITraitCollection(userInterfaceStyle: .light))

let colorFromCatalogResolvedDark = colorFromCatalog?
    .resolvedColor(with: UITraitCollection(userInterfaceStyle: .dark))

//: ### Programmatic, for comparison - hardcoded per appearance, with no asset involved.

let colorInCodeLight = Color(red: 0.94, green: 0.32, blue: 0.22)

let colorInCodeDark = Color(red: 1.00, green: 0.54, blue: 0.40)

/// A bordered color box. The outline matters: a color that fails to resolve renders as clear
private func colorBox(_ color: Color?, size: CGFloat = 100) -> some View {
    RoundedRectangle(cornerRadius: 8)
        .fill(color ?? .clear)
        .frame(width: size, height: size)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray, lineWidth: 1)
        )
}

private func colorBox(_ color: UIColor?, size: CGFloat = 100) -> some View {
    colorBox(color.map(Color.init), size: size)
}

struct ColorView: View {
    var body: some View {
        HStack(spacing: 20) {
            column(
                title: "Light",
                swiftUIColor: colorFromCatalogAsColor,
                uiKitColor: colorFromCatalogResolvedLight,
                colorInCode: colorInCodeLight,
                background: .white
            )
            .environment(\.colorScheme, .light)

            Divider()

            column(
                title: "Dark",
                swiftUIColor: colorFromCatalogAsColor,
                uiKitColor: colorFromCatalogResolvedDark,
                colorInCode: colorInCodeDark,
                background: .black
            )
            .environment(\.colorScheme, .dark)
        }
        .padding(10)
        .border(Color.gray, width: 2)
        .cornerRadius(5)
    }

    private func column(
        title: String,
        swiftUIColor: Color,
        uiKitColor: UIColor?,
        colorInCode: Color,
        background: Color
    ) -> some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.callout)
                .bold()
                .underline()

            Text("Color(\"name\")").font(.headline)
            colorBox(swiftUIColor)

            Text("UIColor(named:) resolved").font(.headline)
            colorBox(uiKitColor)

            Text("Programmatic").font(.headline)
            colorBox(colorInCode)
        }
        .padding()
        .background(background)
    }
}

demo(
    "Running Color Assets as live view inside a Playground",
    expecting: "SwiftBrandOrange to differ between the Light and Dark columns"
) {
    PlaygroundPage.current.setLiveView(ColorView())
}
