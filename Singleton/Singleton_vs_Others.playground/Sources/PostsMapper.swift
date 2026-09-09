import Foundation

public struct Post {
    let id: Int
    let title: String
    let content: String
    let userId: Int
}

public let fetchPostsURL = URL(string: "https://jsonplaceholder.typicode.com/posts")!

public final class PostsMapper {
    struct RemotePost: Decodable {
        let id: Int
        let title: String
        let body: String
        let userId: Int
        
        var post: Post {
            Post(
                id: id,
                title: title,
                content: body,
                userId: userId
            )
        }
    }
    
    public enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [Post] {
        guard response.isOK else { throw Error.invalidData }

        do {
            let remotePosts = try JSONDecoder().decode([RemotePost].self, from: data)
            return remotePosts.map(\.post)
        } catch let error as DecodingError {
            dump(error)
            throw Error.invalidData
        }
    }
}

public extension URLResponse {
    var httpResponse: HTTPURLResponse {
        get throws {
            guard let httpResponse = self as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            
            return httpResponse
        }
    }
}

private extension HTTPURLResponse {
    var isOK: Bool {
        statusCode == 200
    }
}
