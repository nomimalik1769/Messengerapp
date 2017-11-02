//
//  ViewController.swift
//  Messenger
//
//  Created by CH on 11/1/17.
//  Copyright © 2017 CH. All rights reserved.
//

import UIKit
import ContactsUI
import MessageUI

class ViewController: UIViewController,CNContactPickerDelegate,MFMessageComposeViewControllerDelegate {

    @IBOutlet weak var textview: UITextView!
    @IBOutlet weak var sendbutton: UIButton!
    @IBOutlet weak var sendbutton2: UIButton!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        textview.layer.cornerRadius = 10
        sendbutton.layer.cornerRadius = 10
        sendbutton2.layer.cornerRadius = 10
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var textfieldnumber: UITextField!
    @IBAction func viasms(_ sender: Any) {
        
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = textview.text!
            controller.recipients = contactnumber
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
        
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result.rawValue) {
        case MessageComposeResult.cancelled.rawValue:
            print("Message was cancelled")
            self.dismiss(animated: true, completion: nil)
        case MessageComposeResult.failed.rawValue:
            print("Message failed")
            self.dismiss(animated: true, completion: nil)
        case MessageComposeResult.sent.rawValue:
            print("Message was sent")
            self.dismiss(animated: true, completion: nil)
        default:
            break;
        }
    }
    
    var namee = ""
    var contactnumber = [String]()
    var contactnames = [String]()
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        contacts.forEach{contact in
        for number in contact.phoneNumbers {
            let phoneNumber = number.value
            // let name = contact.middleName
            contactnumber.append(String(describing: phoneNumber.stringValue))
            print("number is = \(phoneNumber.stringValue)")
            for name in contact.givenName {
                let names = name.description
                namee += names
            }
            contactnames.append(namee)
            namee = ""
        }
    }
        var number = ""
        for j in 0...contactnumber.count - 1
        {
            if number == ""
            {
                number = contactnumber[j]
            }
            else
            {
                number = number+","+contactnumber[j]
            }
        }
        textfieldnumber.text = number
        print(contactnames)
    }
    
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    

     func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func sendmessage(_ sender: Any) {
      /*  let date = Date()
        let msg = "Hi my dear friends\(date)"
        let urlWhats = "whatsapp://send?text=\(msg)"
        
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    UIApplication.shared.openURL(whatsappURL as URL)
                } else {
                    print("please install watsapp")
                }
            }
        }*/
     
       
        let msg = textview.text!
        if msg != ""
        {
            let urlWhats = "whatsapp://send?text=\(msg)"
            if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
                if let whatsappURL = NSURL(string: urlString) {
                    if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                        UIApplication.shared.openURL(whatsappURL as URL)
                    } else {
                        let alertController = UIAlertController(title: "Error", message: "WhatsssApp is not Installed", preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        present(alertController, animated: true, completion: nil)
                        
                    }
                }
            }
        }
        else
        {
            let alertController = UIAlertController(title: "Error", message: "Please type message first", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        }
        
        
    }
    
    
    @IBAction func importcontact(_ sender: Any) {
        let cnPicker = CNContactPickerViewController()
        cnPicker.delegate = self
        self.present(cnPicker, animated: true, completion: nil)
    }
    
    
    


}

