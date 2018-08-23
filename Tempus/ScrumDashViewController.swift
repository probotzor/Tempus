//
//  ScrumDashViewController.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 6/30/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class ScrumDashViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {
    
    let indicator: NVActivityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0), type: .lineScalePulseOut, color: UIColor().HexToColor(hexString: "8B56B9", alpha: 1.0))

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
        getNotifications()
        collection.reloadData()
    }

    
    var notification = [Notification]()
    var pn: Int! = 0
    var fpp: Int! = 100
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func getNotifications() {
        let tokenstring = ViewController.GlobalVariable.token
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(tokenstring)",
            "Accept": "application/json"]
        let parameters: Parameters = [
            "pageNumber": pn,
            "filesPerPage": fpp]
        
        Alamofire.request("http://tempus.30hills.com/api/v1/dashboard", method: .post, parameters: parameters, headers: headers).responseJSON { response in guard let data = response.data
            
            else {return}
            let json = JSON(data: data)
            let results = json["results"].arrayValue
            for result in results {
                let timeline = result["timeline"].arrayValue
                for line in timeline {
                    let userdata = line["userData"].arrayValue
                    for udata in userdata {
                    let name = udata["name"].stringValue
                    let picture = udata["picture"].stringValue
                    let description = line["description"].stringValue
                    let datecreated = line["createdAt"].stringValue
                    let date = result["date"].stringValue
                        let dashnot = Notification(name: name, picture: picture, description: description, date: date, datecreated: datecreated)
                        
                    self.notification.append(dashnot)
                    self.notification.sort { $0.datecreated > $1.datecreated}
                    
                    }
                    self.collection.reloadData()
                    self.indicator.stopAnimating()
                  
                }
            }
        }
    
    }
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var userimage: UIImageView!

    @IBAction func back(_ sender: Any) {
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashNotificationCell", for: indexPath) as? DashNotificationCell {
            
            let dashnot: Notification!
            dashnot = notification[indexPath.row]
            cell.configureCell(notification: dashnot)
           // cell.layer.shouldRasterize = true
           // cell.layer.rasterizationScale = UIScreen.main.scale
            return cell
            
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let dashnot: Notification!
        
        
        dashnot = notification[indexPath.row]
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return notification.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    
}
