//
//  RegisterViewController.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 6/19/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        emailtf.layer.cornerRadius = 5.0
        usernametf.layer.cornerRadius = 5.0
        passwordtf.layer.cornerRadius = 5.0
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

    
    @IBOutlet weak var backbutton: UIButton!
    @IBOutlet weak var submitbutton: UIButton!
    var code = 1
    
    @IBOutlet weak var emailtf: UITextField!

    @IBOutlet weak var usernametf: UITextField!
   
    @IBOutlet weak var passwordtf: UITextField!
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func submit(_ sender: Any) {
        
        let name = usernametf.text!
        let password = passwordtf.text!
        let email = emailtf.text!
        
        
            let parameters: Parameters = [
            "name": name,
            "password": password,
            "email": email]
        if (name != "" && password != "" && email != "") {
            Alamofire.request("http://tempus.30hills.com/api/v1/register", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                debugPrint(response)
                self.code = response.response!.statusCode
                if (self.code == 200) {
                    let alert = UIAlertController(title: "Success!", message: "User successfully registered.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                }else {
                    let alert = UIAlertController(title: "Error!", message: "Incorrect credentials.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
                
            }} else {
            let alert = UIAlertController(title: "Error!", message: "Fields cannot be left blank.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
        
    }
}





