//
//  MyCell.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 6/28/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgb & 0xFF00) >> 8) / 255.0, blue: CGFloat(rgb & 0xFF) / 255.0, alpha: alpha)
    }
}

private let highlightedColor = UIColor(rgb: 0xD8D8D8)

class MyCell: UICollectionViewCell {
    
    var project: Project!
    
    
    @IBOutlet weak var myLabel: UILabel!
    
    var shouldTintBackgroundWhenSelected = true //
    var specialHighlightedArea: UIView?
    
    override var isHighlighted: Bool {         willSet {
            onSelected(newValue)
        }
    }
    override var isSelected: Bool {
        willSet {
            onSelected(newValue)
        }
    }
    func onSelected(_ newValue: Bool) {
        guard selectedBackgroundView == nil else { return }
        if shouldTintBackgroundWhenSelected {
            contentView.backgroundColor = newValue ? highlightedColor : UIColor.clear
            
        }
        if let sa = specialHighlightedArea {
            sa.backgroundColor = newValue ? UIColor.black.withAlphaComponent(0.4) : UIColor.clear
            
        }
    }

    
    func configureCell(project: Project) {
        self.project =  project
        myLabel.text = self.project.name.getAcronyms()
        print(project.color)
        self.backgroundColor = UIColor().HexToColor(hexString: "\(project.color.lowercased())", alpha: 1.0)
        self.layer.cornerRadius = 5
    }
}
