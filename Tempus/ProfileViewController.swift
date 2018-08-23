//
//  ProfileViewController.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 6/14/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

extension UINavigationController {
    
    func backToViewController(viewController: Swift.AnyClass) {
        
        for element in viewControllers as Array {
            if element.isKind(of: viewController) {
                self.popToViewController(element, animated: true)
                break
            }
        }
    }
}

class ProfileViewController: UIViewController {

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
        



        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBOutlet weak var logoutbutton: UIButton!
    @IBOutlet weak var changepasswordbutton: UIButton!
    @IBOutlet weak var editprofilebutton: UIButton!
       @IBAction func back(_ sender: Any) {
        
    }
    @IBOutlet weak var userimage: UIImageView!
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
    
    
    }
