//
//  ViewController.swift
//  STDevExample
//
//  Created by enigma 2 on 2/15/1401 AP.
//

import UIKit

class MainVC: UIViewController {
    
    
    
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var serachBar: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    
    var products = [Product]()
    var filterProducts = [Product]()
    var searchedProducts = [Product]()
    var categories = [String]()
    var actionSheet: UIAlertController!
    var isSearch : Bool = false
    var selectedIDs  : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserSettings.isLogin = true
        self.usernameLbl.text = UserSettings.username
        tableview.dataSource = self
        tableview.delegate = self
        serachBar.delegate = self
        tableview.hideSearchBar()
        InternetServices.shared.getAllProducts { products in
            self.products = products
            self.filterProducts = products
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
            
        }
        
        InternetServices.shared.getAllCategories { categories in
            self.categories = categories
            self.selectedIDs = categories
        }
        
    }

    
    @IBAction func filterBtnPressed(_ sender: Any) {
        self.serachBar.text = ""
        isSearch = false
        tableview.reloadData()
        tableview.hideSearchBar()
        var pickerData = [[String:String]]()
        
        for category in categories {
            pickerData.append(["value":category,
                               "display":category])
        }
        
        MultiPickerDialog().show(title: "Filter Products",doneButtonTitle:"Filter", cancelButtonTitle:"Cancel" ,options: pickerData, selected:  self.selectedIDs) {
            values -> Void in
            self.selectedIDs.removeAll()
            for (index,value) in values.enumerated(){
                self.selectedIDs.append(value["value"]!)
            }
            self.filterBy(category: self.selectedIDs)
        }

    }
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        let vc = StoryboardHandler.shared.child(withIdentifier: "loginVc")
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true, completion: nil)
    }
    
    
    @IBAction func searchtBtnPressed(_ sender: Any) {
        tableview.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    @IBAction func sortBtnPressed(_ sender: Any) {
        actionSheet = UIAlertController(title: nil, message: "Sort By:", preferredStyle: UIAlertController.Style.actionSheet)
        
        let priceAction = UIAlertAction(title: "Price", style: UIAlertAction.Style.default, handler: {
            (alert: UIAlertAction) -> Void in
            self.sortBy(sortType: .price)
        })
        let nameAction = UIAlertAction(title: "Name", style: UIAlertAction.Style.default, handler: {
            (alert: UIAlertAction) -> Void in
            self.sortBy(sortType: .name)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: {
            (alert: UIAlertAction) -> Void in
        })
        actionSheet.addAction(priceAction)
        actionSheet.addAction(nameAction)
        actionSheet.addAction(cancelAction)
        
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    
    func sortBy(sortType : Sort){
        switch sortType {
        case .name:
            if isSearch{
                self.searchedProducts.sort(by: { $0.title < $1.title })
            }
            self.filterProducts.sort(by: { $0.title < $1.title })
        case .price:
            if isSearch{
                self.searchedProducts.sort(by: { $0.price < $1.price })
            }
            self.filterProducts.sort(by: { $0.price < $1.price })
        }
        
        self.tableview.reloadData()
    }
    
    
    func filterBy(category : [String]){
        filterProducts.removeAll()
        for item in selectedIDs{
            let filterd = products.filter({$0.category.lowercased() == item.lowercased()})
            self.filterProducts.append(contentsOf: filterd)
        }
        self.tableview.reloadData()
    }

}


extension MainVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearch{
            return searchedProducts.count
        }
        return filterProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductCell
        if isSearch{
            cell.setupCell(product: searchedProducts[indexPath.row])
        }else{
            cell.setupCell(product: filterProducts[indexPath.row])
        }
       
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = isSearch ? searchedProducts[indexPath.row] : filterProducts[indexPath.row]
        let vc = StoryboardHandler.shared.child(withIdentifier: "productVC") as! ProductVC
        vc.setupView(product: product)
        present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}


extension MainVC: UISearchBarDelegate{
    //MARK: UISearchbar delegate
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearch = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
        tableview.hideSearchBar()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            isSearch = false
            self.tableview.reloadData()
        } else {
            self.searchedProducts =  filterProducts.filter({$0.title.lowercased().range(of: searchText.lowercased()) != nil})
            isSearch = true
            self.tableview.reloadData()
        }
    }

}
