//
//  PinsViewController.swift
//  pinterest-login
//
//  Created by Shea Furey-King on 3/28/17.
//  Copyright © 2017 sfk. All rights reserved.
//

import UIKit
import PinterestSDK
import SwiftyJSON

class PinsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var boardID: String? = ""
    var boardName: String? = ""
    
    var pins = [Pin]() {
        didSet {
            pinsTableView.reloadData()
        }
    }
    
    @IBOutlet weak var pinsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pinsTableView.delegate = self
        pinsTableView.dataSource = self
        
        PDKClient.sharedInstance().getBoardPins(boardID, fields: ["note", "image", "url"], withSuccess: { (result) in
            if let pinsCluster = result?.parsedJSONDictionary["data"] as? [[String : Any]] {
                self.pins.removeAll()
                for pin in pinsCluster {
                    if let pin = Pin(json: JSON(pin)) {
                        self.pins.append(pin)
                    }
                    print(pinsCluster)
                }
            }
            }, andFailure: nil)
        
        pinsTableView.rowHeight = UITableViewAutomaticDimension
        pinsTableView.estimatedRowHeight = 140
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if pins.count != 0 {
            return pins.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pinsTableView.dequeueReusableCell(withIdentifier: "pinCell",
        
        for: indexPath) as! PinTableViewCell

        if let imageURL = pins[indexPath.row].image {
            let url = NSURL(string: imageURL)
            if let data = NSData(contentsOf: url! as URL) {
                cell.imageView?.image = UIImage(data: data as Data)
            }
        }

        cell.noteLabel.text = pins[indexPath.row].note
        cell.noteLabel.textColor = UIColor.darkGray
        cell.noteLabel.textAlignment = .center
        cell.selectionStyle = .none
        return cell
    }

}
