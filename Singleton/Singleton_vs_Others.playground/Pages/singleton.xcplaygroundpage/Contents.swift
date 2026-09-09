/*:
 [← Previous](@previous)  |  [Home](Introduction)  |  [Next →](@next)
 
 # singleton
 
 ## <#Description#>
 
 */

import Foundation

var session = URLSession.shared
var userDefaults = UserDefaults.standard

class MockURLSession: URLSession, @unchecked Sendable {}
class MockUserDefaults: UserDefaults {}

demo("singleton", expecting: "Can have more than one instance of URLSession/ UserDefaults") {
    print("session type: ", type(of: session))
    print("userDefaults type: ", type(of: userDefaults))
    
    session = MockURLSession()
    userDefaults = MockUserDefaults()

    print("session type: ", type(of: session))
    print("userDefaults type: ", type(of: userDefaults))
}
