//
//  XwiftCircularButton.swift
//  Point Of Sales
//
//  Created by Aung Thiha on 17/8/20.
//  Copyright © 2020 Aung Thiha. All rights reserved.
//

import UIKit

class XwiftCircularButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var cricularRadius : CGFloat {
        get {
            return 0.5 * self.bounds.size.width
        }
        set {
            self.bounds.size.width = newValue * 2
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private lazy var gradientLayer: CAGradientLayer = {
        let layerGradient = CAGradientLayer()
        layerGradient.frame = self.bounds
        layerGradient.colors = [UIColor.systemBlue.cgColor, UIColor.systemTeal.cgColor]
        layerGradient.startPoint = CGPoint(x: 0, y: 0.3)
        layerGradient.endPoint = CGPoint(x: 1, y: 0.8)
        layerGradient.cornerRadius = self.cricularRadius
        layer.insertSublayer(layerGradient, at: 0)
        return layerGradient
    }()
    
    init(type: UIButton.ButtonType, title: String, target: UIViewController, funcAction: Selector, x:CGFloat, y: CGFloat, diameter: CGFloat, backgroundColor : UIColor) {
        
        super.init(frame : CGRect(x: x, y: y, width: diameter, height: diameter))
        
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.setTitle(title, for: .normal)
        self.addTarget(target, action: funcAction, for: .touchUpInside)
        self.clipsToBounds = true
        self.backgroundColor = backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints(left : CGFloat? = nil, right: CGFloat? = nil, top: CGFloat? = nil, bottom: CGFloat? = nil, width: CGFloat? = nil, height: CGFloat? = nil , view : UIView) {
        
        if let left = left{
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: left).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: right).isActive = true
        }
        if let top = top {
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: top).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom).isActive = true
        }
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
