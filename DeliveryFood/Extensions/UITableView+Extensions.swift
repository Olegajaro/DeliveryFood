//
//  UITableView+Extensions.swift
//  TestDeliveryApp
//
//  Created by Олег Федоров on 06.02.2022.
//

import UIKit

extension UITableView {
    func indexPathExists(indexPath: IndexPath) -> Bool {
        if indexPath.section >= self.numberOfSections {
            print("DEBUG: here...1")
            return false
        }
        if indexPath.row >= self.numberOfRows(inSection: indexPath.section) {
            print("DEBUG: here...2") 
            return false
        }
        
        return true
    }
}
