import Foundation

@available(iOS 15, *)
@available(macOS 12, *)
public class PokeAPIClient {
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func fetchPokemon(name: String) async throws -> Pokemon {
        let request = PokemonAPIRequest(name: name)
        return try await session.request(request)
    }
    
    // MARK: Private
    
    private let session: URLSession
}
