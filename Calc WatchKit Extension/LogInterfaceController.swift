



//
//  LogInterfaceController.swift
//  Calc
//
//  Created by Kormos Adam on 13/01/16.
//  Copyright © 2016 Kormos Adam. All rights reserved.
//

import WatchKit
import Foundation


class LogInterfaceController: WKInterfaceController {
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let str = context as! [String]
        let proba = str[0] + str[1]
        LogLabel.setText(proba)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        //LogLabel.setText("megjelent")
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    @IBOutlet var LogLabel: WKInterfaceLabel!
    
    
    
    
    
}
