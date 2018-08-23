//
//  DashNotificationCell.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 7/20/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class DashNotificationCell: UICollectionViewCell {
    
    @IBOutlet weak var personimage: UIImageView!
    @IBOutlet weak var datelabel: UILabel!
    @IBOutlet weak var textlabel: UILabel!
    @IBOutlet weak var personname: UILabel!
    
    var notification: Notification!
   
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func configureCell(notification: Notification) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        let nicedate = dateFormatter.date(from: notification.date)
            dateFormatter.dateFormat = "MMM dd"
        let nicerdate = dateFormatter.string(from: nicedate!)
        
        self.notification = notification
        personname.text = notification.name!
        textlabel.text = notification.description!
        textlabel.lineBreakMode = .byWordWrapping
        textlabel.numberOfLines = 2
        datelabel.text = nicerdate
        Alamofire.request("\(notification.picture!)").responseImage { response in
            debugPrint(response)
            
            print(response.request)
            print(response.response)
            debugPrint(response.result)
            
            if let image = response.result.value {
                print("image downloaded: \(image)")
                self.personimage.image = image
                self.personimage.clipsToBounds = true
            
            }
        }
        
        
        
      /*  let url = URL(string: (self.notification.picture))
        if url != nil {
            let data = try? Data(contentsOf: url!)
            if data != nil {
                let uimage = UIImage(data: data!)
                 personimage.image = uimage
            //resizeImage(image: uimage!, targetSize:CGSize(width: 64, height: 64))
            } else {
                print("Nema sliku")
            }} */

        
}
}
