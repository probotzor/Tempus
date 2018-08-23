//
//  DayCell.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 7/4/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import UIKit

class DayCell: UICollectionViewCell {
    
    @IBOutlet weak var starimage: UIImageView!
    @IBOutlet weak var selecteddayview: UIView!
    @IBOutlet weak var dayname: UILabel!
    @IBOutlet weak var todaylabel: UILabel!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    var beg = 0
    var dan: Dan!
    func configureCell(dan: Dan) {
        self.dan = dan
        dayname.text = self.dan.name
        
    }
    
    
}

