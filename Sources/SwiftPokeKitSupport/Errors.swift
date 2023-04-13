import Foundation

public enum APIError: Error {
    case urlError
    case networkError(Error)
    case decodingError(Error)
    case apiError(Int, String)
}
