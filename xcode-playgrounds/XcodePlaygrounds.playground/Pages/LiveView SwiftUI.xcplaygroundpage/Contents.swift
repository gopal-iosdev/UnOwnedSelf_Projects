/*:
 [← Previous](@previous)  |  [Home](Introduction)  |  [Next →](@next)
 
 ## Live View SwiftUI

 The quickest way to try a SwiftUI view: hand it to `setLiveView` and it renders right there,
 with no app target to build first. Edit the view and the live view redraws as you type.
 */
import PlaygroundSupport
import SwiftUI

let swiftLogoPNG = UIImage(named: "Swift_logo_color")

struct SwiftLogoSwiftUIView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Swift Logo Image View")
            preview(swiftLogoPNG)
        }
        .padding(10)
        .border(Color.gray, width: 2)
        .cornerRadius(5)
    }
}

let swiftLogoSwiftUIView = SwiftLogoSwiftUIView()

demo(
    "Rendering a SwiftUI view in the live view",
    expecting: "the Swift logo to appear inside a bordered box"
) {
    PlaygroundPage.current.setLiveView(swiftLogoSwiftUIView)
}
