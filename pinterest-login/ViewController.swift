//
//  ViewController.swift
//  pinterest-login
//
//  Created by Shea Furey-King on 3/26/17.
//  Copyright © 2017 sfk. All rights reserved.
//

import UIKit
import PinterestSDK

class ViewController: UIViewController {
    
    var pinterestLoginSuccess = false

    @IBOutlet weak var authenticateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authenticateButton.layer.cornerRadius = 5
        authenticateButton.backgroundColor = UIColor.lightGray
        authenticateButton.titleLabel?.textColor = UIColor.darkGray
        authenticateButton.alpha = 0.8
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func authenticate(_ sender: AnyObject) {
        PDKClient.sharedInstance().authenticate(withPermissions:
            [PDKClientReadPublicPermissions,
             PDKClientWritePublicPermissions,
             PDKClientReadRelationshipsPermissions,
             PDKClientWriteRelationshipsPermissions], from: self,
                                                      withSuccess: { (response) in
                                                        self.pinterestLoginSuccess = true;
                                                        
                                                        print("User authenticated!")
                                                        
                                                        self.performSegue(withIdentifier: "boardSegue", sender: sender);
  
        }) { (error) in
            print("Error authenticating \(error).")
        }
    }
    
}



