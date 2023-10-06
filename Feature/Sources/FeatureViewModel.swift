import Foundation

import Domain

public final class FeatureViewModel {
    
    @Published var items: [FeatureItem] = []
    @Published var isLoading: Bool = false
    
    private let useCase: UseCase
    
    public init(useCase: UseCase) {
        self.useCase = useCase
    }
    
    func didLoad() {
        fetchItems()
    }
    
    func fetchItems() {
        guard !isLoading else { return }
        isLoading = true
        items.removeAll()
        
        Task {
            let entities = await useCase.execute()
            isLoading = false
            items = entities.map { $0.toItem() }.shuffled()
        }
    }
}
