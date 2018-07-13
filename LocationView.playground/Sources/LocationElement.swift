import UIKit

public struct LocationElement {
    public let text: String
    public var textColor: UIColor
    public var backgroundColor: UIColor
    public let hasArrow: Bool
    public var font: UIFont
    
    public init(text: String, textColor: UIColor = .white, backgroundColor: UIColor = .cyan, hasArrow: Bool = false, font: UIFont = UIFont.systemFont(ofSize: 12, weight: .bold)) {
        
        self.text = text
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.hasArrow = hasArrow
        self.font = font
    }
}
