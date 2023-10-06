import Foundation

public protocol NetworkService {
    func send<Target: TargetType>(_ target: Target) async throws -> Data
}


public final class NetworkServiceImpl: NetworkService {
    
    public static let shared: NetworkServiceImpl = .init()
    
    private init() {}
    
    public func send<Target: TargetType>(_ target: Target) async throws -> Data {
        let url = target.baseURL.appending(path: target.path)
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
