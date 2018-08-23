//
//  MonthCell.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 7/13/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import UIKit

class MonthCell: UICollectionViewCell {
    
    
    @IBOutlet weak var starimage: UIImageView!
    @IBOutlet weak var monthname: UILabel!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    var mesec: Mesec!
    func configureCell(mesec: Mesec) {
        self.mesec = mesec
        monthname.text = self.mesec.name
        
    }

    
}
