//
//  RequestDayViewController.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 6/26/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import UIKit

class RequestDayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        sickbutton.layer.cornerRadius = 5.0
        holidaybutton.layer.cornerRadius = 5.0
        fromview.layer.cornerRadius = 10
        untilview.layer.cornerRadius = 10
        

        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var holidaybutton: UIButton!
    @IBOutlet weak var sickbutton: UIButton!
    @IBOutlet weak var fromview: UIView!

    @IBOutlet weak var untilview: UIView!
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
