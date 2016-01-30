//
//  MessagesViewController.swift
//  Firefun
//
//  Created by Vik Denic on 1/30/16.
//  Copyright © 2016 nektar labs. All rights reserved.
//

import UIKit
import Firebase

class MessagesViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    let ref = Firebase(url: "https://examples-k9i8infracvfyzgxk0t.firebaseio-demo.com/web/struct/join-example")
    var group : NSDictionary!
    var groupKey : String!
    var messagesDict = [String : NSDictionary]()
    var groupMessages = [String : NSDictionary]()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        dataSetup()
    }

    func dataSetup() {
        ref.childByAppendingPath("messages").observeEventType(.Value) { (snapshot: FDataSnapshot!) -> Void in

            self.messagesDict = snapshot.value as! [String : NSDictionary]

            guard let someGroupMessages = self.messagesDict[self.groupKey] as! [String : NSDictionary]? else {
                return
            }
            
            self.groupMessages = someGroupMessages
            print(self.groupMessages)
            self.tableView.reloadData()
        }
    }

    func viewSetup() {
        self.title = group.objectForKey("name") as? String
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
}

extension MessagesViewController: UITableViewDataSource, UITableViewDelegate {
    //MARK - DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesDict.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageCell")! as UITableViewCell

        let key = Array(self.groupMessages.keys)[indexPath.row]
        let message = groupMessages[key]
        cell.textLabel?.text = message?.objectForKey("message") as? String
        cell.detailTextLabel?.text = message?.objectForKey("user") as? String

        return cell
    }

    //MARK - Delegate   
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let key = Array(self.groupMessages.keys)[indexPath.row]
        let message = groupMessages[key]

        let authorsName = message!.objectForKey("user") as? String
        let timeStamp = message!.objectForKey("timestamp") as? NSTimeInterval
        let date = NSDate(timeIntervalSince1970:timeStamp!)

        UIAlertController.showAlert(authorsName, message: date.toLocalString(), viewController: self)
    }
}
