//
//  PeopleViewController.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 6/29/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class PeopleViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {
    
    let indicator: NVActivityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0), type: .lineScalePulseOut, color: UIColor().HexToColor(hexString: "8B56B9", alpha: 1.0))
    
// let indicator:UIActivityIndicatorView = UIActivityIndicatorView  (activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    var person = [Person]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // indicator.color = UIColor().HexToColor(hexString: "8B56B9", alpha: 1.0)
       // indicator.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
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
        parseJSON()
        collection.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var userimage: UIImageView!
    @IBOutlet weak var collection: UICollectionView!
    func parseJSON() {
        let tokenstring = ViewController.GlobalVariable.token
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(tokenstring)",
            "Accept": "application/json"]
        
        Alamofire.request("http://tempus.30hills.com/api/v1/user/show",headers: headers).responseJSON { response in guard let data = response.data
            else {return}
            let json = JSON(data: data)
            let users = json["user"].arrayValue
            for user in users {

                let slack = user["description"]["slack"].stringValue
                let position = user["description"]["position"].stringValue
                let github = user["description"]["github"].stringValue
                let skills = user["description"]["skills"].stringValue
                let tablla = user["description"]["tablla"].stringValue
                let trello = user["description"]["trello"].stringValue
                let hardware = user["description"]["hardware"].stringValue
                let jrole = user["role"].arrayValue
                var role:[String] = jrole.map { $0.stringValue}
                let name = user["name"].stringValue
                let id = user["_id"].stringValue
                let username = user["username"].stringValue
                let picture = user["picture"].stringValue
                let archived = user["archived"].boolValue
                
                let osoba = Person(id: id, name: name, username: username, picture: picture, slack: slack, position: position, github: github, skills: skills, tablla: tablla, trello: trello, hardware: hardware, role: role, archived: archived)
                self.person.append(osoba)
              /*  self.person = self.person.filter { $0.name != "\(ViewController.GlobalVariable.fullname)"
                } */
            }
            
            
            self.collection.reloadData()
            self.indicator.stopAnimating()
            //self.indicator.hidesWhenStopped = true
            
          
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonCell", for: indexPath) as? PersonCell {
            
            let osoba: Person!
            osoba = person[indexPath.row]
            cell.configureCell(person: osoba)
            return cell
            
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let osoba: Person!
        
        
        osoba = person[indexPath.row]
        performSegue(withIdentifier: "PersonDetailVC", sender: osoba)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return person.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 85, height: 121)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PersonDetailVC" {
            if let detailsVC = segue.destination as? PersonDetailVC {
                if let osoba = sender as? Person {
                    detailsVC.person = osoba
                }
            }
        }
    }
    
}

