/*:
 [← Previous](@previous)  |  [Home](Introduction)  |  [Next →](@next)
 
 # How to test a singleton candidate
 
 ## <#Description#>
 
 */

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class NetworkManager {
    nonisolated(unsafe) static let shared = NetworkManager()
    init() {}

    func fetchData(from url: URL) async throws -> (Data, HTTPURLResponse) {
        let (data, response) = try await URLSession.shared.data(from: url)
        let httpResponse = try response.httpResponse
        
        return (data, httpResponse)
    }
}

let networkManager = NetworkManager()

do {
    let (postsData, httpResponse) = try await networkManager.fetchData(from: fetchPostsURL)
    
    let posts = try PostsMapper.map(
        postsData,
        from: httpResponse
    )
    print("First Post: ")
    print(posts.first!)
} catch {
    print("Error: \(error)")
}

PlaygroundPage.current.finishExecution()
