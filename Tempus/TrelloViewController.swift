//
//  TrelloViewController.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 6/26/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

extension Array
{
    func filterDuplicate<T>(_ keyValue:(Element)->T) -> [Element]
    {
        var uniqueKeys = Set<String>()
        return filter{uniqueKeys.insert("\(keyValue($0))").inserted}
    }
}

class TrelloViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {
    let indicator: NVActivityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0), type: .lineScalePulseOut, color: UIColor().HexToColor(hexString: "8B56B9", alpha: 1.0))

    
    var punchcard = [Punchcard]()

    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        //indicator.backgroundColor = UIColor().HexToColor(hexString: "7F7F7F", alpha: 0.3)
        indicator.layer.cornerRadius = 5.0
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.bringSubview(toFront: self.view)
        indicator.startAnimating()
        userimage.clipsToBounds = true
        
        let url = URL(string: (ViewController.GlobalVariable.picture))
        if url != nil {
            let data = try? Data(contentsOf: url!)
            if data != nil {
                userimage.image = UIImage(data:data!)
            } else {
                print("Nema sliku")
            }}
        collection.delegate = self
        collection.dataSource = self
        getPunchcards()
        collection.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var collection: UICollectionView!
    
    func getPunchcards() {
        let tokenstring = ViewController.GlobalVariable.token
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(tokenstring)",
            "Accept": "application/json"]
        
        Alamofire.request("http://tempus.30hills.com/api/v1/timeline/weekly",headers: headers).responseJSON { response in guard let data = response.data
            
            else {return}
            let json = JSON(data: data)
            let results = json["results"].arrayValue
            for result in results {
                let id = result["_id"].stringValue
                let projectid = result["project"]["_id"].stringValue
                let projectname = result["project"]["name"].stringValue
                let projectcolor = result["project"]["color"].stringValue
                let hours = result["hours"].intValue
                let type = result["type"].stringValue
                let trello = result["project"]["trello"].stringValue
                let datestring = result["date"].stringValue
                let formattar = DateFormatter()
                formattar.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
                let datedate = formattar.date(from: datestring)!
                
                let trelloboard = Punchcard(id: id, projectid: projectid, projectname: projectname, projectcolor: projectcolor, hours: hours, type: type, trello: trello, date: datestring, datedate: datedate)
        
                self.punchcard.append(trelloboard)
                self.punchcard = self.punchcard.filterDuplicate{ ($0.projectname) }
            }
            self.collection.reloadData()
            self.indicator.stopAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrelloCell", for: indexPath) as? TrelloCell {
            
            let trelloboard: Punchcard!
            trelloboard = punchcard[indexPath.row]
            cell.configureCell(punchcard: trelloboard)
            return cell
            
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let trelloboard: Punchcard!
        
        
        trelloboard = punchcard[indexPath.row]
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return punchcard.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    
    @IBOutlet weak var userimage: UIImageView!
    

}
