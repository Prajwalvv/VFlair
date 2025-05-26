//
//  segmentUiView.swift
//  vFlair
//
//  Created by Prajwal V.v on 22/10/18.
//  Copyright © 2018 fluid. All rights reserved.
//

import UIKit
@IBDesignable
class segmentUiView: UIView {
//    var buttons = [UIButton]()
//    var selector: UIView!
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = UIColor.clear{
        didSet{
            layer.borderColor = borderColor.cgColor
        }
    }
    
//    @IBInspectable
//    var commaSeparatedButtonTitles: String = "" {
//        didSet{
//            updateView()
//        }
//    }
    
//    @IBInspectable
//    var textcolor: UIColor? = nil {
//        didSet{
//            updateView()
//        }
//    }
    
//    @IBInspectable
//    var ButtonIMG: UIImage? = nil{
//        didSet{
//            updateView()
//        }
//    }
    
//    @IBInspectable
//    var selectorColor: UIColor = .orange{
//    didSet{
//       updateView()
//        }
//    }
    
//    @IBInspectable
//    var selectorTextColor: UIColor = .white {
//        didSet {
//            updateView()
//        }
//    }
    
    
    
    
    
//    func updateView(){
//        buttons.removeAll()
//        subviews.forEach { $0.removeFromSuperview()}
//
//        let  buttonTitles = commaSeparatedButtonTitles.components(separatedBy: ",")
//
//        for  buttonTitle in buttonTitles {
//            let button = UIButton(type: .custom)
//            button.setTitle(buttonTitle, for: .normal)
//            button.setTitleColor(textcolor, for: .normal)
////            button.setImage(ButtonIMG, for: .normal)
//
//
////            button.setImage(UIImage, for: UIControl.State)
//            buttons.append(button)
//        }
//        let totalWidth = buttonTitles.count
//        let selectorWidth = frame.width / CGFloat(totalWidth)
//        selector = UIView(frame: CGRect(x: 0, y: 0, width: selectorWidth, height: frame.height))
//        selector.backgroundColor = selectorColor
//        addSubview(selector)
        
        
//        let sv = UIStackView(arrangedSubviews: buttons)
//        sv.axis = .horizontal
//        sv.alignment = .fill
//        sv.distribution = .fillProportionally
//        addSubview(sv)
//        sv.translatesAutoresizingMaskIntoConstraints = false
//        sv.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        sv.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        sv.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
//        sv.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
    }
    
    
    
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */


