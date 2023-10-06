import UIKit
import Combine

import DI

// Application에서 하위 Dynamic Framework들을 추가하지 않으면 Linking 에러로 dyld 에러가 발생하므로 추가해줘야한다.

final class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.layer.cornerRadius = 6
    }
    
    @IBAction func didTapFeatureButton() {
        let vc = DI.makeFeatureViewController()
        self.present(vc, animated: true)
    }
}
