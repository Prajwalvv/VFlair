//
//  colours.swift
//  vFlair
//
//  Created by Prajwal V.v on 06/12/18.
//  Copyright © 2018 fluid. All rights reserved.
//

import Foundation
//@IBDesignable class GradientView: UIView {
//    @IBInspectable var firstColor: UIColor = UIColor.red
//    @IBInspectable var secondColor: UIColor = UIColor.green
//
//    @IBInspectable var vertical: Bool = true
//
//    lazy var gradientLayer: CAGradientLayer = {
//        let layer = CAGradientLayer()
//        layer.colors = [firstColor.cgColor, secondColor.cgColor]
//        layer.startPoint = CGPoint.zero
//        return layer
//    }()
//
//    //MARK: -
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//
//        applyGradient()
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        applyGradient()
//    }
//
//    override func prepareForInterfaceBuilder() {
//        super.prepareForInterfaceBuilder()
//        applyGradient()
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        updateGradientFrame()
//    }
//
//    //MARK: -
//
//    func applyGradient() {
//        updateGradientDirection()
//        layer.sublayers = [gradientLayer]
//    }
//
//    func updateGradientFrame() {
//        gradientLayer.frame = bounds
//    }
//
//    func updateGradientDirection() {
//        gradientLayer.endPoint = vertical ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0)
//    }
//}
//
//@IBDesignable class ThreeColorsGradientView: UIView {
//    @IBInspectable var firstColor: UIColor = UIColor.red
//    @IBInspectable var secondColor: UIColor = UIColor.green
//    @IBInspectable var thirdColor: UIColor = UIColor.blue
//
//    @IBInspectable var vertical: Bool = true {
//        didSet {
//            updateGradientDirection()
//        }
//    }
//
//    lazy var gradientLayer: CAGradientLayer = {
//        let layer = CAGradientLayer()
//        layer.colors = [firstColor.cgColor, secondColor.cgColor, thirdColor.cgColor]
//        layer.startPoint = CGPoint.zero
//        return layer
//    }()
//
//    //MARK: -
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//
//        applyGradient()
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        applyGradient()
//    }
//
//    override func prepareForInterfaceBuilder() {
//        super.prepareForInterfaceBuilder()
//        applyGradient()
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        updateGradientFrame()
//    }
//
//    //MARK: -
//
//    func applyGradient() {
//        updateGradientDirection()
//        layer.sublayers = [gradientLayer]
//    }
//
//    func updateGradientFrame() {
//        gradientLayer.frame = bounds
//    }
//
//    func updateGradientDirection() {
//        gradientLayer.endPoint = vertical ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0)
//    }
//}
//
//@IBDesignable class RadialGradientView: UIView {
//
//    @IBInspectable var outsideColor: UIColor = UIColor.red
//    @IBInspectable var insideColor: UIColor = UIColor.green
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        applyGradient()
//    }
//
//    func applyGradient() {
//        let colors = [insideColor.cgColor, outsideColor.cgColor] as CFArray
//        let endRadius = sqrt(pow(frame.width/2, 2) + pow(frame.height/2, 2))
//        let center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
//        let gradient = CGGradient(colorsSpace: nil, colors: colors, locations: nil)
//        let context = UIGraphicsGetCurrentContext()
//
//        context?.drawRadialGradient(gradient!, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: endRadius, options: CGGradientDrawingOptions.drawsBeforeStartLocation)
//    }
//
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//
//        #if TARGET_INTERFACE_BUILDER
//        applyGradient()
//        #endif
//    }
//}
//class GradientView: UIView {
//
//    override open class var layerClass: AnyClass {
//        get{
//            return CAGradientLayer.classForCoder()
//        }
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        let gradientLayer = self.layer as! CAGradientLayer
//        let color1 = UIColor.blue.withAlphaComponent(0.1).cgColor as CGColor
//        let color2 = UIColor.green.withAlphaComponent(0.9).cgColor as CGColor
//        gradientLayer.locations = [0.20, 1.0]
//        gradientLayer.colors = [color2, color1]
//    }
//}
