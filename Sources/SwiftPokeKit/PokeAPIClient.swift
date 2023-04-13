import Foundation

public class PokeAPIClient {
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    @available(iOS 15, *)
    public func fetchPokemon(name: String) async throws -> Pokemon {
        let request = PokemonAPIRequest(name: name)
        return try await session.request(request)
    }
    
    // MARK: Private
    
    private let session: URLSession
}
