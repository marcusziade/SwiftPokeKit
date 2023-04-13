import Foundation

public class PokeAPIClient {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
}
