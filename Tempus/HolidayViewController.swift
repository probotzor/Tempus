//
//  HolidayViewController.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 6/27/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import UIKit

class HolidayViewController: UIViewController {

    override func viewDidLoad() {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (timer) in
            self.dismiss(animated: true, completion: nil)
        }
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
