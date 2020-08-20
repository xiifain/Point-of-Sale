//
//  ViewController.swift
//  Point Of Sales
//
//  Created by Aung Thiha on 4/8/20.
//  Copyright © 2020 Aung Thiha. All rights reserved.
//

import UIKit
struct Product : Equatable {
    
    var name : String
    var image: UIImage
    var price : Int
    var tagID : Int
}


class ViewController: UIViewController {
    
    var cart : [Product] = []
    var anotherProductList : [Product] = [
    Product(name: "Americano", image: #imageLiteral(resourceName: "diamond"), price: 250, tagID: 0),
    Product(name: "Cappucino", image: #imageLiteral(resourceName: "Americano"), price: 250, tagID: 0),
    Product(name: "Latte", image: #imageLiteral(resourceName: "Americano"), price: 250, tagID: 0),
    Product(name: "Cold Brew", image: #imageLiteral(resourceName: "diamond"), price: 250, tagID: 0),
    Product(name: "Nitro BRew", image: #imageLiteral(resourceName: "Americano"), price: 250, tagID: 0),
    Product(name: "Americano", image: #imageLiteral(resourceName: "diamond"), price: 250, tagID: 0),
    Product(name: "Cappucino", image: #imageLiteral(resourceName: "Americano"), price: 250, tagID: 0),
    Product(name: "Latte", image: #imageLiteral(resourceName: "Americano"), price: 250, tagID: 0),
    Product(name: "Cold Brew", image: #imageLiteral(resourceName: "diamond"), price: 250, tagID: 0),
    Product(name: "Nitro BRew", image: #imageLiteral(resourceName: "Americano"), price: 250, tagID: 0),

    ]

    @IBOutlet weak var productCollectionView: UICollectionView!
    
    @IBOutlet weak var addProductForm: UIView!
    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var productPrice: UITextField!
    @IBOutlet weak var centreConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var testCart: UIButton!
    
    @IBAction func testFuncForCart(_ sender: UIButton){
        
        print("HELLO")
    }
    @IBAction func addProduct(_ sender: UIButton) {
        
        if let name = productName.text , let price = productPrice.text {
            
            anotherProductList.append(Product(name: name, image: #imageLiteral(resourceName: "Americano"), price: Int(price)!, tagID: anotherProductList.count + 1))
            productCollectionView.reloadData()
            showAddProductFormView()
            productName.text?.removeAll()
            productPrice.text?.removeAll()
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productCollectionView.delegate = self
        productCollectionView.dataSource = self

        productCollectionView.showsVerticalScrollIndicator = false

        let xwiftTestButton = XwiftCircularButton(type: .custom, title: "", target: self, funcAction: #selector(showAddProductFormView), x: 150, y: 150, diameter: 75 , backgroundColor: .clear)
        xwiftTestButton.setImage(#imageLiteral(resourceName: "Add Button"), for:.normal)
        view.addSubview(xwiftTestButton)

        xwiftTestButton.translatesAutoresizingMaskIntoConstraints = false
        xwiftTestButton.setConstraints(right: -20, bottom: -20, width: 60, height: 60, view: view!)

        xwiftTestButton.layer.shadowOpacity = 0.5
        xwiftTestButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        xwiftTestButton.layer.shadowColor = UIColor.gray.cgColor
        xwiftTestButton.layer.masksToBounds = false
        
        addProductForm.backgroundColor = .white
        addProductForm.layer.cornerRadius = 10.0
        addProductForm.layer.masksToBounds = true
        
        addProductForm.layer.shadowOpacity = 0.4
        addProductForm.layer.shadowOffset = CGSize(width: 3, height: 3)
        addProductForm.layer.shadowColor = UIColor.gray.cgColor
        addProductForm.layer.masksToBounds = false
        
        testCart.layer.opacity = 0.0
        
        let image : UIImage = #imageLiteral(resourceName: "Americano")
        
        addProductForm.layer.backgroundColor = image.averageColor?.cgColor
        
                
    }
    
    @objc func showAddProductFormView() {

        if centreConstraint.constant == -600 {
            centreConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                
                self.view.layoutIfNeeded()
            })

        }
        else {
            centreConstraint.constant = -600
            
            UIView.animate(withDuration: 0.1, animations: {
                
                self.view.layoutIfNeeded()
                
            })

        }
        
    }
}

extension ViewController : XwiftCollectionViewCellDelegate {
    
    func addToCart_TouchUpInside(product: Product) {
        self.cart.append(product)
        
        if self.cart.count > 0 {
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.testCart.layer.opacity = 1.0
                
            })
        }
        
        
    }
}
extension ViewController : UICollectionViewDataSource {

    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSize(width:collectionView.frame.size.width, height:50)
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return anotherProductList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        var cell = UICollectionViewCell()

        if let xwiftCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? XwiftCollectionViewCell {

            xwiftCell.productName.text = anotherProductList[indexPath.row].name
            xwiftCell.productPrice.text = String(anotherProductList[indexPath.row].price)
            xwiftCell.productImage.image = anotherProductList[indexPath.row].image
            xwiftCell.roundCorner(radius: 20.0, border: 1.0, borderColor: UIColor.clear.cgColor)
            xwiftCell.layer.masksToBounds = false
            xwiftCell.layer.shadowColor = UIColor.gray.cgColor
            xwiftCell.layer.shadowOpacity = 0.7
            xwiftCell.layer.shadowOffset = CGSize(width: 0, height: 2)
            xwiftCell.delegate = self

            cell = xwiftCell
        }
        return cell
    }

}

extension ViewController : UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }

}

extension UIImage {
    
    var averageColor: UIColor? {
        guard let inputImage = self.ciImage ?? CIImage(image: self) else { return nil }
        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: CIVector(cgRect: inputImage.extent)])
            
        else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [CIContextOption.workingColorSpace : kCFNull!])
        let outputImageRect = CGRect(x: 0, y: 0, width: 1, height: 1)

        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: outputImageRect, format: CIFormat.RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
}


