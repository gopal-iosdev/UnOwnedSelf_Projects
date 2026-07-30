import UIKit
import SwiftUI

public func preview(_ image: Image, size: CGFloat = 120) -> AnyView {
    AnyView(
        image
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
    )
}

public func preview(_ image: UIImage?, size: CGFloat = 120) -> AnyView {
    if let image {
        return preview(Image(uiImage: image), size: size)
    } else {
        return AnyView(Color.clear.frame(width: size, height: size))
    }
}
