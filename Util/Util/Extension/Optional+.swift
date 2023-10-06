import Foundation

extension Optional where Wrapped == String {
    
    public var orEmpty: String {
        switch self {
        case .none:
            return ""
        case .some(let wrapped):
            return wrapped
        }
    }
}
