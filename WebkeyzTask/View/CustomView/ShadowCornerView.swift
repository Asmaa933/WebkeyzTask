//
//  ShadowCornerView.swift
//  WebkeyzTask
//
//  Created by Asmaa Tarek on 1/22/21.
//

import Foundation

import UIKit

// MARK: - ShadowCornerView

class ShadowCornerView: UIView {
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupview()
    }
    
    // MARK: - Helper Methods
    
    private func setupview() {
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 2
    }
}
