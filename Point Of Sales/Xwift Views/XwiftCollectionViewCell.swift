//
//  XwiftCollectionViewCell.swift
//  Point Of Sales
//
//  Created by Aung Thiha on 13/8/20.
//  Copyright © 2020 Aung Thiha. All rights reserved.
//

import UIKit

protocol XwiftCollectionViewCellDelegate {
    
    func addToCart_TouchUpInside(product : Product)
    
}

class XwiftCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    var product : Product {
        get {
            return Product(name: productName.text!, image: productImage.image!, price: Int(productPrice.text!)!, tagID: 0)
        }
    }
    
    var delegate : XwiftCollectionViewCellDelegate?
    
    @IBAction func addToCart_TouchUpInside(_ sender: UIButton) {
        delegate?.addToCart_TouchUpInside(product:  product)
    }
    
    var cornerRadius : CGFloat {
        get {
            return self.contentView.layer.cornerRadius
        }
        set {
            self.contentView.layer.cornerRadius = newValue
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private lazy var gradientLayer: CAGradientLayer = {
        let layerGradient = CAGradientLayer()
        layerGradient.frame = self.bounds
        layerGradient.colors = [productImage.image!.averageColor!.interpolateRGBColorTo(end: .white, fraction: 0.4).cgColor , productImage.image!.averageColor!.interpolateRGBColorTo(end: .black, fraction: 0.4).cgColor]
        layerGradient.startPoint = CGPoint(x: 0.2, y: 0.0)
        layerGradient.endPoint = CGPoint(x: 0.8, y: 1.0)
        layerGradient.cornerRadius = self.cornerRadius
        layer.insertSublayer(layerGradient, at: 0)
        return layerGradient
    }()
    
    func roundCorner(radius cornerRadius : CGFloat, border borderWidth : CGFloat, borderColor : CGColor) {
        
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.borderWidth = borderWidth
        self.contentView.layer.borderColor = borderColor
        self.cornerRadius = cornerRadius
    }
    
    
}

struct ColorComponents {
    var r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat
}

extension UIColor {

    func getComponents() -> ColorComponents {
        if (cgColor.numberOfComponents == 2) {
          let cc = cgColor.components!
          return ColorComponents(r:cc[0], g:cc[0], b:cc[0], a:cc[1])
        }
        else {
          let cc = cgColor.components!
          return ColorComponents(r:cc[0], g:cc[1], b:cc[2], a:cc[3])
        }
    }

    func interpolateRGBColorTo(end: UIColor, fraction: CGFloat) -> UIColor {
        var f = max(0, fraction)
        f = min(1, fraction)

        let c1 = self.getComponents()
        let c2 = end.getComponents()

        let r = c1.r + (c2.r - c1.r) * f
        let g = c1.g + (c2.g - c1.g) * f
        let b = c1.b + (c2.b - c1.b) * f
        let a = c1.a + (c2.a - c1.a) * f

        return UIColor.init(red: r, green: g, blue: b, alpha: a)
    }

}
