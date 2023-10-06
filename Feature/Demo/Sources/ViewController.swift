import UIKit

import Data
import Domain
import Feature

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapButton() {
        let repository = RepositoryImpl()
        let useCase = UseCaseImpl(repository: repository)
        let viewModel = FeatureViewModel(useCase: useCase)
        let viewController = FeatureViewController(viewModel: viewModel)
        self.present(viewController, animated: true)
    }
}

