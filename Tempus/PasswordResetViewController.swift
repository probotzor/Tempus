//
//  PasswordChangeViewController.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 6/14/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import UIKit
import Alamofire

class PasswordChangeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        submitbutton.layer.cornerRadius = 5.0
        currentpasswordtf.layer.cornerRadius = 5.0
        newpasswordtf.layer.cornerRadius = 5.0
        newpasswordagaintf.layer.cornerRadius = 5.0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    var code = 1
    
    @IBOutlet weak var submitbutton: UIButton!
    @IBOutlet weak var currentpasswordtf: UITextField!
    
    @IBOutlet weak var newpasswordtf: UITextField!
    @IBOutlet weak var newpasswordagaintf: UITextField!
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func resetpass(_ sender: Any) {
        
        let currentpassword = currentpasswordtf.text!
        let newpassword = newpasswordtf.text!
        let newpasswordagain = newpasswordagaintf.text
        
        let tokenstring = ViewController.GlobalVariable.token
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(tokenstring)",
            "Accept": "application/json"]
        let parameters: Parameters = [
            "oldPassword": currentpassword,
            "newPassword": newpassword ]
        
        if (currentpassword != "" && newpassword != "" && newpasswordagain != "") {
            if (newpassword == newpasswordagain) {
        
                Alamofire.request("http://tempus.30hills.com/api/v1/password/change", method: .post, parameters: parameters, encoding: JSONEncoding.default,  headers: headers).responseJSON { response in debugPrint(response)
                    self.code = response.response!.statusCode
                    if (self.code == 200) {
                        let alert = UIAlertController(title: "Success!", message: "You have successfully changed your password.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{
                            action in
                            
                            self.dismiss(animated: true, completion: nil)
                            
                            
                        }))
                        self.present(alert, animated: true, completion: nil)
                        
                        
                    } else {
                        let alert = UIAlertController(title: "Error!", message: "Wrong password.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }}}else {
                let alert = UIAlertController(title: "Error!", message: "Passwords do not match.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)

        }}else {
            let alert = UIAlertController(title: "Error!", message: "Fields cannot be left blank.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)

        }
    }
}
