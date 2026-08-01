/*:
 [← Previous](@previous)  |  [Home](Introduction)  |  [Next →](@next)
 
 ## Live View SwiftUI
 
 In this page, I will be showing examples of how to idea real quick with UI elements in SwiftUI using playgrounds.
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
    "Running SwiftUI ui elements as live view inside a Playground",
    expecting: "swiftLogoSwiftUIView to preview successfully as live view in this playground"
) {
    PlaygroundPage.current.setLiveView(swiftLogoSwiftUIView)
}
