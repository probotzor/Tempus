//
//  TrelloCell.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 7/5/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import UIKit

class TrelloCell: UICollectionViewCell {
    @IBOutlet weak var boardname: UILabel!
    
    var punchcard: Punchcard!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(punchcard: Punchcard) {
        self.punchcard = punchcard
        
        boardname.text = self.punchcard.projectname.capitalized
        self.backgroundColor = UIColor().HexToColor(hexString: "\(punchcard.projectcolor.lowercased())", alpha: 1.0)
    }
    
    @IBAction func gotoboard(_ sender: Any) {
        
        if let url = NSURL(string: "https://www.trello.com/b/65YrhcNh/development"){
            UIApplication.shared.openURL(url as URL)
            print(punchcard.trello)
        }
    }
   
}
