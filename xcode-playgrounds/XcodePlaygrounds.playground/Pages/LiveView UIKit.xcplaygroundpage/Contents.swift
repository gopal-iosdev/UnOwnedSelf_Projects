/*:
 [← Previous](@previous)  |  [Home](Introduction)  |  [Next →](@next)
 
 ## Live View UIKit

 The same idea in UIKit. `PlaygroundPage.current.liveView` takes a `UIView` or a
 `UIViewController` directly, so a stack view renders exactly the way a SwiftUI `View` does -
 note it's assigned to `liveView` rather than passed to `setLiveView`.
 */
import PlaygroundSupport
import UIKit

let swiftLogoPNG = UIImage(named: "Swift_logo_color")

final class SwiftLogoUIKitView: UIStackView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Swift Logo Image View"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: swiftLogoPNG)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    private func configure() {
        axis = .vertical
        spacing = 10

        isLayoutMarginsRelativeArrangement = true
        layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        backgroundColor = .white
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 5
        clipsToBounds = true

        addArrangedSubview(titleLabel)
        addArrangedSubview(logoImageView)
    }
}

let swiftLogoUIKitView = SwiftLogoUIKitView(
    frame: .init(x: 0, y: 0, width: 200, height: 170)
)

demo(
    "Rendering a UIKit view in the live view",
    expecting: "the Swift logo to appear inside a bordered stack view"
) {
    PlaygroundPage.current.liveView = swiftLogoUIKitView
}
