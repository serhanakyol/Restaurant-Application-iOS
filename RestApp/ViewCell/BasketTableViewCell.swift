//
//  BasketTableViewCell.swift
//  RestApp
//
//  Created by Serhan Akyol on 6.05.2017.
//  Copyright © 2017 Serhan Akyol. All rights reserved.
//

import UIKit

class BasketTableViewCell: UITableViewCell {

    @IBOutlet weak var ad: UILabel?
    
    @IBOutlet weak var adet: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

}
