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
    
    func setEmptyView(title: String, messageImage: UIImage) {
         
         let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
         let messageImageView = UIImageView()
         let titleLabel = UILabel()
         messageImageView.backgroundColor = .clear
         titleLabel.translatesAutoresizingMaskIntoConstraints = false
         messageImageView.translatesAutoresizingMaskIntoConstraints = false
         
         titleLabel.textColor = #colorLiteral(red: 0.7254901961, green: 0.7176470588, blue: 0.7333333333, alpha: 1)
         titleLabel.font = UIFont(name: "HurmeGeometricSans1 Regular", size: 18)
         emptyView.addSubview(titleLabel)
         emptyView.addSubview(messageImageView)
         messageImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
         messageImageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -20).isActive = true
         messageImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
         messageImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
         titleLabel.topAnchor.constraint(equalTo: messageImageView.bottomAnchor, constant: 10).isActive = true
         titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
         messageImageView.image = messageImage
         titleLabel.text = title
         UIView.animate(withDuration: 1, animations: {
             messageImageView.transform = CGAffineTransform(rotationAngle: .pi / 10)
         }, completion: { (finish) in
             UIView.animate(withDuration: 1, animations: {
                 messageImageView.transform = CGAffineTransform(rotationAngle: -1 * (.pi / 10))
             }, completion: { (finishh) in
                 UIView.animate(withDuration: 1, animations: {
                     messageImageView.transform = CGAffineTransform.identity
                 })
             })
         })
         
         self.backgroundView = emptyView
     }
     
     func restore() {
         self.backgroundView = nil
     }
}
