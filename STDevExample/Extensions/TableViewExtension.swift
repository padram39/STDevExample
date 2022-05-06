//
//  TableViewExtension.swift
//  STDevExample
//
//  Created by enigma 2 on 2/16/1401 AP.
//

import UIKit


extension UITableView {
    func hideSearchBar() {
        if let bar = self.tableHeaderView as? UISearchBar {
            let height = bar.frame.height
            let offset = self.contentOffset.y
            if offset < height {
                self.contentOffset = CGPoint(x: 0, y: height)
            }
        }
    }
}
