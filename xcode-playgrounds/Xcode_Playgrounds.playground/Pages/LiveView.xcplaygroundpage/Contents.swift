/*:
 [← Previous](@previous)  |  [Home](Introduction)  |  [Next →](@next)
 
 ## Live View
 
 <#Description#>
 */

import PlaygroundSupport
import UIKit
import SwiftUI

let swiftLogoPNG = UIImage(named: "Swift_logo_color")

class SwiftLogoUIKitView: UIStackView {
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .init(x: 0, y: 0, width: 200, height: 100))
        label.text = "Swift Logo Image View"
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(
            frame: .init(x: 0, y: 0, width: 200, height: 200)
        )
        imageView.image = swiftLogoPNG
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.axis = .vertical
        self.spacing = 20
        self.addSubview(titleLabel)
        self.addSubview(logoImageView)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}

let swiftLogoUIImageView = SwiftLogoUIKitView(frame: .init(x: 0, y: 0, width: 240, height: 300))

let swiftLogoSwiftUIView = VStack(spacing: 20) {
    Text("Swift Logo Image View").font(.headline)
    preview(swiftLogoPNG)
}

//PlaygroundPage.current.setLiveView(swiftLogoSwiftUIView)

PlaygroundPage.current.liveView = swiftLogoUIImageView
