//
//  MonthsViewController.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 7/14/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class MonthsViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {

    let indicator: NVActivityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0), type: .lineScalePulseOut, color: UIColor().HexToColor(hexString: "8B56B9", alpha: 1.0))
    
    var mproject = [MProject]()
    var mesec = [Mesec]()
    let now = Date()
    
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
        getMonthly()
        collection.reloadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var userimage: UIImageView!
    func populateMonths() {
        var monthnumber = 0
        let meseci = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        for mess in meseci {
            var mprojct = [MProject]()
            let monthname = mess
            monthnumber = monthnumber + 1
            for mproj in mproject {
                let fmt = DateFormatter()
                fmt.dateFormat = "MM"
                let month = fmt.monthSymbols[mproj.month - 1]
                if month == monthname {
                   mprojct.append(mproj)
                }
            }
            let mes = Mesec(name: monthname, number: monthnumber, mprojct: mprojct)
            mesec.append(mes)
        }
        collection.reloadData()
        self.indicator.stopAnimating()
    }
    func getMonthly() {
        let tokenstring = ViewController.GlobalVariable.token
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(tokenstring)",
            "Accept": "application/json"]
        
        Alamofire.request("http://tempus.30hills.com/api/v1/timeline/monthly",headers: headers).responseJSON { response in guard let data = response.data
            
            else {return}
            let json = JSON(data: data)
            let results = json["results"].arrayValue
            for result in results {
                let year = result["_id"]["year"].intValue
                let month = result["_id"]["month"].intValue
                let hours = result["numberHoursOnProject"].intValue
                let color = result["panchCard"][0]["projectDetails"][0]["color"].stringValue
                let name = result["panchCard"][0]["projectDetails"][0]["name"].stringValue
                
                let mproj = MProject(name: name, color: color, hours: hours, year: year, month: month)
                self.mproject.append(mproj)
                self.mproject.sort { $0.hours > $1.hours }
                
            }
          self.populateMonths()
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MonthCell", for: indexPath as IndexPath) as? MonthCell
        {
            let mes: Mesec!
            mes = mesec[indexPath.row]
            cell.configureCell(mesec: mes)
            if (now.monthAsString() == cell.monthname.text!) {
                cell.starimage.isHidden = false
            }

            return cell
            //collection.reloadData()
        }   else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let mes: Mesec!
        mes = mesec[indexPath.item]
        performSegue(withIdentifier: "tomonthlyview", sender: mes)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return mesec.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tomonthlyview" {
            if let detailsVC = segue.destination as? MonthlyTimelineViewController {
                if let mos = sender as? Mesec {
                    detailsVC.mesec = mos
                }
                
            }
        }
    }

    


}
