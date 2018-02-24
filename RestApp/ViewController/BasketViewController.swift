//
//  BasketViewController.swift
//  RestApp
//
//  Created by Serhan Akyol on 6.05.2017.
//  Copyright © 2017 Serhan Akyol. All rights reserved.
//

import UIKit
import Alamofire

var gelenAd1 = [(String, String, String)]()


class BasketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var tableView: UITableView!
    
    var rightBarButton:UIBarButtonItem?
    var name = [String]()
    var piece = [String]()
    var gelenAd = [(String, String, String)]()
    var kontrol:Bool?
    
    var nextDesk3:Int?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BasketTableViewCell
        
        cell.ad?.text = name[indexPath.row]
        cell.adet?.text = piece[indexPath.row] + "  Adet"
        return cell
    }
    var delegate2:ProductDetailViewController?
    
    func setupBackButton(){
        rightBarButton = UIBarButtonItem(image: UIImage(named: "approval-32"), style: .plain, target: self, action: #selector(rightButtonclick))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func rightButtonclick(){
        
        deskPost()
        createAlert(title: "Siparişiniz Gönderildi", message: String(describing: nextDesk3))
        
    }
    
    func deskPost(){
        
        print("girdiiiiiiiiii")
        let parametersDesk = ["deskid": nextDesk3!]
        print(parametersDesk)
        
        let todosEndpoint: String = "http://fatihsimsek.me:9090/tempdesk"
        
        Alamofire.request(todosEndpoint, method: .post, parameters: parametersDesk, encoding: JSONEncoding.default)
            .responseJSON { response in
                
                print(response.result.value)
                let result = response.result
                
                if let dict = result.value as? Dictionary<String,AnyObject>{
                    
                    print(dict["tempId"])
                    self.orderPost(postTempId: dict["tempId"] as! Int)
                }
        }
    }
    
    
    func orderPost(postTempId:Int){
        
        var pdvc = ProductDetailViewController()
        var productPost = [String:AnyObject]()
        var postArray = [productPost]
        
        for (ad,adet,id) in gelenAd1
        {
            
            productPost = ["productId": id as AnyObject, "piece": adet as AnyObject]
            
            postArray.append(productPost)
            
            
        
            let parameters: [String: Any] = [
                "tempId" : postTempId,
                "products": [
                    [
                        "productId" : id,
                        "piece": adet
                    ]
                ]
            ]
            
            //  let parameters = ["tempId": 16, "products": "productId" : 1 , "piece" : 5] as [String : AnyObject]

            print(parameters)
            
            Alamofire.request("http://fatihsimsek.me:9090/order", method: .post, parameters: parameters)
                .responseJSON { response in

                    print(response.data)
                    print(response.result)
                    
            }
        }
        
        pdvc.deleteList()
        self.tableView.reloadData()
        
        
//        var productPost = [String:AnyObject]()
//        var postArray = [productPost]
//        print("temp ID :\(postTempId)")
//        for (ad,adet,id) in gelenAd1
//        {
//            
//            print("ID :\(id) ADET: \(adet)")
//            productPost = ["productId": id as AnyObject, "piece": adet as AnyObject]
//            print(productPost)
//            postArray.append(productPost)
//            
//          print(postArray)
//        }
//        
//        for don in postArray{
//            print("DONENLER")
//            print(don)
//        }
//       
//        let parameters = ["tempId": postTempId, "products": postArray] as [String : AnyObject]
//
//        print("POST PARAM\(parameters)")
//
//        Alamofire.request("http://fatihsimsek.me:9090/order", method: .post, parameters: parameters, encoding: JSONEncoding.default)
//            .responseJSON { response in
//            
//    
//                let result = response.result
//                
//                if let dict = result.value as? Dictionary<String,AnyObject>{
//                
//                    print("RESULT DON\(dict["result"])")
//                    
//                
//                }
//    }
        }
    
    func createAlert (title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
  
        alert.addAction(UIAlertAction(title: "Çık", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
    
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

           setupBackButton()

        gelenAd1 = gelenAd
  
        for (i,j,z) in gelenAd {
          
            name.append(i)
            piece.append(j)
        }
 
         self.tableView.reloadData()
    }
  
}
