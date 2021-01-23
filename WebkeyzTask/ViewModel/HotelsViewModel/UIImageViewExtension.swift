//
//  UIImageViewExtension.swift
//  WebkeyzTask
//
//  Created by Asmaa Tarek on 1/23/21.
//

import UIKit

///UIViewExtension
extension UIImageView {
    
    /// Check if image transparent
    /// - Returns: True or false if needed
    @discardableResult
    func isTransparent() -> Bool {
        guard let alpha: CGImageAlphaInfo = self.image?.cgImage?.alphaInfo else { return false }
        let isTransparent = alpha == .first || alpha == .last || alpha == .premultipliedFirst || alpha == .premultipliedLast
        if isTransparent {
            self.image = #imageLiteral(resourceName: "placeholder")
        }
    return isTransparent
  }
}
