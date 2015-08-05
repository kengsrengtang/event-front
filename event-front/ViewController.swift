//
//  ViewController.swift
//  event-front
//
//  Created by kengsrengtang on 8/3/15.
//  Copyright (c) 2015 event. All rights reserved.
//

import UIKit
import AddressBook
import RestUtil
class ViewController: UIViewController {

    let phoneNumber = "319 333 6793"
    let authorizationStatus = ABAddressBookGetAuthorizationStatus()
    let addressBookRef: ABAddressBook = ABAddressBookCreateWithOptions(nil, nil).takeRetainedValue()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    @IBAction func buttonPresssed(sender: UIButton) {
        println("you clicked on me")
        

        
        lblDisplay.text = phoneNumber
        switch authorizationStatus {
        case .Denied, .Restricted:
            println("denied")
        case .Authorized:
            println("authorized")
        case .NotDetermined:
            promptForAddressBookRequestAccess(printPhoneNumber)
            println("not sure")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBOutlet weak var lblDisplay: UILabel!
    @IBOutlet weak var printPhoneNumber: UIButton!
    
    func promptForAddressBookRequestAccess(petButton: UIButton) {
        var err: Unmanaged<CFError>? = nil
        
        ABAddressBookRequestAccessWithCompletion(addressBookRef) {
            (granted: Bool, error: CFError!) in
            dispatch_async(dispatch_get_main_queue()) {
                if !granted {
                    println("Just denied")
                } else {
                    println("Just authorized")
                }
            }
        }
    }
    func openSettings() {
        let url = NSURL(string: UIApplicationOpenSettingsURLString)
        UIApplication.sharedApplication().openURL(url!)
    }
    func extractABAddressBookRef(abRef: Unmanaged<ABAddressBookRef>!) -> ABAddressBookRef? {
        if let ab = abRef {
            return Unmanaged<NSObject>.fromOpaque(ab.toOpaque()).takeUnretainedValue()
        }
        return nil
    }
    
}



