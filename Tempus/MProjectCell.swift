//
//  MProjectCell.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 7/14/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import UIKit

class MProjectCell: UICollectionViewCell {
    
    @IBOutlet weak var projectsquare: UIView!
    @IBOutlet weak var projecthours: UILabel!
    @IBOutlet weak var projectname: UILabel!
    
    var mp: MProject!
    
    func configureCell(mp: MProject) {
        self.mp = mp
        projectname.text = self.mp.name.getAcronyms()
        projecthours.text = " \(String(self.mp.hours)) Hours"
        projectsquare.backgroundColor = UIColor().HexToColor(hexString: "\(self.mp.color.lowercased())", alpha: 1.0)
    }

}
