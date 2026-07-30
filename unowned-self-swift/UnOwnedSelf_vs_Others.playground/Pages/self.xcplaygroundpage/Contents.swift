/*:
 [← Previous](@previous)  |  [Home](Introduction)  |  [Next →](@next)
 
 ## self
 
 Capturing `self` with no capture list keeps a **strong** reference to `self` inside the closure.
 Since `asHTML` is stored *on* `self`, this creates a cycle: `self` → `asHTML` closure → `self`.
 Neither side can ever reach a reference count of zero, so `sut` never deallocates - a memory leak.

 ![Strong reference cycle between HTMLElement and its closure via self](self.png)
 */

import XCTest

final class HTMLElement: @unchecked Sendable {
    let name: String
    let text: String?
    
    // () -> String, or “a function that takes no parameters, and returns a String value”.
    lazy var asHTML: () -> String = {
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

demo(
    "self - Strong Reference Cycle",
    expecting: "sut does NOT deallocate (leak)"
) {
    HTMLElementTests.defaultTestSuite.run()
}
