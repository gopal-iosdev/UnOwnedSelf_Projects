//: [Previous](@previous)

/*:
 ## weak self
 `[weak self]` breaks the strong reference cycle by making `self` an *Optional* inside the closure.
 `sut` deallocates cleanly, same as `unowned self` - but accessing a deallocated weak reference
 just gives you `nil`, never a crash. This is why `weak` is the generally recommended default
 over `unowned`.

 ![No reference cycle - weak self breaks the strong reference](weak_self.png width="500")
 */

import XCTest

final class HTMLElement: @unchecked Sendable {
    let name: String
    let text: String?
    
    // () -> String, or “a function that takes no parameters, and returns a String value”.
    lazy var asHTML: () -> String = { [weak self] in
        if let self,
           let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self?.name ?? "unknown") />"
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

code(for: "weak self - Breaking the Cycle (Safely)") {
    HTMLElementTests.defaultTestSuite.run()
}
