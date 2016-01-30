//
//  ViewController.swift
//  Firefun
//
//  Created by Vik Denic on 1/30/16.
//  Copyright © 2016 nektar labs. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    let ref = Firebase(url: "https://examples-k9i8infracvfyzgxk0t.firebaseio-demo.com/web/struct/join-example")
    var groupsDict = [String : NSDictionary]()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        dataSetup()
    }

    func dataSetup() {
        ref.childByAppendingPath("groups").observeEventType(.Value) { (snapshot: FDataSnapshot!) -> Void in
            self.groupsDict = snapshot.value as! [String : NSDictionary]
            self.tableView.reloadData()
        }
    }

    func viewSetup() {
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    //MARK: Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let messagesVC = segue.destinationViewController as! MessagesViewController
        
        let groupKey = Array(groupsDict.keys)[(tableView.indexPathForSelectedRow?.row)!]
        let group = self.groupsDict[groupKey]


        messagesVC.group = group
        messagesVC.groupKey = groupKey
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GroupCell")! as UITableViewCell

        let key = Array(groupsDict.keys)[indexPath.row]
        let group = self.groupsDict[key]
        cell.textLabel?.text = group?.objectForKey("name") as? String

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsDict.count
    }
}

