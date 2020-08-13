//
//  ViewController.swift
//  Point Of Sales
//
//  Created by Aung Thiha on 4/8/20.
//  Copyright © 2020 Aung Thiha. All rights reserved.
//

import UIKit

struct Product {
    let name : String
    let price : Int
    let tagID : Int
}

class ViewController: UIViewController {
    
    var productList : [Product] = []
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var priceTextField: UITextField!
    @IBAction func addButton(_ sender: Any) {
        
        if let name = nameTextField.text , let price = priceTextField.text{
            
            let newProduct = Product(name: name, price: Int(price)!, tagID: productList.count+1)
            
            productList.append(newProduct)
            
            print(productList)
            
            nameTextField.text?.removeAll()
            priceTextField.text?.removeAll()
            
            tableView.reloadData()
        }
        else {
            print("Didn't get any response")
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "product")
        
        tableView.footerView(forSection: productList.count)
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
}

extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
}

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "product", for: indexPath)
        
        let product = productList[indexPath.row]
        cell.textLabel?.text = String(product.tagID)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let product = productList[indexPath.row]
        
        print(product.name)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            productList.remove(at: indexPath.row)
            print(productList)
            
            tableView.reloadData()
        }
        else if editingStyle == .insert {
            print("Something wrong")
        }
        
    }
    
}



