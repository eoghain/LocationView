import UIKit
import PlaygroundSupport

class MyViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let samples: [LocationView] = [
            LocationView(items: gradientColor(items: ["This", "is", "a", "test"], color: .red)),
            LocationView(items: gradientColor(items: ["Yet", "another", "test", "but", "blue"], color: .blue)),
            LocationView(items: randomColors(items: ["Random", "colors", "looks", "crazy"])),
            multiWordSections()
        ]
        
        let stackView = UIStackView(arrangedSubviews: samples)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .white
        
        self.view.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func multiWordSections() -> LocationView {
        
        let items = [
            LocationElement(text:"These", backgroundColor: .darkGray, hasArrow: false),
            // Space added or text looks like one word
            LocationElement(text:" together", backgroundColor: .darkGray, hasArrow: true),
            LocationElement(text:"these", backgroundColor: .lightGray, hasArrow: true),
            LocationElement(text:"separate", backgroundColor: .lightGray, hasArrow: true)
        ]
        return LocationView(items: items)
    }
    
    // Helper function for colorization
    func gradientColor(items: [String], color: UIColor) -> [LocationElement] {
        let count = items.count
        let step: CGFloat = CGFloat(0.8) / CGFloat(count)
        
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        // Start at black
        brightness = 1.0
        
        return items.map { (item) in
            let backgroundColor = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
            brightness -= step
            return LocationElement(text: item, textColor: .white, backgroundColor: backgroundColor, hasArrow: true)
        }
    }
    
    func randomColors(items: [String]) -> [LocationElement] {
        return items.map { (item) in
            let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
            let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
            let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
            
            let backgroundColor = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
            return LocationElement(text: item, textColor: .white, backgroundColor: backgroundColor, hasArrow: true)
        }
    }
}

/// LiveView
let viewController = MyViewController()
viewController.view.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
PlaygroundPage.current.liveView = viewController.view

