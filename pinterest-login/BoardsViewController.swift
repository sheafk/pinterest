//
//  BoardsViewController.swift
//  
//
//  Created by Shea Furey-King on 3/28/17.
//
//

import UIKit
import PinterestSDK
import SwiftyJSON

class BoardsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var boardsTableView: UITableView!
    
    var boards = [Board]() {
        didSet {
            boardsTableView.reloadData()
        }
    }
    
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        boardsTableView.delegate = self
        boardsTableView.dataSource = self
        
        PDKClient.sharedInstance().getAuthenticatedUserBoards(withFields: ["id", "image", "description", "name", "description"], success: { (result) in
            
            if let boardsCluster = result?.parsedJSONDictionary["data"] as? [[String: Any]] {
                self.boards.removeAll()
                for board in boardsCluster {
                    if let board = Board(json: JSON(board)) {
                        self.boards.append(board)
                        print("Success")
                    }
                }
            }
            }, andFailure: nil
        )
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if boards.count != 0 {
            return boards.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "boardCell")
        cell?.textLabel?.text = boards[indexPath.row].name
        cell?.textLabel?.textColor = UIColor.darkGray
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        self.performSegue(withIdentifier: "pinsSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = boardsTableView.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            let board = boards[selectedRow]
            
            if (segue.identifier == "pinsSegue") {
                if let newVC = segue.destination as? PinsViewController {
                    newVC.boardID = board.id
                    newVC.boardName = board.name
                }
            }
            
        }
    }
    
}


