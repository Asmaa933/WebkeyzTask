//
//  HotelCell.swift
//  WebkeyzTask
//
//  Created by Asmaa Tarek on 1/21/21.
//

import UIKit
import SDWebImage

class HotelCell: UITableViewCell {

    @IBOutlet private weak var hotelImage: UIImageView!
    @IBOutlet private weak var hotelName: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        hotelImage.layer.cornerRadius = 10
    }
    
    func configureCell(image: String, name: String)  {
        hotelName.text = name
        hotelImage.sd_setImage(with: URL(string: image), placeholderImage: #imageLiteral(resourceName: "placeholder"))
    }
}
