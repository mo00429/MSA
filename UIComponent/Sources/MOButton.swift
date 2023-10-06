import UIKit

open class MOButton: UIButton {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGreen
        layer.cornerRadius = 6
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
