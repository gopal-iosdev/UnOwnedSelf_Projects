/*:
 [← Previous](@previous)  |  [Home](Introduction)  |  [Next →](@next)
 
 # singleton
 
 ## <#Description#>
 
 */

import Foundation


// iOS Foundation Library Example

var session = URLSession()
var session2 = URLSession.shared

var userDefaults = UserDefaults()
var userDefaults2 = UserDefaults.standard

print(type(of: session))
print(type(of: session2))

print(type(of: userDefaults))
print(type(of: userDefaults2))

class MockURLSession: URLSession {}

class MockUserDefaults: UserDefaults {}

session = MockURLSession()
session2 = MockURLSession()

userDefaults = MockUserDefaults()
userDefaults2 = MockUserDefaults()

print(type(of: session))
print(type(of: session2))

print(type(of: userDefaults))
print(type(of: userDefaults2))
