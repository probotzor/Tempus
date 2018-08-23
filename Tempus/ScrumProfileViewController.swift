//
//  ScrumProfileViewController.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 6/30/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import UIKit

class ScrumProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        editprofilebutton.layer.cornerRadius = 5.0
        changepasswordbutton.layer.cornerRadius = 5.0
        logoutbutton.layer.cornerRadius = 5.0
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
        
    }
    

    @IBOutlet weak var logoutbutton: UIButton!
    @IBOutlet weak var changepasswordbutton: UIButton!
    @IBOutlet weak var editprofilebutton: UIButton!
    @IBAction func resetvariables(_ sender: Any) {
        ViewController.GlobalVariable.fullname = ""
        ViewController.GlobalVariable.username = ""
        ViewController.GlobalVariable.position = ""
        ViewController.GlobalVariable.slack = ""
        ViewController.GlobalVariable.trello = ""
        ViewController.GlobalVariable.github = ""
        ViewController.GlobalVariable.tablla = ""
        ViewController.GlobalVariable.hardware = ""
        ViewController.GlobalVariable.skills = ""
        ViewController.GlobalVariable.picture = ""

    }
    @IBAction func back(_ sender: Any) {
        
    }
    @IBOutlet weak var userimage: UIImageView!

}
