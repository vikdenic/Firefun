//
//  Utilities.swift
//  Firefun
//
//  Created by Vik Denic on 1/30/16.
//  Copyright © 2016 nektar labs. All rights reserved.
//

import UIKit

extension UIAlertController {
    class func showAlert(title : String!, message : String!, viewController : UIViewController)
    {
        let alert : UIAlertController = UIAlertController(title: title,
            message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style:.Default, handler: nil))
        viewController.presentViewController(alert, animated: true, completion: nil)
    }

    class func showAlertWithError(error : NSError!, forVC : UIViewController)
    {
        let alert = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        alert.addAction(okAction)
        forVC.presentViewController(alert, animated: true, completion: nil)
    }
}


extension NSDate {
    func toLocalString() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yy hh:mm a"
        let localTZ = NSTimeZone.localTimeZone()
        formatter.timeZone = localTZ
        return formatter.stringFromDate(self)
    }
}