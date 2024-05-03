//
//  Extenstions.swift
//  
//
//  Created by AmrFawaz on 02/05/2024.
//

import UIKit

public extension UITableViewCell {
    /// - Note: Used to Register cell to the passed tableview
    /// - Warning: Name Of the class should be the same as the name of Cell Identifier
    class func register(on tableView: UITableView) {
        tableView.register(
            UINib(
                nibName: self.className,
                bundle: nil
            ),
            forCellReuseIdentifier: self.className
        )
    }
}

