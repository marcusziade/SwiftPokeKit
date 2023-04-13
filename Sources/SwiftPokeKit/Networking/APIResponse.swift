import Foundation

public enum APIResponse<T> {
    case success(T)
    case failure(Error)
    case noData
}
