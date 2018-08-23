//
//  EditProfileViewController.swift
//  Tempus
//
//  Created by Milos Jakovljevic on 6/14/17.
//  Copyright © 2017 Milos Jakovljeivc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

extension UIImage{
    
    func resizeImageWith(newSize: CGSize) -> UIImage {
        
        let horizontalRatio = newSize.width / size.width
        let verticalRatio = newSize.height / size.height
        
        let ratio = max(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
}

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        updatebutton.layer.cornerRadius = 5.0
        fullnametf.layer.cornerRadius = 5.0
        usernametf.layer.cornerRadius = 5.0
        positiontf.layer.cornerRadius = 5.0
        slacktf.layer.cornerRadius = 5.0
        trellotf.layer.cornerRadius = 5.0
        githubtf.layer.cornerRadius = 5.0
        tabllatf.layer.cornerRadius = 5.0
        hardwaretf.layer.cornerRadius = 5.0
        skillstf.layer.cornerRadius = 5.0
        profilepicture.clipsToBounds = true
        loaddata()
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var code = 1
    
    @IBOutlet weak var updatebutton: UIButton!
    @IBOutlet weak var profilepicture: UIImageView!
    @IBOutlet weak var fullnametf: UITextField!
    @IBOutlet weak var usernametf: UITextField!
    @IBOutlet weak var positiontf: UITextField!
    @IBOutlet weak var slacktf: UITextField!
    @IBOutlet weak var trellotf: UITextField!
    @IBOutlet weak var githubtf: UITextField!
    @IBOutlet weak var tabllatf: UITextField!
    @IBOutlet weak var hardwaretf: UITextField!
    @IBOutlet weak var skillstf: UITextField!
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func loaddata() {
        fullnametf.text = ViewController.GlobalVariable.fullname
        usernametf.text = ViewController.GlobalVariable.username
        positiontf.text = ViewController.GlobalVariable.position
        slacktf.text = ViewController.GlobalVariable.slack
        trellotf.text = ViewController.GlobalVariable.trello
        githubtf.text = ViewController.GlobalVariable.github
        tabllatf.text = ViewController.GlobalVariable.tablla
        hardwaretf.text = ViewController.GlobalVariable.hardware
        skillstf.text = ViewController.GlobalVariable.skills
        let url = URL(string: (ViewController.GlobalVariable.picture))
        if url != nil {
        let data = try? Data(contentsOf: url!)
        if data != nil {
            profilepicture.image = UIImage(data:data!)
        } else {
            print("Nema sliku")
            }}
        
    }
    
    func uploadInfo() {
        
        let profileimage = profilepicture.image!
        let fullname = fullnametf.text!
        let username = usernametf.text!
        let position = positiontf.text!
        let slack = slacktf.text!
        let trello = trellotf.text!
        let github = githubtf.text!
        let tablla = tabllatf.text!
        let hardware = hardwaretf.text!
        let skills = skillstf.text!
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
            "skills": skills]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(tokenstring)",
        "Accept": "application/json"]
        
        Alamofire.request("http://tempus.30hills.com/api/v1/user/edit", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers:headers).responseJSON { response in debugPrint(response)
            self.code = response.response!.statusCode
            if (self.code == 200) {
            ViewController.GlobalVariable.fullname = fullname
            ViewController.GlobalVariable.username = username
            ViewController.GlobalVariable.position = position
            ViewController.GlobalVariable.slack = slack
            ViewController.GlobalVariable.trello = trello
            ViewController.GlobalVariable.github = github
            ViewController.GlobalVariable.tablla = tablla
            ViewController.GlobalVariable.hardware = hardware
            ViewController.GlobalVariable.skills = skills
            } else {
                let alert = UIAlertController(title: "Error!", message: "There has been an error.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }


        }}
    
    func uploadimage() {
        
        guard let imageData = UIImagePNGRepresentation(profilepicture.image!) else { return }
        let tokenstring = ViewController.GlobalVariable.token
        let base64string = imageData.base64EncodedString()
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(tokenstring)",
        "Accept": "application/json"]
        let parameters = ["image": base64string]
        
        
        
        Alamofire.request("http://tempus.30hills.com/api/v1/upload", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in guard let data = response.data else{
               return
            }
            let json = JSON(data: data)
            if ((json["results"].string) != nil){
               ViewController.GlobalVariable.picture = (json["results"].string)! } else { print("Nema to polje") }
        }
        let alert = UIAlertController(title: "Success!", message: "You have successfully edited your info.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{
            action in
            
            self.dismiss(animated: true, completion: nil)
            
            
        }))
        self.present(alert, animated: true, completion: nil)
}
    
    @IBAction func selectimage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
        
    }
    
    
    @IBAction func upload(_ sender: Any) {
        
        uploadimage()
        uploadInfo()
        
        
        
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let newSize = CGSize(width: 256, height: 256)
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as?
            UIImage {
            self.profilepicture.image = pickedImage.resizeImageWith(newSize: newSize)
            picker.dismiss(animated: true, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    
}
