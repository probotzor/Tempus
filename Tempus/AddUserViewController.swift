//
//  AddUserViewController.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 6/27/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import UICheckbox_Swift

struct CustomPostEncoding: ParameterEncoding {
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try URLEncoding().encode(urlRequest, with: parameters)
        let httpBody = NSString(data: request.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        request.httpBody = httpBody.replacingOccurrences(of: "%5B%5D=", with: "=").data(using: .utf8)
        return request
    }
}
extension Sequence {
    var minimalDescription: String {
        return map { "\($0)" }.joined(separator: ", ")
    }
}
class AddUserViewController: UIViewController, UITextFieldDelegate {
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        submitbutton.layer.cornerRadius = 5.0
        emailtf.layer.cornerRadius = 5.0
        nametf.layer.cornerRadius = 5.0
        roletf.layer.cornerRadius = 5.0
        usernametf.layer.cornerRadius = 5.0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var code = 1
    var roles: [String] = []
    
    func isValidEmail(testStr:String) -> Bool {
        
        print("validate emilId: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
        
    }
    
   
    @IBAction func removeall(_ sender: Any) {
        roles.removeAll()
        roletf.text! = roles.minimalDescription
        manageroutlet.isSelected = false
        employeeoutlet.isSelected = false
        scrumoutlet.isSelected = false
        clientoutlet.isSelected = false
    }
    
    @IBOutlet weak var submitbutton: UIButton!
    @IBOutlet weak var emailtf: UITextField!
    
    @IBOutlet weak var nametf: UITextField!
    
    @IBOutlet weak var roletf: UITextField!
    
    @IBOutlet weak var usernametf: UITextField!
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var manageroutlet: UICheckbox!
  
    @IBAction func managerbox(_ sender: Any) {
        if manageroutlet.isSelected == true {
            roles.append("Manager")
            roletf.text! = roles.minimalDescription
        } else {
            roles = roles.filter { $0 != "Manager" }
            roletf.text! = roles.minimalDescription        }
    }
  
    @IBOutlet weak var scrumoutlet: UICheckbox!
    
    @IBAction func scrumbox(_ sender: Any) {
        if scrumoutlet.isSelected == true {
            roles.append("ScrumMaster")
            roletf.text! = roles.minimalDescription
        } else {
            roles = roles.filter { $0 != "ScrumMaster" }
            roletf.text! = roles.minimalDescription        }

    }
    
    @IBOutlet weak var employeeoutlet: UICheckbox!
   
    @IBAction func employeebox(_ sender: Any) {
        if employeeoutlet.isSelected == true {
            roles.append("Employee")
            roletf.text! = roles.minimalDescription
        } else {
            roles = roles.filter { $0 != "Employee" }
            roletf.text! = roles.minimalDescription        }

    }

    @IBOutlet weak var clientoutlet: UICheckbox!
    
    @IBAction func clientbox(_ sender: Any) {
        if clientoutlet.isSelected == true {
            roles.append("Client")
            roletf.text! = roles.minimalDescription        } else {
            roles = roles.filter { $0 != "Client" }
            roletf.text! = roles.minimalDescription        }

    }
    
    
    @IBAction func submit(_ sender: Any) {
        
        let email = emailtf.text!
        let name = nametf.text!
        let role = roles
        let username = usernametf.text!
        let tokenstring = ViewController.GlobalVariable.token
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(tokenstring)",
            "Accept": "application/json"]
        let parameters: Parameters = [
            "name": name,
            "username": username,
            "email": email,
            "role": role]
        if (name != "" && email != "" && roletf.text! != "") {
            if isValidEmail(testStr: "\(email)") == true {
            Alamofire.request("http://tempus.30hills.com/api/v1/user/add", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in guard let data = response.data
                else {return}
                
                let json = JSON(data: data)
                self.code = response.response!.statusCode
                if (self.code == 200) {
                    let alert = UIAlertController(title: "Success!", message: "You have successfully added a user.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{
                        action in self.performSegue(withIdentifier: "backtopeoplelist", sender: self)
                        
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                    
                } else {
                    let alert = UIAlertController(title: "Error!", message: "User already exists.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                }
            } else {
                let alert = UIAlertController(title: "Error!", message: "You have not entered proper email format.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }} else {
            let alert = UIAlertController(title: "Error!", message: "Fields cannot be left blank.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
        
        
        
    }
}
