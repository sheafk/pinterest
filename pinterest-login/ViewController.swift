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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func authenticate(_ sender: AnyObject) {
        
        PDKClient.sharedInstance().authenticate(withPermissions:
            [PDKClientReadPublicPermissions,
             PDKClientWritePublicPermissions,
             PDKClientReadRelationshipsPermissions,
             PDKClientWriteRelationshipsPermissions], from: self,
                                                      withSuccess: { (response) in
                                                        self.pinterestLoginSuccess = true;
                                                        print("User authenticated!)");
                                                        //TODO: If true, will move user to BoardsViewController
        }) { (error) in
            print("Error authenticating \(error).")
        }
    }
    
}



