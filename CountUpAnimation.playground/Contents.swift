//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport


class CountAnimationLabel: UILabel {
    
    var startTime: CFTimeInterval!
    
    var fromValue: Int!
    var toValue: Int!
    var duration: TimeInterval!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initialSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialSetup()
    }
    
    init() {
        super.init(frame: .zero)
        
        initialSetup()
    }
    
    private func initialSetup() {
        textAlignment = .right
    }
    
    func animate(from fromValue: Int, to toValue: Int, duration: TimeInterval) {
        text = "\(fromValue)"
        
        self.startTime = CACurrentMediaTime()
        
        self.fromValue = fromValue
        self.toValue = toValue
        self.duration = duration
        
        let link = CADisplayLink(target: self, selector: #selector(updateValue))
        link.add(to: .current, forMode: .commonModes)
    }
    
    @objc func updateValue(link: CADisplayLink) {
        let dt = (link.timestamp - self.startTime) / duration
        if dt >= 1.0 {
            text = "\(toValue!)"
            link.invalidate()
            return
        }
        let current = Int(Double(toValue - fromValue) * dt) + fromValue
        text = "\(current)"
        
        //print("\(link.timestamp), \(link.targetTimestamp)")
    }
}

class MyViewController : UIViewController {
    
    var label: CountAnimationLabel!
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        label = CountAnimationLabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        let button = UIButton()
        button.frame = CGRect(x: 150, y: 300, width: 50, height: 20)
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("start!", for: .normal)
        button.addTarget(self, action: #selector(animation), for: .touchUpInside)
        
        view.addSubview(label)
        view.addSubview(button)
        
        self.view = view
    }
    
    @objc func animation() {
        label.animate(from: 150, to: 1030, duration: 3)
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()


