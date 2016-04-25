//
//  FifthViewController.swift
//  Physioworks
//
//  Created by Alanna Curran on 21/04/2016.
//  Copyright © 2016 Alanna Curran. All rights reserved.
//

import UIKit
import MessageUI

class FifthViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet var txtFirstName: UITextField!
    @IBOutlet var txtLastName: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPhoneNumber: UITextField!
    @IBOutlet var txtMessage: UITextField!
    @IBOutlet var lblConfirm: UILabel!
    var emailMessage:String = ""
    
    @IBAction func btnSubmit(sender: UIButton) {
        self.txtFirstName.resignFirstResponder()
        self.txtLastName.resignFirstResponder()
        self.txtEmail.resignFirstResponder()
        self.txtPhoneNumber.resignFirstResponder()
        self.txtMessage.resignFirstResponder()
        self.lblConfirm.text = "Information sent. Thank you!"
        
        self.emailMessage = String(txtFirstName.text) + " \n" + String(txtLastName.text) + " \n" + String(txtEmail.text) + " \n" + String(txtPhoneNumber.text) + " \n" + String(txtMessage.text);
        
        //emailMessage += " \n" + String(txtEmail.text) + " \n" + String(txtPhoneNumber.text) + " \n" + String(txtMessage.text);
        
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }// End of btnSubmit
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        
        // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["PhysioworksMoycullen@gmail.com"])
        mailComposerVC.setSubject(String(txtFirstName.text) + " " + String(txtLastName.text) + " - Client Form")
        mailComposerVC.setMessageBody(emailMessage, isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        /*let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()*/
        
        let alert = UIAlertController(title: "Could Not Send Email", message:"Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
        self.presentViewController(alert, animated: true){}
        
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}