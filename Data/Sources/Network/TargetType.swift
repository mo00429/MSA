import Foundation

public protocol TargetType {
    var baseURL: URL { get }
    var path: String { get }
}
