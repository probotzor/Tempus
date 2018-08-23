//
//  MonthlyTimelineViewController.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 6/26/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MonthlyTimelineViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {

    var mproject = [MProject]()
    var mesec: Mesec!
    let date = Date()
    let calendar = Calendar.current
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let year = calendar.component(.year, from: date)
        mview1.layer.cornerRadius = 5
        mview2.layer.cornerRadius = 5
        var beg = 0
        for mproj in mesec.mprojct {
            var customView = UIView()
            customView.frame = CGRect.init(x: beg, y: 0, width: 1 * mproj.hours, height: 66)
            customView.backgroundColor = UIColor().HexToColor(hexString: mproj.color.lowercased(), alpha: 1.0)
            mview2.addSubview(customView)
            beg = beg + 1 * mproj.hours
        }
        collection.delegate = self
        collection.dataSource = self
        userimage.clipsToBounds = true
        monthlabel.text = " \(mesec.name!) \(year)"
        let url = URL(string: (ViewController.GlobalVariable.picture))
        if url != nil {
            let data = try? Data(contentsOf: url!)
            if data != nil {
                userimage.image = UIImage(data:data!)
            } else {
                print("Nema sliku")
            }}
        collection.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var mview1: UIView!
    @IBOutlet weak var mview2: UIView!
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var monthlabel: UILabel!
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var userimage: UIImageView!

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MProjectCell", for: indexPath) as? MProjectCell {
            
            let mproj: MProject!
            mproj = mesec.mprojct[indexPath.row]
            cell.configureCell(mp: mproj)
            
            
            
            return cell
            
        } else {
            
            return UICollectionViewCell()
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let mproj: MProject!
        mproj = mesec.mprojct[indexPath.row]
        
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return mesec.mprojct.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    


    
  
}
