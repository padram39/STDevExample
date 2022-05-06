//
//  ProductCell.swift
//  STDevExample
//
//  Created by enigma 2 on 2/15/1401 AP.
//

import UIKit
import Kingfisher
class ProductCell: UITableViewCell {

    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var proImg: UIImageView!
    @IBOutlet weak var priceLbl: UILabel!
    
    var product : Product!
    
    func setupCell(product : Product){
        self.product = product
        self.categoryLbl.text = product.category
        self.nameLbl.text = product.title
        self.priceLbl.text = "\(product.price)$"
        let url = URL(string: product.image)
        proImg.kf.setImage(with: url)
    }
    
    
}
