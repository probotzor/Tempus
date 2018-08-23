//
//  WeeklyTimelineViewController.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 6/26/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftMoment

class WeeklyTimelineViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    var project = [Project]()
    var projectid: String!
    var projectcolor: String!
    var hours: Int!
    var totalhours = 0
    var projectID: String!
    var projectHOURS: Int!
    var type = "work"
    var dan: Dan!
    let now = Date()
    
    var beg = 28.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (DaysViewController.GlobalVariable.yesterdayname == dan.name) {
            checkbutton.isHidden = true
            editbutton.isHidden = false
        }
        dayname.text = dan.name.uppercased()
        datelabel.text = dan.date
        userimage.clipsToBounds = true
        collection.delegate = self
        collection.dataSource = self
        weeklyview.layer.cornerRadius = 5
        let url = URL(string: (ViewController.GlobalVariable.picture))
        if url != nil {
            let data = try? Data(contentsOf: url!)
            if data != nil {
                userimage.image = UIImage(data:data!)
            } else {
                print("Nema sliku")
            }}
        parseJSON()
        for card in dan.pcard {
            totalhours = totalhours + card.hours
            totalhourslabel.text = "\(String(totalhours))/8"
            var customView = UIView()
            customView.frame = CGRect.init(x: beg, y: 131.0, width: (Double(weeklyview.bounds.width) / 8.77)  * (Double(card.hours)), height: 6.0)
            customView.backgroundColor = UIColor().HexToColor(hexString: "\(card.projectcolor.lowercased())", alpha:  1.0)
            self.view.addSubview(customView)
            beg = beg + (Double(weeklyview.bounds.width) / 8.77) * Double(card.hours)
        }
        

        collection.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
 /*   func get_Date_time_from_UTC_time(string : String) -> String {
        
        let dateformattor = DateFormatter()
        dateformattor.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateformattor.timeZone = NSTimeZone.local
        let dt = string
        let dt1 = dateformattor.date(from: dt as String)
        dateformattor.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
        dateformattor.timeZone = NSTimeZone.init(abbreviation: "UTC") as TimeZone!
        return dateformattor.string(from: dt1!)
    }
*/
    
    
    @IBOutlet weak var datelabel: UILabel!
    @IBOutlet weak var totalhourslabel: UILabel!
    @IBOutlet weak var dayname: UILabel!
    @IBOutlet weak var projectname: UILabel!
    @IBOutlet weak var weeklyview: UIView!
    
   
    @IBAction func back(_ sender: Any) {
        //dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "todays", sender: self)
        
        
    }
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var userimage: UIImageView!
    
    
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
                self.project.append(projekat)
            }
            
            
            self.collection.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? MyCell {
            
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
       // collectionView.performBatchUpdates(nil, completion: nil)
        projectname.text = projekat.name
        projectid = projekat.id
        projectcolor = projekat.color
       // let cell = collectionView.cellForItem(at: indexPath)
       // cell?.layer.borderWidth = 4.0
       // cell?.layer.borderColor = UIColor.gray.cgColor
       // collection.reloadItems(at: [indexPath])
        
        
    }
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return project.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collection.frame.width, height: collection.frame.height)
       /* switch collectionView.indexPathsForSelectedItems?.first {
        case .some(indexPath):
            return CGSize(width: 150, height: 150) // your selected height
        default:
            return CGSize(width: 100, height: 100)
        } */
        
    }
    
    @IBOutlet weak var editbutton: UIButton!
    @IBOutlet weak var checkbutton: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var label8: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var label7: UILabel!
    @IBOutlet weak var button7: UIButton!
    @IBAction func button3(_ sender: Any) {
        hours = 3
        button3.backgroundColor = UIColor().HexToColor(hexString: "4173B4", alpha: 1.0)
        label3.textColor = UIColor.white
        button1.backgroundColor = UIColor.white
        label1.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button2.backgroundColor = UIColor.white
        label2.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button4.backgroundColor = UIColor.white
        label4.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button5.backgroundColor = UIColor.white
        label5.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button6.backgroundColor = UIColor.white
        label6.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        label7.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button7.backgroundColor = UIColor.white
        button8.backgroundColor = UIColor.white
        label8.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
    }
    @IBAction func button1(_ sender: Any) {
        hours = 1
        
        
        button1.backgroundColor = UIColor().HexToColor(hexString: "4173B4", alpha: 1.0)

        label1.textColor = UIColor.white
        button2.backgroundColor = UIColor.white
        label2.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button4.backgroundColor = UIColor.white
        label4.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button8.backgroundColor = UIColor.white
        label8.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button3.backgroundColor = UIColor.white
        label3.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button5.backgroundColor = UIColor.white
        label5.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button6.backgroundColor = UIColor.white
        label6.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        label7.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button7.backgroundColor = UIColor.white
    }
    @IBAction func button2(_ sender: Any) {
        hours = 2
        button2.backgroundColor = UIColor().HexToColor(hexString: "4173B4", alpha: 1.0)

        label2.textColor = UIColor.white
        button4.backgroundColor = UIColor.white
        label4.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button8.backgroundColor = UIColor.white
        label8.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button3.backgroundColor = UIColor.white
        label3.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button1.backgroundColor = UIColor.white
        label1.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button5.backgroundColor = UIColor.white
        label5.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button6.backgroundColor = UIColor.white
        label6.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        label7.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button7.backgroundColor = UIColor.white

    }
    @IBAction func button4(_ sender: Any) {
        hours = 4
        button4.backgroundColor = UIColor().HexToColor(hexString: "4173B4", alpha: 1.0)

        label4.textColor = UIColor.white
        button8.backgroundColor = UIColor.white
        label8.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button3.backgroundColor = UIColor.white
        label3.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button1.backgroundColor = UIColor.white
        label1.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button2.backgroundColor = UIColor.white
        label2.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button5.backgroundColor = UIColor.white
        label5.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button6.backgroundColor = UIColor.white
        label6.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        label7.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button7.backgroundColor = UIColor.white

    }
    @IBAction func button5(_ sender: Any) {
        hours = 5
        button3.backgroundColor = UIColor.white
        label3.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button1.backgroundColor = UIColor.white
        label1.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button2.backgroundColor = UIColor.white
        label2.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button4.backgroundColor = UIColor.white
        label4.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button5.backgroundColor = UIColor().HexToColor(hexString: "4173B4", alpha: 1.0)
        label5.textColor = UIColor.white
        button6.backgroundColor = UIColor.white
        label6.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        label7.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button7.backgroundColor = UIColor.white
        button8.backgroundColor = UIColor.white
        label8.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)

    }
    
    @IBAction func button6(_ sender: Any) {
        hours = 6
        button3.backgroundColor = UIColor.white
        label3.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button1.backgroundColor = UIColor.white
        label1.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button2.backgroundColor = UIColor.white
        label2.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button4.backgroundColor = UIColor.white
        label4.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button5.backgroundColor = UIColor.white
        label5.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button6.backgroundColor = UIColor().HexToColor(hexString: "4173B4", alpha: 1.0)
        label6.textColor = UIColor.white
        label7.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button7.backgroundColor = UIColor.white
        button8.backgroundColor = UIColor.white
        label8.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
    }
    
    @IBAction func button7(_ sender: Any) {
        hours = 7
        button3.backgroundColor = UIColor.white
        label3.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button1.backgroundColor = UIColor.white
        label1.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button2.backgroundColor = UIColor.white
        label2.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button4.backgroundColor = UIColor.white
        label4.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button5.backgroundColor = UIColor.white
        label5.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button6.backgroundColor = UIColor.white
        label6.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        label7.textColor = UIColor.white
        button7.backgroundColor = UIColor().HexToColor(hexString: "4173B4", alpha: 1.0)
        button8.backgroundColor = UIColor.white
        label8.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
    }
    @IBAction func button8(_ sender: Any) {
        hours = 8
        button8.backgroundColor = UIColor().HexToColor(hexString: "4173B4", alpha: 1.0)

        label8.textColor = UIColor.white
        button3.backgroundColor = UIColor.white
        label3.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button1.backgroundColor = UIColor.white
        label1.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button2.backgroundColor = UIColor.white
        label2.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button4.backgroundColor = UIColor.white
        label4.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button5.backgroundColor = UIColor.white
        label5.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button6.backgroundColor = UIColor.white
        label6.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        label7.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button7.backgroundColor = UIColor.white
    }
    @IBAction func confirm(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let dateInFormat = dateFormatter.string(from: NSDate() as Date)
        let projectdate = dateInFormat
       
        
        if projectid != nil {
        projectID = projectid
        }  else { let alert = UIAlertController(title: "Error!", message: "No project selected.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil) }

        if hours != nil {
        projectHOURS = hours
        } else { let alert = UIAlertController(title: "Error!", message: "No hours selected.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return }

        let tokenstring = ViewController.GlobalVariable.token
        let parameters: Parameters = [
            "project": projectID,
            "hours": projectHOURS,
            "type": type,
            "date": projectdate]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(tokenstring)",
            "Accept": "application/json"]
        
        
        
        totalhours = totalhours + projectHOURS
        totalhourslabel.text = "\(String(totalhours))/8"
        
        if (totalhours < 9) {
        
        
        Alamofire.request("http://tempus.30hills.com/api/v1/project/add/hours", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers:headers).responseJSON { response in debugPrint(response) }
            for i in 1...projectHOURS {
                
                var customView = UIView()
                customView.frame = CGRect.init(x: beg, y: 131.0, width: (Double(weeklyview.bounds.width) / 8.77), height: 6.0)
                customView.backgroundColor = UIColor().HexToColor(hexString: "\(projectcolor.lowercased())", alpha:  1.0)
                self.view.addSubview(customView)
                beg = beg + (Double(weeklyview.bounds.width) / 8.77)
                
            }
        } else {
            totalhours = totalhours - projectHOURS
            totalhourslabel.text = "\(String(totalhours))/8"
            let alert = UIAlertController(title: "Error!", message: "You cannot work more than 8 hours a day.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            }
        
        
        button3.backgroundColor = UIColor.white
        label3.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        
        button1.backgroundColor = UIColor.white
        label1.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button2.backgroundColor = UIColor.white
        label2.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button4.backgroundColor = UIColor.white
        label4.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button8.backgroundColor = UIColor.white
        label8.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
    }
    @IBAction func editpunchcard(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateInFormat = dateFormatter.string(from: NSDate() as Date)
        let projectdate = dan.utcdate
        
        
        if projectid != nil {
            projectID = projectid
        } else { return }
        if hours != nil {
            projectHOURS = hours
        } else { return }
        let tokenstring = ViewController.GlobalVariable.token
        let parameters: Parameters = [
            "projectId": projectID,
            "hours": projectHOURS,
            "type": type,
            "date": projectdate!]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(tokenstring)",
            "Accept": "application/json"]
        
        
        totalhours = totalhours + projectHOURS
        totalhourslabel.text = "\(String(totalhours))/8"
        
        if (totalhours < 9) {
            
            
            Alamofire.request("http://tempus.30hills.com/api/v1/timeline/edit", method: .post, parameters: parameters, headers:headers).responseJSON { response in debugPrint(response) }
            for i in 1...projectHOURS {
                
                var customView = UIView()
                customView.frame = CGRect.init(x: beg, y: 131, width: 33, height: 6)
                customView.backgroundColor = UIColor().HexToColor(hexString: "\(projectcolor.lowercased())", alpha:  1.0)
                self.view.addSubview(customView)
                beg = beg + 33
                
            }
        } else {
            totalhours = totalhours - projectHOURS
            totalhourslabel.text = "\(String(totalhours))/8"
            let alert = UIAlertController(title: "Error!", message: "You cannot work more than 8 hours a day.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    
    
        button3.backgroundColor = UIColor.white
        label3.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        
        button1.backgroundColor = UIColor.white
        label1.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button2.backgroundColor = UIColor.white
        label2.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button4.backgroundColor = UIColor.white
        label4.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
        button8.backgroundColor = UIColor.white
        label8.textColor = UIColor().HexToColor(hexString: "7f7f7f", alpha: 1.0)
    }
}
    


