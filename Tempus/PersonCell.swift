//
//  PersonCell.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 6/29/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PersonCell: UICollectionViewCell {
    
    @IBOutlet weak var personname: UILabel!
    @IBOutlet weak var personimage: UIImageView!
    var person: Person!
    
   // required init?(coder aDecoder: NSCoder) {
   //     super.init(coder: aDecoder)
   //    layer.cornerRadius = 7.0
   // }
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

    func configureCell(person: Person) {
        self.person = person
        personname.text = self.person.name.capitalized
        personname.lineBreakMode = .byWordWrapping
        personname.numberOfLines = 2
        if person.role.contains("Manager") == true {
            personname.textColor = UIColor().HexToColor(hexString: "ff0000", alpha: 1.0)
        }
        else if person.role.contains("ScrumMaster") == true {
            personname.textColor = UIColor().HexToColor(hexString: "6666ff", alpha: 1.0)
        }
        else if person.role.contains("Employee") == true {
            personname.textColor = UIColor().HexToColor(hexString: "00ff00", alpha: 1.0)
        }

        else if person.role.contains("Client") == true {
            personname.textColor = UIColor().HexToColor(hexString: "ffcc66", alpha: 1.0)
        } 


        
        personimage.clipsToBounds = true
        Alamofire.request("\(person.picture!)").responseImage { response in
            debugPrint(response)
            
            print(response.request)
            print(response.response)
            debugPrint(response.result)
            
            if let image = response.result.value {
                print("image downloaded: \(image)")
                self.personimage.image = image
            }
        }

       /* let url = URL(string: (self.person.picture))
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
