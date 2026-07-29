//: [Previous](@previous)

/*:
 # Unowned Self vs Others

 A hands-on companion to the blog post ["Unowned Self in Swift: Why and When to Use It"](https://unownedself.com/posts/unowned-self-swift/).

 ## Contents
 - [Self Type](Self%20Type) - `Self` as a covariant return type
 - [self](self) - the strong reference cycle
 - [unowned self](unowned%20self) - breaking the cycle, unsafely
 - [weak self](weak%20self) - breaking the cycle, safely

 ---

 ## Self Type
 `Self` refers to the type itself, not a specific instance - and unlike hardcoding a class name, it resolves to whichever concrete type is actually calling it. See `HTMLElement.makeDefault()` vs `ParagraphElement.makeDefault()` below.
 */

import XCTest

class HTMLElement {
    static let defaultName = "div"
    static let defaultContent = "Default content"

    let name: String
    let text: String?

    required init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    // `Self` here means "whatever type this method is actually called on" -
    // not hardcoded to HTMLElement. This only matters because HTMLElement
    // is subclassable (not `final`) - see ParagraphElement below.
    static func makeDefault() -> Self {
        Self(name: Self.defaultName, text: Self.defaultContent)
    }
}

class ParagraphElement: HTMLElement {}

class HTMLElementTests: XCTestCase {
    func testMakeDefaultReturnsCallingType() {
        let base = HTMLElement.makeDefault()
        let paragraph = ParagraphElement.makeDefault()

        XCTAssertTrue(type(of: base) == HTMLElement.self)
        XCTAssertTrue(type(of: paragraph) == ParagraphElement.self)
    }
}

code(for: "Self - Covariant Return Type") {
    HTMLElementTests.defaultTestSuite.run()
}

//: [Next](@next)
