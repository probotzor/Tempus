//
//  DaysViewController.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 7/4/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftMoment
import NVActivityIndicatorView

extension Date {
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }
    func monthAsString() -> String {
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("MMMM")
        return df.string(from: self)
    }
}

class DaysViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {

    struct GlobalVariable {
        static var currentday = String()
        static var todayname = String()
        static var yesterdayname = String()
    }
    let indicator: NVActivityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0), type: .lineScalePulseOut, color: UIColor().HexToColor(hexString: "8B56B9", alpha: 1.0))
    
    var punchcard = [Punchcard]()
    
    var dan = [Dan]()
    let yesterday = Date().yesterday
    let today = Date()
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        //indicator.backgroundColor = UIColor().HexToColor(hexString: "7F7F7F", alpha: 0.3)
        indicator.layer.cornerRadius = 5.0
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.bringSubview(toFront: self.view)
        indicator.startAnimating()
        collection.delegate = self
        collection.dataSource = self
        collection.reloadData()
        userimage.clipsToBounds = true
        let url = URL(string: (ViewController.GlobalVariable.picture))
        if url != nil {
            let data = try? Data(contentsOf: url!)
            if data != nil {
                userimage.image = UIImage(data:data!)
            } else {
                print("Nema sliku")
            }}
        GlobalVariable.currentday = moment().weekdayName
        getPunchcards()
        
        todayyesterday()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    
    func todayyesterday() {
        let formattar = DateFormatter()
        formattar.dateFormat = "eeee"
        GlobalVariable.todayname = formattar.string(from: today)
        GlobalVariable.yesterdayname = formattar.string(from: yesterday)
    }
    
    func populatedays() {
        var calendar = Calendar.current
        calendar.firstWeekday = 2
        let today = calendar.startOfDay(for: Date())
        let dayOfWeek = calendar.component(.weekday, from: today)
        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: today)!
        let days = (weekdays.lowerBound ..< weekdays.upperBound)
            .flatMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: today) }
            .filter { !calendar.isDateInWeekend($0) }
        let formatter = DateFormatter()
        let formattor = DateFormatter()
        formatter.dateFormat = "eeee"
        formattor.dateFormat = "dd-MM-YYYY"
        for date in days {
            let utcdate = Date()
            let name = formatter.string(from: date)
            let date = formattor.string(from: date)
            var pcard = [Punchcard]()
            for card in punchcard {
             if formattor.string(from: card.datedate) == date {
             pcard.append(card)
             }}
            
            
            let dann = Dan(name: name, date: date, utcdate: utcdate, pcard: pcard)
            dan.append(dann)
        }
        collection.reloadData()
        self.indicator.stopAnimating()
    }
    
    @IBOutlet weak var userimage: UIImageView!
    @IBOutlet weak var collection: UICollectionView!
    @IBAction func back(_ sender: Any) {
        
    }
    
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
                
                let card = Punchcard(id: id, projectid: projectid, projectname: projectname, projectcolor: projectcolor, hours: hours, type: type, trello: trello, date: datestring, datedate: datedate)
                
                self.punchcard.append(card)
    
                

            
            }
        self.populatedays()
        }
        
    } 
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath as IndexPath) as? DayCell
        {
            let dann: Dan!
            dann = dan[indexPath.row]
            cell.configureCell(dan: dann)
            if (GlobalVariable.currentday == cell.dayname.text!) {
                cell.starimage.isHidden = false
            }
            var beg = 12
            for card in dann.pcard {
                var customView = UIView()
                customView.frame = CGRect.init(x: beg, y: 0, width: 33 * card.hours, height: 6)
                customView.backgroundColor = UIColor().HexToColor(hexString: "\(card.projectcolor.lowercased())", alpha:  1.0)
                cell.addSubview(customView)
                beg = beg + 33 * card.hours
            }
            return cell
            collection.reloadData()
        } else {
            return UICollectionViewCell()
            }
            
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let dann: Dan!
        dann = dan[indexPath.item]
        
        if (dann.name == GlobalVariable.todayname /* || dann.name == GlobalVariable.yesterdayname */) {
        performSegue(withIdentifier: "todailyview", sender: dann)
        }
    
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dan.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "todailyview" {
            if let detailsVC = segue.destination as? WeeklyTimelineViewController {
                if let dann = sender as? Dan {
                    detailsVC.dan = dann
                }
                
                }
            }
        }
    
}

    


