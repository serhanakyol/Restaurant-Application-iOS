//
//  ProductTableViewCell.swift
//  RestApp
//
//  Created by Serhan Akyol on 4.05.2017.
//  Copyright © 2017 Serhan Akyol. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var tableProductPhoto: UIImageView!
    
    @IBOutlet weak var tableProductName: UILabel!
    
    @IBOutlet weak var tableProductPrice: UILabel!
     
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
