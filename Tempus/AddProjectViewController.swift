//
//  AddProjectViewController.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 6/26/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddProjectViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        projectnametf.layer.cornerRadius = 5.0
        clientemailtf.layer.cornerRadius = 5.0
        trellourltf.layer.cornerRadius = 5.0
        teamleadtf.layer.cornerRadius = 5.0
        submitbutton.layer.cornerRadius = 5.0
        parseJSON()
        self.dropdown.isHidden = true
        self.dropdown.layer.cornerRadius = 10
        self.colorbar.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var code = 1
    var colorstring = ""
    var person = [Person]()
    var lead: String!
    var teamlead: String!
    
    @IBOutlet weak var colorbar: UIView!
    @IBOutlet weak var dropdown: UIPickerView!
    @IBOutlet weak var projectnametf: UITextField!
        
    @IBOutlet weak var clientemailtf: UITextField!
    
    @IBOutlet weak var teamleadtf: UITextField!
    
    @IBOutlet weak var trellourltf: UITextField!
    
    @IBOutlet weak var submitbutton: UIButton!
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func redbutton(_ sender: Any) {
        
        colorstring = "#D0011B"
        self.colorbar.backgroundColor = UIColor().HexToColor(hexString: "\(colorstring.lowercased())", alpha: 0.7)
    }
   

    @IBAction func orangebutton(_ sender: Any) {
        
        colorstring = "#F6A623"
        self.colorbar.backgroundColor = UIColor().HexToColor(hexString: "\(colorstring.lowercased())", alpha: 0.7)
    }
    
    @IBAction func yellowbutton(_ sender: Any) {
        colorstring = "#F8E81C"
        self.colorbar.backgroundColor = UIColor().HexToColor(hexString: "\(colorstring.lowercased())", alpha: 0.7)
    }

    @IBAction func brownbutton(_ sender: Any) {
        
        colorstring = "#8B572A"
        self.colorbar.backgroundColor = UIColor().HexToColor(hexString: "\(colorstring.lowercased())", alpha: 0.7)
    }
    
    
    @IBAction func greenbutton(_ sender: Any) {
        
        colorstring = "#7ED321"
        self.colorbar.backgroundColor = UIColor().HexToColor(hexString: "\(colorstring.lowercased())", alpha: 0.7)
    }
    
    
  
    @IBAction func darkgreenbutton(_ sender: Any) {
        
        colorstring = "#417505"
        self.colorbar.backgroundColor = UIColor().HexToColor(hexString: "\(colorstring.lowercased())", alpha: 0.7)
    }
    
    
    @IBAction func pinkbutton(_ sender: Any) {
        
        colorstring = "#BD0FE1"
        self.colorbar.backgroundColor = UIColor().HexToColor(hexString: "\(colorstring.lowercased())", alpha: 0.7)
    }
    
    @IBAction func purplebutton(_ sender: Any) {
        
        colorstring = "#9012FE"
        self.colorbar.backgroundColor = UIColor().HexToColor(hexString: "\(colorstring.lowercased())", alpha: 0.7)
    }
    
    @IBAction func bluebutton(_ sender: Any) {
        
        colorstring = "#4990E2"
        self.colorbar.backgroundColor = UIColor().HexToColor(hexString: "\(colorstring.lowercased())", alpha: 0.7)
    }
   
    @IBAction func lightbluebutton(_ sender: Any) {
        
        colorstring = "#50E3C2"
        self.colorbar.backgroundColor = UIColor().HexToColor(hexString: "\(colorstring.lowercased())", alpha: 0.7)
    }
    
    
    @IBAction func lightgreenbutton(_ sender: Any) {
        
        colorstring = "#B8E986"
        self.colorbar.backgroundColor = UIColor().HexToColor(hexString: "\(colorstring.lowercased())", alpha: 0.7)
    }
    
    
    @IBAction func graybutton(_ sender: Any) {
        
        colorstring = "#9B9B9B"
        self.colorbar.backgroundColor = UIColor().HexToColor(hexString: "\(colorstring.lowercased())", alpha: 0.7)
    }
    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return person.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        self.view.endEditing(true)
        return person[row].name
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.teamleadtf.text = self.person[row].name
        lead = self.person[row].id
        
        self.dropdown.isHidden = true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if teamleadtf == self.teamleadtf {
            self.dropdown.isHidden = false

            
            teamleadtf.endEditing(true)
        }
        
    }
    func parseJSON() {
        let tokenstring = ViewController.GlobalVariable.token
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(tokenstring)",
            "Accept": "application/json"]
        
        Alamofire.request("http://tempus.30hills.com/api/v1/user/show",headers: headers).responseJSON { response in guard let data = response.data
            else {return}
            let json = JSON(data: data)
            let users = json["user"].arrayValue
            for user in users {
                
                let slack = user["description"]["slack"].stringValue
                let position = user["description"]["position"].stringValue
                let github = user["description"]["github"].stringValue
                let skills = user["description"]["skills"].stringValue
                let tablla = user["description"]["tablla"].stringValue
                let trello = user["description"]["trello"].stringValue
                let hardware = user["description"]["hardware"].stringValue
                let jrole = user["role"].arrayValue
                var role:[String] = jrole.map { $0.stringValue}
                let name = user["name"].stringValue
                let id = user["_id"].stringValue
                let username = user["username"].stringValue
                let picture = user["picture"].stringValue
                let archived = user["archived"].boolValue
                
                let osoba = Person(id: id, name: name, username: username, picture: picture, slack: slack, position: position, github: github, skills: skills, tablla: tablla, trello: trello, hardware: hardware, role: role, archived: archived)
                self.person.append(osoba)
            }
            
            self.dropdown.reloadAllComponents()
            
        }
    }
        
    @IBAction func submit(_ sender: Any) {
        
        let projectname = projectnametf.text!
        let clientemail = clientemailtf.text!
        if let tlead = lead {
            teamlead = tlead
        }
        let trellourl = trellourltf.text!
        
        let tokenstring = ViewController.GlobalVariable.token
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(tokenstring)",
            "Accept": "application/json"]
        let parameters: Parameters = [
            "name": projectname,
            "clientName": clientemail,
            "projectLead": teamlead,
            "color" : colorstring,
            "trello" : trellourl]
        
        if (projectname != "" && clientemail != "" && teamlead != "") {
            
            Alamofire.request("http://tempus.30hills.com/api/v1/project/add", method: .post, parameters: parameters, headers: headers).responseJSON { response in debugPrint(response)
                self.code = response.response!.statusCode
                if (self.code == 200) {
                    let alert = UIAlertController(title: "Success!", message: "You have successfully created a project.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{
                        action in self.performSegue(withIdentifier: "backtoprojectlist", sender: self) }))
                    self.present(alert, animated: true, completion: nil)
                    
                    
                } else {
                    let alert = UIAlertController(title: "Error!", message: "Project already exists.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            let alert = UIAlertController(title: "Error!", message: "Fields cannot be left blank.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)

            
        }
    
        
    
    
    }
}
