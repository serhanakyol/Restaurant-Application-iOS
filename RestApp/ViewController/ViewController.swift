//
//  ViewController.swift
//  RestApp
//
//  Created by Serhan Akyol on 2.05.2017.
//  Copyright © 2017 Serhan Akyol. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource{

    @IBOutlet weak var collectionView: UICollectionView!
    
    var scannerviewcontroller:ScannerViewController?
    var adet:Int = 0
    var jsonPhotoCat = [NSData]()
    var jsonTitleCat = [String]()
    var jsonIdCat = [Int]()
    var catIsim:String = ""
    var selected:Int?
    var deskID = 5
    var gelencart = [(String, String)]()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "yol1" {
            let newVC = segue.destination as! ProductViewController
            newVC.viewcontroller = self
            newVC.selected = selected
            newVC.nextDesk1 = deskID
        }
    }

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.adet
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.photos.image = UIImage(data: self.jsonPhotoCat[indexPath.row] as Data)
        cell.titleCat.text = jsonTitleCat[indexPath.row]
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selected = indexPath.row
        performSegue(withIdentifier: "yol1", sender: nil)
    
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = URL(string: "http://fatihsimsek.me:9090/category")
        Alamofire.request(path!).responseJSON{ response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String,AnyObject>{
                if let key = dict["categories"] as? [Dictionary<String,AnyObject>]{
                    self.adet = key.count
                     
                    for i in 0..<key.count{
                        
                        if let photoCat = key[i]["image"] as? String{
                            var resimUrl = NSURL(string: photoCat)
                            var resimData = NSData(contentsOf: resimUrl! as URL)
                            self.jsonPhotoCat.append(resimData!)
                            self.collectionView.reloadData()
                        }
                       
                        
                        if let titleCat = key[i]["name"] as? String{
                      
                            self.jsonTitleCat.append(titleCat)
                            self.collectionView.reloadData()
                        }
                        if let idCat = key[i]["categoryId"] as? Int{
                            
                            self.jsonIdCat.append(idCat)
                            self.collectionView.reloadData()
                        }
                    }
                }
            }
        }
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
       
    }
}

