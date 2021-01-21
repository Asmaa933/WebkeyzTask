//
//  UITableViewExtension.swift
//  WebkeyzTask
//
//  Created by Asmaa Tarek on 1/21/21.
//

import UIKit

extension UITableView {
    func registerCellNib<Cell: UITableViewCell>(cellClass: Cell.Type) {
        self.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellReuseIdentifier: String(describing: Cell.self))
    }
}
