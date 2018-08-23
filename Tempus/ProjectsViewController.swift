//
//  ProjectsViewController.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 6/29/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class ProjectsViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {
    
    let indicator: NVActivityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0), type: .lineScalePulseOut, color: UIColor().HexToColor(hexString: "8B56B9", alpha: 1.0))

    
    var project = [Project]()
    var projectactive = [Project]()
    var projectarchived = [Project]()

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
        parseJSON()
        collection.reloadData()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var userimage: UIImageView!
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var segmented: UISegmentedControl!
    
    @IBAction func filter(_ sender: Any) {
        switch segmented.selectedSegmentIndex
        {
        case 0:
            
            project = projectactive
            collection.reloadData()
        case 1:
            
            project = projectarchived
            collection.reloadData()
        default:
            break; 
        }
    }
    func parseJSON() {
        let tokenstring = ViewController.GlobalVariable.token
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(tokenstring)",
            "Accept": "application/json"]
        
        Alamofire.request("http://tempus.30hills.com/api/v1/project/list",headers: headers).responseJSON { response in guard let data = response.data
            
            else {return}
            
            
         let json = JSON(data: data)
            let projects = json["projects"].arrayValue
                for proj in projects {
                    let name = proj["name"].stringValue
                    let id = proj["_id"].stringValue
                    let color = proj["color"].stringValue
                    let email = proj["clientName"].stringValue
                    let teamlead = proj["projectLead"].stringValue
                    let trello = proj["trello"].stringValue
                    let archived = proj["archived"].boolValue
                    let projekat = Project(id: id, name: name, color: color, email: email, teamlead: teamlead, trello: trello, archived: archived)
                    if archived == false {
                    self.projectactive.append(projekat)
                    self.project = self.projectactive
                    } else {
                    self.projectarchived.append(projekat)
                    }
            }
            
            
            self.collection.reloadData()
            self.indicator.stopAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCell", for: indexPath) as? ProjectCell {
            
            let projekat: Project!
            projekat = project[indexPath.row]
            cell.configureCell(project: projekat)
            return cell
            
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let projekat: Project!
        
        
            projekat = project[indexPath.row]
            performSegue(withIdentifier: "ProjectDetailVC", sender: projekat)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return project.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 85, height: 121)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProjectDetailVC" {
            if let detailsVC = segue.destination as? ProjectDetailVC {
                if let projekat = sender as? Project {
                    detailsVC.project = projekat
                }
            }
        }
    }

}
    
