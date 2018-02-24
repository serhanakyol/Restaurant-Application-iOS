//
//  ProductViewController.swift
//  RestApp
//
//  Created by Serhan Akyol on 3.05.2017.
//  Copyright © 2017 Serhan Akyol. All rights reserved.
//

import UIKit
import Alamofire
class ProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
    
    var viewcontroller:ViewController?
    var selected:Int?
    var selected2:Int?
    
   
    var getName:String?
    var getId :Int?
    var nextDesk1:Int?
    
    var adet:Int = 0
    var jsonPhotoPro = [NSData]()
    var jsonTitlePro = [String]()
    var jsonPricePro = [Int]()
    var jsonIdPro = [Int]()
    var catIsim:String = ""
    

    var rightBarButton:UIBarButtonItem?
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.adet
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductTableViewCell
        cell.tableProductPhoto.image = UIImage(data: self.jsonPhotoPro[indexPath.row] as Data)
        cell.tableProductName.text = jsonTitlePro[indexPath.row]
        cell.tableProductPrice.text = String(jsonPricePro[indexPath.row]) + "  ₺"
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected2 = indexPath.row
        performSegue(withIdentifier: "yol2", sender: nil)
//        let pdname = jsonTitlePro[indexPath.row]
//        let pdprice = jsonPricePro[indexPath.row]
//        let pdid = jsonIdPro[indexPath.row]
//        let pdphoto = jsonPhotoPro[indexPath.row] as Data
//
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        
//        let pdVC = storyBoard.instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
//        
//        pdVC.getpPdName = pdname
//        pdVC.getPdId = pdid
//        pdVC.getPdPrice = String(pdprice)
//        pdVC.getPdPhoto = pdphoto as NSData
//        self.present(pdVC, animated: true, completion: nil)
     
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButton()
        getName = viewcontroller?.jsonTitleCat[selected!]
        getId = viewcontroller?.jsonIdCat[selected!]
        
        print("getname:\(getName)")
        print("getId:\(getId)")
        
        let path = URL(string: "http://fatihsimsek.me:9090/product/\(getId!)")

        Alamofire.request(path!).responseJSON{ response in
            let result = response.result
            print(response)
            if let dict = result.value as? Dictionary<String,AnyObject>{
                if let key = dict["products"] as? [Dictionary<String,AnyObject>]{
                    self.adet = key.count
                    
                    for i in 0..<key.count{
                        
                     
                        if let photoCat = key[i]["images"] as? [Dictionary<String,AnyObject>]{
                            
                          
                            for j in 0..<photoCat.count {
                                
                                if let photo = photoCat[j]["image"] {
                            var resimUrl = NSURL(string: photo as! String)
                            var resimData = NSData(contentsOf: resimUrl! as URL)
                            self.jsonPhotoPro.append(resimData!)
                                    self.tableView.reloadData()
                                    
                                }
                            }
                        }
                        
                        if let titlePro = key[i]["name"] as? String{
                            self.jsonTitlePro.append(titlePro)
                            self.tableView.reloadData()
                          
                        }
                        if let pricePro = key[i]["price"] as? Int{
                            self.jsonPricePro.append(pricePro)
                            self.tableView.reloadData()
                            
                        }
                        if let idPro = key[i]["productID"] as? Int{
                            self.jsonIdPro.append(idPro)
                            self.tableView.reloadData()
                            
                        }
                    }
                }
            }
        }
    }

    func setupBackButton(){
        rightBarButton = UIBarButtonItem(image: UIImage(named: "cart-38-32"), style: .plain, target: self, action: #selector(rightButtonclick))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func rightButtonclick(){
        performSegue(withIdentifier: "basket", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "yol2" {
            let newVC = segue.destination as! ProductDetailViewController
            newVC.delegate = self
            newVC.selected = selected2
            newVC.getPdPhoto = jsonPhotoPro[selected2!]
            newVC.getpPdName = jsonTitlePro[selected2!]
            newVC.getPdPrice = String(jsonPricePro[selected2!])
            newVC.getPdId = jsonIdPro[selected2!]
            newVC.nextDesk2 = nextDesk1
            
        }
    }

}
