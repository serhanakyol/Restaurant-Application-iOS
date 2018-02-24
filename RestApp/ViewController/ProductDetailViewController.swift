//
//  ProductDetailViewController.swift
//  RestApp
//
//  Created by Serhan Akyol on 5.05.2017.
//  Copyright © 2017 Serhan Akyol. All rights reserved.
//

import UIKit
var cart = [(String, String, String)]()
class ProductDetailViewController: UIViewController , UITextFieldDelegate {

 
    var delegate:ProductViewController?
    var selected:Int?
 
    
    @IBOutlet weak var pdPhoto: UIImageView!
    @IBOutlet weak var pdTitle: UILabel!
    @IBOutlet weak var pdPrice: UILabel!
    @IBOutlet weak var pieceTextField: UITextField!
   
    
    var getpPdName = String()
    var getPdPrice = String()
    var getPdPhoto = NSData()
    var getPdId = Int()
    
    var pieceInp:Int?
    var nextDesk2:Int?
    var productID = [Int]()
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "yol3" {
            let newwVC = segue.destination as! BasketViewController
            newwVC.delegate2 = self
            newwVC.gelenAd = cart
            newwVC.nextDesk3 = nextDesk2
        
        }
    }
    
   
    var cla = BasketViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pdTitle.text! = getpPdName
        pdPhoto.image = UIImage(data: getPdPhoto as Data)
        pdPrice.text! = getPdPrice
    }
   
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for txt in self.view.subviews {
            if txt.isKind(of: UITextField.self) && txt.isFirstResponder {
                txt.resignFirstResponder()
            }
        }
    }
    
    func deleteList(){
        cart.removeAll()
    }
    
    @IBAction func addProductId(_ sender: UIButton) {
        
        pieceInp = Int(pieceTextField.text!)
        
        var i = 0
        var kontrol = 0
        
        if cart.count == 0 {
          cart.insert((String(getpPdName), String(pieceInp!), String(getPdId)), at: i)
            
        }
        else {
            for (c,v,b) in cart {
                if b == getpPdName {
                    kontrol = kontrol + 1
                }
            }
            if kontrol == 0{
                cart.insert((String(getpPdName),String(pieceInp!) , String(getPdId)), at: i)
            }
          
        }
        i += 1
     }

    
}





