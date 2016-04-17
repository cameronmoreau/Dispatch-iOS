//
//  SignUpViewController.swift
//  Dispatch
//
//  Created by Cameron Moreau on 4/17/16.
//  Copyright © 2016 Mobi. All rights reserved.
//

import UIKit
import SCLAlertView
import JGProgressHUD

class SignUpViewController: UIViewController {
    
    //MARK: - Actions
    @IBAction func btnPolicePressed(sender: ToggleButton) {
        self.handleToggle(sender)
    }
    @IBAction func btnMedicPressed(sender: ToggleButton) {
        self.handleToggle(sender)
    }
    @IBAction func btnFirePressed(sender: ToggleButton) {
        self.handleToggle(sender)
    }
    
    @IBAction func btnDonePressed(sender: UIButton) {
        if tfName.text == "" {
            self.showError("All fields are required!")
            return
        }
        
        
        let hud = JGProgressHUD(style: .Dark)
        hud.textLabel.text = "Loading"
        hud.showInView(self.view)
        
        let newUser = User(type: .Police, name: "Hello1")
        
        api.register(newUser) { user in
            hud.dismiss()
            
            if let user = user {
                user.storeData()
                self.performSegueWithIdentifier("HomeSegue", sender: nil)
            } else {
                self.showError("Uh oh")
            }
        }
    }
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var btnPolice: ToggleButton!
    @IBOutlet weak var btnFire: ToggleButton!
    @IBOutlet weak var btnMedic: ToggleButton!
    
    var lastBtn: ToggleButton?
    var lastType: String?
    let api = ApiManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnPolice.tag = 0
        btnMedic.tag = 1
        btnFire.tag = 2

        self.btnDone.setBackgroundGradient(UIColor.mainGradient())
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    func showError(text: String) {
        SCLAlertView().showError("Error", subTitle: text)
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func handleToggle(sender: ToggleButton) {
        if let lastBtn = lastBtn {
            lastBtn.toggleActive()
        }
        
        lastBtn = sender
        lastBtn?.toggleActive()
        
        switch sender.tag {
        case 1:
            lastType = "medic"
            break
        case 2:
            lastType = "fire"
            break
        default:
            lastType = "police"
            break
        }
    }
}
