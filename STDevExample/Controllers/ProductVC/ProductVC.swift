//
//  ProductVC.swift
//  STDevExample
//
//  Created by enigma 2 on 2/16/1401 AP.
//

import UIKit
import Kingfisher

class ProductVC: UIViewController {

    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var productDesc: UITextView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var buyBtn: UIButton!
    
    
    var product : Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.categoryLbl.text = product.category
        self.productDesc.text = product.description
        self.productTitle.text = product.title
        let url = URL(string: product.image)
        self.productImg.kf.setImage(with: url)
        self.buyBtn.setTitle("buy this For Only \(product.price)$", for: .normal)
    }
    
    
    func setupView(product : Product){
        self.product = product
    }
    
    @IBAction func BuyBtnPressed(_ sender: Any) {
        let alert = UIAlertController(title: "App developed by PEDRAM MOZAFARI", message: "PRODUCT Added", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done and Close", style: .cancel, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
