/*:
 [← Previous](@previous)  |  [Home](Introduction)  |  [Next →](@next)
 
 # Global shared state
 
 ## <#Description#>
 
 */

import Foundation

var appCache = URLCache.shared

class MockApplicationCache: URLCache, @unchecked Sendable {}

demo("Global shared state", expecting: "Can have more than one instance of URLCache and the shared state can be reset") {
    print("URLCache.shared type: ", type(of: URLCache.shared))
    print("appCache type: ", type(of: appCache))
    
    URLCache.shared = MockApplicationCache()
    appCache = MockApplicationCache()
    
    print("URLCache.shared type: ", type(of: URLCache.shared))
    print("appCache type: ", type(of: appCache))
}
