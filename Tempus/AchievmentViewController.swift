//
//  AchievmentViewController.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 6/26/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import UIKit

class AchievmentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        userimage.clipsToBounds = true
        
        let url = URL(string: (ViewController.GlobalVariable.picture))
        if url != nil {
            let data = try? Data(contentsOf: url!)
            if data != nil {
                userimage.image = UIImage(data:data!)
            } else {
                print("Nema sliku")
            }}

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var userimage: UIImageView!

    
}
