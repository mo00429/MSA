import Foundation

import Domain

struct FeatureItem: Equatable {
    let name: String
}


extension Entity {
    
    func toItem() -> FeatureItem {
        return FeatureItem(name: name)
    }
}
