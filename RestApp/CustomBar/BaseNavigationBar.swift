//
//  BaseNavigationBar.swift
//  RestApp
//
//  Created by Serhan Akyol on 7.05.2017.
//  Copyright © 2017 Serhan Akyol. All rights reserved.
//

import Foundation
import UIKit

class BaseNavigationBar :UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.barTintColor = UIColor(red: 231/255, green: 165/255, blue: 90/255, alpha: 1.0)
     
        self.navigationBar.tintColor = UIColor.white
        
    }
}
