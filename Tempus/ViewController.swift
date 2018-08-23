//
//  ViewController.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 6/14/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView




class ViewController: UIViewController {
    
    let indicator: NVActivityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0), type: .lineScalePulseOut, color: UIColor().HexToColor(hexString: "8B56B9", alpha: 1.0))
    
   // let indicator:UIActivityIndicatorView = UIActivityIndicatorView  (activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)


    override func viewDidLoad() {
        super.viewDidLoad()
        passwordtf.layer.cornerRadius = 5.0
        usernametf.layer.cornerRadius = 5.0
        loginbutton.layer.cornerRadius = 5.0
        //registerbutton.layer.cornerRadius = 5.0
        //Thread.sleep(forTimeInterval: 1.0)
        // Do any additional setup after loading the view, typically from a nib.
    }
    struct GlobalVariable{
        static var token = String()
        static var fullname = String()
        static var username = String()
        static var position = String()
        static var slack = String()
        static var trello = String()
        static var github = String()
        static var tablla = String()
        static var hardware = String()
        static var skills = String()
        static var picture = String()
        //static var projects = [String: Any]()
    }
    var code = 1
    let url = ""

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func hideActivityIndicator() {
        self.indicator.stopAnimating()
        self.indicator.isHidden = true
    }
    
    func blur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(blurEffectView)
    }
    
    func animateindicator() {
       // self.indicator.color = UIColor().HexToColor(hexString: "8B56B9", alpha: 1.0)
       // self.indicator.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
        //self.indicator.transform = CGAffineTransform(scaleX: 2, y: 2)
        self.indicator.backgroundColor = UIColor().HexToColor(hexString: "7F7F7F", alpha: 0.0)
        self.indicator.layer.cornerRadius = 5.0
        self.indicator.center = self.view.center
        self.view.addSubview(self.indicator)
        self.indicator.bringSubview(toFront: self.view)
        self.indicator.startAnimating()
    }
    
    func auth() {
        
        
    }

   
    @IBOutlet weak var loginbutton: UIButton!
    @IBOutlet weak var passwordtf: UITextField!
    @IBOutlet weak var usernametf: UITextField!
    @IBAction func login(_ sender: Any) {
        
        let username = usernametf.text!
        let password = passwordtf.text!
        
        let parameters: Parameters = [
            "email": username,
            "password": password ]
        
        
        if (username != "" && password != "") {
            
            //http://tempus.30hills.com
            //10.0.30.159:8010
        
            Alamofire.request("http://tempus.30hills.com/api/v1/auth", method: .post, parameters: parameters).responseJSON { response in guard let data = response.data else {
                
                return
                }
                let json = JSON(data: data)
                if (json["token"].string == nil) {
                    let message = json["message"].stringValue
                    if message == nil {
                        let alert = UIAlertController(title: "Error!", message: "Server is down.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    } else {
                    let alert = UIAlertController(title: "Error!", message: "\(message).", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    }}else{
                GlobalVariable.token = (json["token"].string)!
                
                let role = (json["results"]["role"].array)!
                self.code = response.response!.statusCode
            if (self.code == 200) {
                if ((json["results"]["name"].string) != nil){
                    GlobalVariable.fullname = (json["results"]["name"].string)! } else { print("Nema to polje") }
                if ((json["results"]["username"].string) != nil) {
                    GlobalVariable.username = (json["results"]["username"].string)! }
                else { print("Nema to polje") }

                if ((json["results"]["picture"].string) != nil) {
                    GlobalVariable.picture = (json["results"]["picture"].string)! }
                else { print("Nema to polje") }
                if ((json["results"]["description"]["position"].string) != nil) {
                    GlobalVariable.position = (json["results"]["description"]["position"].string)! }
                else { print("Nema to polje") }

                if ((json["results"]["description"]["slack"].string) != nil) {
                    GlobalVariable.slack = (json["results"]["description"]["slack"].string)! }
                else { print("Nema to polje") }
                if ((json["results"]["description"]["trello"].string) != nil) {
                    GlobalVariable.trello = (json["results"]["description"]["trello"].string)! }
                else { print("Nema to polje") }

                if ((json["results"]["description"]["github"].string) != nil) { GlobalVariable.github = (json["results"]["description"]["github"].string)! }
                else { print("Nema to polje") }

                if ((json["results"]["description"]["tablla"].string) != nil) { GlobalVariable.tablla = (json["results"]["description"]["tablla"].string)! }
                else { print("Nema to polje") }

                if ((json["results"]["description"]["hardware"].string) != nil) { GlobalVariable.hardware = (json["results"]["description"]["hardware"].string)! }
                else { print("Nema to polje") }

                if ((json["results"]["description"]["skills"].string) != nil) { GlobalVariable.skills = (json["results"]["description"]["skills"].string)! }
                else { print("Nema to polje") }
                

                if (role.contains("Manager") == true) {
                    self.blur()
                    self.animateindicator()
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        self.performSegue(withIdentifier: "editprofilescrum", sender: nil)
                    })
                   // self.perform(#selector(ViewController.hideActivityIndicator), with: nil, afterDelay: 2.0)
                    

                } else if (role.contains("ScrumMaster") == true) {
                    self.blur()
                    self.animateindicator()
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        self.performSegue(withIdentifier: "editprofilescrum", sender: nil)
                    })
                } else  if
                    (role.contains("Employee") == true) {
                        self.blur()
                        self.animateindicator()
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                            self.performSegue(withIdentifier: "editprofile", sender: nil)
                        })
 
                }
            }
                }}} else {
            let alert = UIAlertController(title: "Error!", message: "Fields cannot be left blank.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
        
    }
}





