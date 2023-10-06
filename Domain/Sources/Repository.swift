import Foundation

public protocol Repository {
    
    func fetchEntities() async -> [Entity]
}
