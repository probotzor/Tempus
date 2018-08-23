//
//  ResetViewController.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 6/14/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import UIKit
import Alamofire

class ResetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        emailtf.layer.cornerRadius = 5.0
        submitbutton.layer.cornerRadius = 5.0
        backbutton.layer.cornerRadius = 5.0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBOutlet weak var submitbutton: UIButton!
    @IBOutlet weak var backbutton: UIButton!
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    var code = 1
    
    @IBOutlet weak var emailtf: UITextField!
    @IBAction func reset(_ sender: Any) {
        
        let email = emailtf.text!
        let parameters = ["email": email]
        
        if (email != "") {
        Alamofire.request("http://tempus.30hills.com/api/v1/reset/password", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in debugPrint(response)
        self.code = response.response!.statusCode
        if (self.code == 200) {
            let alert = UIAlertController(title: "Success!", message: "Instructions for your password reset have been sent to your email.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{
                action in
                
                self.dismiss(animated: true, completion: nil)
                
                
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: "User does not exist.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)

            
            }
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Fields cannot be left blank.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)

            
        }
        

        
       
        
    }

}


