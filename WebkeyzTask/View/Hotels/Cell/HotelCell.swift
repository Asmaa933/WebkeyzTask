//
//  HotelCell.swift
//  WebkeyzTask
//
//  Created by Asmaa Tarek on 1/21/21.
//

import UIKit
import SDWebImage

/// HotelCell
class HotelCell: UITableViewCell {

    //MARK: - Variables
    
    @IBOutlet private weak var hotelImage: UIImageView!
    @IBOutlet private weak var hotelName: UILabel!
  
    //MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hotelImage.layer.cornerRadius = 10
    }
    
    //MARK: - Helper Methods
    
    func configureCell(image: String, name: String)  {
        hotelName.text = name
        hotelImage.sd_setImage(with: URL(string: image), placeholderImage: #imageLiteral(resourceName: "placeholder"))
    }
}
