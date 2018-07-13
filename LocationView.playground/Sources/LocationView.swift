import UIKit

public class LocationView: UIView {
    private var stackView = UIStackView(arrangedSubviews: [])
    
    public var items: [LocationElement] {
        didSet {
            setup()
        }
    }
    
    public init(frame: CGRect, items: [LocationElement]) {
        self.items = items
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setup()
    }
    
    public convenience init(items: [LocationElement]) {
        self.init(frame: .zero, items: items)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        if let items = aDecoder.value(forKey: "items") as? [LocationElement] {
            self.items = items
        } else {
            self.items = []
        }
        
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        stackView.removeFromSuperview()
        
        stackView = UIStackView(arrangedSubviews: views())
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        stackView.backgroundColor = .white
        
        self.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true        
    }
    
    private func views() -> [UIView] {
        var views:[UIView] = []
        var lastItem: LocationElement?
        var inset: CGFloat = 0.0
        
        items.forEach { (item) in
            if let lastItem = lastItem, lastItem.hasArrow == true {
                views.append(arrow(color1: lastItem.backgroundColor, color2: item.backgroundColor))
            }
            
            views.append(container(for: item, inset: inset))
            lastItem = item
            inset = 10
        }
        
        if !views.isEmpty {
            let leftEnd = LeftEndCap(frame: .zero)
            leftEnd.backgroundColor = views.first?.backgroundColor ?? .clear
            leftEnd.widthAnchor.constraint(equalToConstant: 20).isActive = true
            views.insert(leftEnd, at: 0)
            
            let rightEnd = RightEndCap(frame: .zero)
            rightEnd.backgroundColor = views.last?.backgroundColor ?? .clear
            rightEnd.widthAnchor.constraint(equalToConstant: 20).isActive = true
            views.append(rightEnd)
        }
        
        return views
    }
    
    private func arrow(color1: UIColor, color2: UIColor) -> ArrowView {
        let arrowView = ArrowView(color: color1)
        arrowView.clipsToBounds = false
        arrowView.backgroundColor = color2
        arrowView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        return arrowView
    }
    
    private func container(for item: LocationElement, inset: CGFloat) -> UIView {
        let container = UIView(frame: .zero)
        container.backgroundColor = item.backgroundColor
        
        let label = self.label(for: item)
        container.addSubview(label)
        label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: inset).isActive = true
        label.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        
        container.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        return container
    }
    
    private func label(for item: LocationElement) -> UILabel {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = item.font
        label.textColor = item.textColor
        label.text = item.text
        return label
    }
}
