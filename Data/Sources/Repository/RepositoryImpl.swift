import Foundation

import Domain

public final class RepositoryImpl: Repository {
    
    private let networkService: NetworkService
    
    public init(networkService: NetworkService = NetworkServiceImpl.shared) {
        self.networkService = networkService
    }
    
    public func fetchEntities() async -> [Entity] {
        //networkService.send(target) ...
        
        try? await Task.sleep(for: .seconds(2))
        return await withCheckedContinuation { continuation in
            let sampleModels: [Model] = (0...20).map {
                Model(name: "테스트 \($0)")
            }
            continuation.resume(returning: sampleModels.map { $0.toDomain() })
        }
    }
}
