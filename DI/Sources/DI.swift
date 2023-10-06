import Foundation

import Feature
import Domain
import Data

public enum DI {
    
    public static func makeFeatureViewController() -> FeatureViewController {
        let repository = RepositoryImpl()
        let useCase = UseCaseImpl(repository: repository)
        let viewModel = FeatureViewModel(useCase: useCase)
        let viewController = FeatureViewController(viewModel: viewModel)
        return viewController
    }
}
