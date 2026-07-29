//: [Previous](@previous)

/*:
 ## unowned self
 `[unowned self]` breaks the strong reference cycle without making `self` optional -
 it's basically an implicitly-unwrapped weak reference. `sut` deallocates cleanly here,
 same as `weak self` - but accessing an unowned reference *after* deallocation crashes
 at runtime, since there's no optional check to fall back on.

 ![No reference cycle - unowned self breaks the strong reference](unowned_self.png width="500")
 */

import XCTest

final class HTMLElement: @unchecked Sendable {
    let name: String
    let text: String?
    
    // () -> String, or “a function that takes no parameters, and returns a String value”.
    lazy var asHTML: () -> String = { [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
}

class HTMLElementTests: XCTestCase {
    func testSUTSuccessfullyDeInitializedAfterUse() {
        // `sut` here means system under test and `HTMLElement` is our SUT here.
        let sut = makeSUT(name: "p", text: "Hello, world")
        
        XCTAssertEqual(sut.asHTML(), "<p>Hello, world</p>")
    }
    
    private func makeSUT(
        name: String,
        text: String? = nil
    ) -> HTMLElement {
        let sut = HTMLElement(name: name, text: text)
        
        trackForMemoryLeaks(sut)
        
        return sut
    }
}

code(for: "unowned self - Breaking the Cycle (Unsafely)") {
    HTMLElementTests.defaultTestSuite.run()
}

//: [Next](@next)
