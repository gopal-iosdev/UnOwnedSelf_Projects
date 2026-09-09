/*:
 [← Previous](@previous)  |  [Home](Introduction)  |  [Next →](@next)
 
 # Singleton
 
 ## <#Description#>
 
 */

import UIKit

var application = UIApplication.shared

class MockApplication: UIApplication {}

demo("Singleton", expecting: "Only one instance of UIApplication") {
    print("application type: ", type(of: application))
    
    application = MockApplication()

    print("application type: ", type(of: application))
}
