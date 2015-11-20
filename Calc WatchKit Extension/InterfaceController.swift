//
//  InterfaceController.swift
//  Calc WatchKit Extension
//
//  Created by Kormos Adam on 16/11/15.
//  Copyright © 2015 Kormos Adam. All rights reserved.
//

import WatchKit
import Foundation

enum modes {
    case NOT_SET
    case ADDITION
    case SUBTRACTION
    case MULTIPLICATION
    case DIVISION
}


class InterfaceController: WKInterfaceController {
    
    
    var labelString:String = "0"
    var currentMode :modes = modes.NOT_SET
    var savedNum:Double = 0
    var lastButtonWasMode = false
    var isThereDot = false
    
    @IBOutlet var label: WKInterfaceLabel!
    @IBAction func tapped0() {tappedNumber(0)}
    @IBAction func tapped1() {tappedNumber(1)}
    @IBAction func tapped2() {tappedNumber(2)}
    @IBAction func tapped3() {tappedNumber(3)}
    @IBAction func tapped4() {tappedNumber(4)}
    @IBAction func tapped5() {tappedNumber(5)}
    @IBAction func tapped6() {tappedNumber(6)}
    @IBAction func tapped7() {tappedNumber(7)}
    @IBAction func tapped8() {tappedNumber(8)}
    @IBAction func tapped9() {tappedNumber(9)}
    
    func tappedNumber(num:Double){
        if lastButtonWasMode {
            lastButtonWasMode = false
            labelString = "0"
        }
        
        labelString = labelString.stringByAppendingString("\(Int32(num))") // ez itt double gyoker
        updateText()
        WKInterfaceDevice.currentDevice().playHaptic(.DirectionUp)
    }
    
    func updateText(){
        guard let labelInt:Double = Double(labelString) else {
            label.setText("Kormos Adam")
            return
        }
        savedNum = (currentMode == modes.NOT_SET) ? labelInt : savedNum
        if ((labelInt % 1) != 0) {isThereDot = true}
        if isThereDot == false {
            label.setText("\(Int64(labelInt))")
            labelString = "\(Int64(labelInt))"
            //label.setText(labelString)
            
        }
        else {
            //label.setText("\(labelInt)")
            label.setText(labelString)
        }
        
        
    }
    
    @IBAction func tappedDot(){
        
        if ((Double(labelString)! % 1) != 0){ isThereDot = true}
        
        if  isThereDot {WKInterfaceDevice.currentDevice().playHaptic(.Failure)}
        else
        {
            if lastButtonWasMode {
            lastButtonWasMode = false
            labelString = "0"
        }
        
        labelString = labelString.stringByAppendingString(".")
            WKInterfaceDevice.currentDevice().playHaptic(.DirectionUp)
        isThereDot = true
            updateText()
        }
        
       
    }
    
    @IBAction func tappedPlus() {
        changeMode(modes.ADDITION)
    }
    
    @IBAction func tappedMinus() {
        changeMode(modes.SUBTRACTION)
    }
    
    @IBAction func tappedEquals() {
        WKInterfaceDevice.currentDevice().playHaptic(.Success)
        
        guard let num:Double = Double(labelString) else {
        return
        }
        if currentMode == modes.NOT_SET || lastButtonWasMode {
        return
        }
        if currentMode == modes.ADDITION {
        savedNum += num
        }
        else if currentMode == modes.SUBTRACTION {
        savedNum -= num
        }
        else if currentMode == modes.MULTIPLICATION {
        savedNum *= num
        }
        else if currentMode == modes.DIVISION {
            let temp =  num
            if temp == 0.0 {
                tappedClear()
                label.setText("Err")
                return
            }
            
            let result : Double = savedNum / temp
             currentMode = modes.NOT_SET
            labelString = "\(result)"
            
            guard let labelInt:Double = Double(result) else {
                label.setText("Tul nagy szam")
                return
            }
            savedNum = (currentMode == modes.NOT_SET) ? labelInt : savedNum
            label.setText("\(labelInt)")
            
             //label.setText("osztasz")
            
             lastButtonWasMode = true
           
            return
        }
        
        currentMode = modes.NOT_SET
        labelString = "\(savedNum)"
        updateText()
        lastButtonWasMode = true
    }
    
    func changeMode (newMode:modes){
        WKInterfaceDevice.currentDevice().playHaptic(.DirectionDown)
    
        //if savedNum == 0 {  return }
        currentMode = newMode
        lastButtonWasMode = true
        isThereDot = false
    }
    
    @IBAction func tappedClear() {
        
        savedNum = 0
        labelString = "0"
        label.setText("0")
        currentMode = modes.NOT_SET
        lastButtonWasMode = false
        isThereDot = false
        WKInterfaceDevice.currentDevice().playHaptic(.Retry)
        
    }
    
    @IBAction func tappedMultiple() {
        changeMode(modes.MULTIPLICATION)
    }
    
    @IBAction func tappedDivide() {
        changeMode(modes.DIVISION)
    }
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}