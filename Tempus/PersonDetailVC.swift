//
//  PersonDetailVC.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 6/29/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import UIKit
import Alamofire
import UICheckbox_Swift
import SwiftyJSON



class PersonDetailVC: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate {

    var person: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if person.archived == false {
            archived.isOn = false
        } else {
            archived.isOn = true
        }

        updatebutton.layer.cornerRadius = 5.0
        nametf.layer.cornerRadius = 5.0
        positiontf.layer.cornerRadius = 5.0
        slacktf.layer.cornerRadius = 5.0
        trellotf.layer.cornerRadius = 5.0
        githubtf.layer.cornerRadius = 5.0
        tabllatf.layer.cornerRadius = 5.0
        hardwaretf.layer.cornerRadius = 5.0
        skillstf.layer.cornerRadius = 5.0
        roletf.layer.cornerRadius = 5.0
        roles = person.role!
        if roles.contains("Manager") {
            manageroutlet.isSelected = true
        }
        if roles.contains("ScrumMaster") {
            scrumoutlet.isSelected = true
        }
        if roles.contains("Employee") {
            employeeoutlet.isSelected = true
        }
        if roles.contains("Client") {
            clientoutlet.isSelected = true
        }

        profilepicture.clipsToBounds = true
        let url = URL(string: (person.picture))
        if url != nil {
            let data = try? Data(contentsOf: url!)
            if data != nil {
                profilepicture.image = UIImage(data:data!)
            } else {
                print("Nema sliku")
            }}

        nametf.text = person.name
        usernametf.text = person.username
        positiontf.text = person.position
        slacktf.text = person.slack
        trellotf.text = person.trello
        githubtf.text = person.github
        tabllatf.text = person.tablla
        skillstf.text = person.skills
        hardwaretf.text = person.hardware
        roletf.text = person.role!.minimalDescription

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    var code = 1
    var roles: [String] = []
    @IBOutlet weak var updatebutton: UIButton!
    
    @IBAction func archive(_ sender: Any) {
        if archived.isOn == true {
            person.archived == true
        } else {
            person.archived == false
        }

    }
    @IBOutlet weak var archived: UISwitch!
    @IBOutlet weak var nametf: UITextField!

    @IBOutlet weak var usernametf: UITextField!
  
    @IBOutlet weak var positiontf: UITextField!
    @IBOutlet weak var slacktf: UITextField!
    
    @IBOutlet weak var trellotf: UITextField!
    
    @IBOutlet weak var githubtf: UITextField!
    
    @IBOutlet weak var tabllatf: UITextField!
    
    @IBOutlet weak var hardwaretf: UITextField!
    @IBOutlet weak var skillstf: UITextField!
    
    @IBOutlet weak var roletf: UITextField!
    @IBOutlet weak var profilepicture: UIImageView!
    @IBAction func removeall(_ sender: Any) {
        roles.removeAll()
        roletf.text! = roles.minimalDescription
        manageroutlet.isSelected = false
        employeeoutlet.isSelected = false
        scrumoutlet.isSelected = false
        clientoutlet.isSelected = false
    }
   
    @IBOutlet weak var manageroutlet: UICheckbox!
    
    @IBAction func managerbox(_ sender: Any) {
        if manageroutlet.isSelected == true {
            roles.append("Manager")
            roletf.text! = roles.minimalDescription
        } else {
            roles = roles.filter { $0 != "Manager" }
            roletf.text! = roles.minimalDescription
        }

    }
    
    @IBOutlet weak var scrumoutlet: UICheckbox!
    
    @IBAction func scrumbox(_ sender: Any) {
        if scrumoutlet.isSelected == true {
            roles.append("ScrumMaster")
            roletf.text! = roles.minimalDescription
        } else {
            roles = roles.filter { $0 != "ScrumMaster" }
            roletf.text! = roles.minimalDescription
        }

    }
    
    @IBOutlet weak var employeeoutlet: UICheckbox!
    
    @IBAction func employeebox(_ sender: Any) {
        if employeeoutlet.isSelected == true {
            roles.append("Employee")
            roletf.text! = roles.minimalDescription
        } else {
            roles = roles.filter { $0 != "Employee" }
            roletf.text! = roles.minimalDescription
        }

    }
    
    @IBOutlet weak var clientoutlet: UICheckbox!
    
    @IBAction func clientbox(_ sender: Any) {
        if clientoutlet.isSelected == true {
            roles.append("Client")
            roletf.text! = roles.minimalDescription
        } else {
            roles = roles.filter { $0 != "Client" }
            roletf.text! = roles.minimalDescription
        }

    }
    
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func resetimage(_ sender: Any) {
        let tokenstring = ViewController.GlobalVariable.token
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(tokenstring)",
            "Accept": "application/json"]
        Alamofire.request("http://tempus.30hills.com/api/v1/image/reset/\(person.id!)", method: .get, headers: headers).responseJSON { response in debugPrint(response)
            self.code = response.response!.statusCode
            if (self.code == 200) {
                let alert = UIAlertController(title: "Success!", message: "Picture has been successfully reset.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                    action in self.performSegue(withIdentifier: "backtopeople", sender: self)
                    
                    
                }))
                
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Error!", message: "There has been an error.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }

            
        }

    }
    
    
    
    
    func loadImage() {
        let url = URL(string:
            //ovo promeniti na sliku iz objekta user i dodati posle funkciju u viewdidload
        (ViewController.GlobalVariable.picture))
        if url != nil {
            let data = try? Data(contentsOf: url!)
            if data != nil {
                profilepicture.image = UIImage(data:data!)
            } else {
                print("Nema sliku")
            }}
        
    }
        func uploadInfo() {
        
        let archive = archived.isOn
        let fullname = nametf.text!
        let username = usernametf.text!
        let position = positiontf.text!
        let slack = slacktf.text!
        let trello = trellotf.text!
        let github = githubtf.text!
        let tablla = tabllatf.text!
        let hardware = hardwaretf.text!
        let skills = skillstf.text!
        let role = roles
        let tokenstring = ViewController.GlobalVariable.token
        let parameters: Parameters = [
            "name": fullname,
            "username": username,
            "position": position,
            "slack": slack,
            "trello": trello,
            "github": github,
            "tablla": tablla,
            "hardware": hardware,
            "skills": skills,
            "role": role,
            "archived": archive]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(tokenstring)",
            "Accept": "application/json"]
        
        Alamofire.request("http://tempus.30hills.com/api/v1/user/edit/\(person.id!)", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers:headers).responseJSON { response in debugPrint(response)
            self.code = response.response!.statusCode
            if (self.code == 200) {
                let alert = UIAlertController(title: "Success!", message: "Info successfully updated.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                    action in self.performSegue(withIdentifier: "backtopeople", sender: self)
                    
                    
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Error!", message: "There has been an error.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
            }}

    
        @IBAction func update(_ sender: Any) {
        uploadInfo()
        
    }
    
   
}
