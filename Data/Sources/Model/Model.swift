import Foundation

import Domain
import Util

struct Model: Decodable {
    var name: String?
}

extension Model {
    
    func toDomain() -> Entity {
        return Entity(name: name.orEmpty)
    }
}
