//
//  ProjectCell.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 6/29/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import UIKit

extension String
{
    public func getAcronyms(separator: String = "") -> String
    {
        let acronyms = self.components(separatedBy: " ").map({ String($0.characters.first!) }).joined(separator: separator);
        return acronyms;
    }
}


extension UIColor{
    func HexToColor(hexString: String, alpha:CGFloat? = 1.0) -> UIColor {
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexStr: hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha!
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
}

class ProjectCell: UICollectionViewCell {
    
    @IBOutlet weak var projectheadline: UILabel!
    @IBOutlet weak var projectname: UILabel!
    var project: Project!
    
  /*  required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 7.0
    } */
    
    func configureCell(project: Project) {
        self.project = project
        
        projectname.text = self.project.name.capitalized
        projectheadline.text = self.project.name.getAcronyms()
        print(project.color)
        self.backgroundColor = UIColor().HexToColor(hexString: "\(project.color.lowercased())", alpha: 1.0)
        
    }
    

}
