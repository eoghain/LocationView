import UIKit

public class ArrowView: UIView {
    
    public var arrowColor: UIColor = .white
    
    public init(frame: CGRect, color: UIColor) {
        arrowColor = color
        super.init(frame: frame)
        clipsToBounds = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public convenience init(color: UIColor) {
        self.init(frame: .zero, color: color)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        let pointLength = (self.bounds.maxY - self.bounds.minY) / 2
        let pointInset: CGFloat = 3.0
        
        let shadow = UIColor.black
        let shadowOffset = CGSize(width: 1, height: 0)
        let shadowBlurRadius: CGFloat = 3.0
        
        context?.setShadow(offset: shadowOffset, blur: shadowBlurRadius, color:shadow.cgColor)
        
        let fillPath = UIBezierPath()
        fillPath.move(to: CGPoint(x: self.bounds.minX, y: self.bounds.minY))
        fillPath.addLine(to: CGPoint(x: self.bounds.minX, y: self.bounds.maxY))
        fillPath.addLine(to: CGPoint(x: self.bounds.maxX - (pointLength + pointInset), y: self.bounds.maxY))
        fillPath.addLine(to: CGPoint(x: self.bounds.maxX - pointInset, y: self.bounds.midY))
        fillPath.addLine(to: CGPoint(x: self.bounds.maxX - (pointLength + pointInset), y: self.bounds.minY))
        fillPath.close()
        
        let color = self.arrowColor.cgColor
        context?.addPath(fillPath.cgPath)
        context?.setFillColor(color)
        context?.fillPath()
    }
}
