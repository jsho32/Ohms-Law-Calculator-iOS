//
//  ViewController.swift
//  Calculator
//
//  Created by Justin Shores on 6/22/15.
//  Copyright © 2015 Justin Shores. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController {
    @IBOutlet weak var volts: UITextField!
    @IBOutlet weak var amps: UITextField!
    @IBOutlet weak var ohms: UITextField!
    @IBOutlet weak var watts: UITextField!
    @IBOutlet var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bannerView.adUnitID = "ca-app-pub-9576690340592468/1427825232"
        self.bannerView.rootViewController = self
        
        let request: GADRequest = GADRequest()
        //request.testDevices = [GAD_SIMULATOR_ID]
        
        self.bannerView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // only purpose is to close the textfield input keyboard when touching outside of fields
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }

    // Calculate button from UI
    @IBAction func calculate() {
        if checkEntries() {
            getCalculations()
        } else {
            showInvalidEntriesAlert()
        }
    }
    
    // help button from UI
    @IBAction func help() {
        let invalidAlert = UIAlertController(title: "Help", message: "Enter values in exactly 2 fields. \n Then press calculate!\n Reset button returns all fields to \"0\"", preferredStyle: UIAlertControllerStyle.Alert)
        
        invalidAlert.addAction(UIAlertAction(title: "Ok, Got it!", style: .Default, handler: { (action: UIAlertAction!) in
            // do nothing just close
        }))
        
        presentViewController(invalidAlert, animated: true, completion: nil)
    }
    
    // more button from UI
    @IBAction func more() {
        // TODO: implement more when developer console is setup
    }
    
    // share button from UI
    @IBAction func share() {
        // TODO: implement share
    }
    
    // reset button from UI
    @IBAction func reset() {
        for view in self.view.subviews as [UIView] {
            if let textField = view as? UITextField {
                textField.text = "0"
            }
        }
    }
    
    // Shows an alert because user did not enter the correct amount of values
    func showInvalidEntriesAlert() {
        let invalidAlert = UIAlertController(title: "Uh oh!", message: "Please enter values in exactly 2 fields.", preferredStyle: UIAlertControllerStyle.Alert)
        
        invalidAlert.addAction(UIAlertAction(title: "Ok, Got it!", style: .Default, handler: { (action: UIAlertAction!) in
            // do nothing just close
        }))
        
        presentViewController(invalidAlert, animated: true, completion: nil)
    }
    
    // evaluates and sets values for feilds
    func getCalculations() {
        if (volts.text != "0" && amps.text != "0") {
            let ohmsValue = Double(volts.text!)! / Double(amps.text!)!
            let wattsValue = Double(volts.text!)! * Double(amps.text!)!
            ohms.text = String(ohmsValue)
            watts.text = String(wattsValue)
        } else if (volts.text != "0" && ohms.text != "0") {
            let ampsValue = Double(volts.text!)!  / Double(ohms.text!)!
            let wattsValue = (pow(Double(volts.text!)!, 2)) / Double(ohms.text!)!
            amps.text = String(ampsValue)
            watts.text = String(wattsValue)
        } else if (volts.text != "0" && watts.text != "0") {
            let ampsValue = Double(watts.text!)! / Double(volts.text!)!
            let ohmsValue = (pow(Double(volts.text!)!, 2)) / Double(watts.text!)!
            amps.text = String(ampsValue)
            ohms.text = String(ohmsValue)
        } else if (amps.text != "0" && ohms.text != "0") {
            let voltsValue = Double(amps.text!)! * Double(ohms.text!)!
            let wattsValue = (pow(Double(amps.text!)!, 2)) * Double(ohms.text!)!
            volts.text = String(voltsValue)
            watts.text = String(wattsValue)
        } else if (amps.text != "0" && watts.text != "0") {
            let voltsValue = Double(watts.text!)! / Double(amps.text!)!
            let ohmsValue =  Double(watts.text!)! / (pow(Double(amps.text!)!, 2))
            volts.text = String(voltsValue)
            ohms.text = String(ohmsValue)
        } else if (ohms.text != "0" && watts.text != "0") {
            let voltsValue = sqrt(Double(ohms.text!)! * Double(watts.text!)!)
            let ampsValue = sqrt(Double(watts.text!)! / Double(ohms.text!)!)
            volts.text = String(voltsValue)
            amps.text = String(ampsValue)
        }
    }
    
    // returns true if user entered exactly 2 values
    func checkEntries() -> Bool {
        var enteredValues = 0
        for view in self.view.subviews as [UIView] {
            if let textField = view as? UITextField {
                if textField.text != "0" {
                    enteredValues += 1
                    print("\(enteredValues)")
                }
            }
        }
        
        if enteredValues == 2 {
            return true
        } else {
            return false
        }
    }

}

