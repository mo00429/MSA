import Foundation

public protocol UseCase {
    func execute() async -> [Entity]
}


public final class UseCaseImpl: UseCase {
    
    private let repository: Repository
    
    public init(repository: Repository) {
        self.repository = repository
    }
    
    public func execute() async -> [Entity] {
        return await repository.fetchEntities()
    }
}
