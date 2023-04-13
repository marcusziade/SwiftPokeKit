import Foundation

/// An extension to URLSession for simplifying API requests.
///
/// This extension adds a new method `request` that takes an `APIRequest` and returns a decoded response using the Swift async/await feature.
/// It helps streamline API calls by handling the creation of URLRequest, sending the request, decoding the response, and error handling.
///
/// Usage:
/// 1. Create a struct or class that conforms to the `APIRequest` protocol.
/// 2. Define the required properties and methods for the API request.
/// 3. Call the `request` method on a URLSession instance with the APIRequest object.
/// 4. Use the async/await feature to handle the decoded response or any errors thrown.
///
/// Example:
/// ```
/// struct PokemonAPIRequest: APIRequest {
///     typealias Response = Pokemon
///
///     var method: HTTPMethod { .get }
///     var path: String { "/pokemon/\(name)" }
///     var headers: [String: String]? { nil }
///     var parameters: [String: Any]? { nil }
///
///     let name: String
/// }
///
/// let apiRequest = PokemonAPIRequest(name: "pikachu")
/// let session = URLSession.shared
///
/// do {
///     let pokemon = try await session.request(apiRequest)
///     print("Pokemon: \(pokemon)")
/// } catch {
///     print("Error: \(error)")
/// }
/// ```
///
@available(iOS 15, *)
extension URLSession {
    /// Sends an API request and returns the decoded response using the Swift async/await feature.
    ///
    /// - Parameter request: An object that conforms to the `APIRequest` protocol.
    /// - Returns: A decoded response of type `T.Response` where `T` is the type of `APIRequest`.
    /// - Throws: An error if there is a problem with the URL, network, response status code, or decoding.
    ///
    /// Example:
    /// ```
    /// let apiRequest = PokemonAPIRequest(name: "pikachu")
    /// let session = URLSession.shared
    ///
    /// do {
    ///     let pokemon = try await session.request(apiRequest)
    ///     print("Pokemon: \(pokemon)")
    /// } catch {
    ///     print("Error: \(error)")
    /// }
    /// ```
    func request<T: APIRequest>(_ request: T) async throws -> T.Response {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https" // PokeAPI uses HTTPS
        urlComponents.host = "pokeapi.co"
        urlComponents.path = "/api/v2" + request.path
        
        if let parameters = request.parameters {
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        
        guard let url = urlComponents.url else {
            throw APIError.urlError
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        if let headers = request.headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        let (data, response) = try await data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.networkError(Error.self as! Error)
        }
        
        if (200...299).contains(httpResponse.statusCode) {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.Response.self, from: data)
        } else {
            throw APIError.apiError(httpResponse.statusCode, "Request failed with status code: \(httpResponse.statusCode)")
        }
    }
}
