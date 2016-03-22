//
//  ViewController.swift
//  PA9
//
//  Created by student on 3/15/16.
//  Copyright © 2016 JLB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var theWheel: WheelView!
    @IBOutlet weak var wheelSizeSlider: UISlider!
    @IBOutlet weak var wheelSizeLabel: UILabel!
    @IBOutlet weak var spokeNumberSlider: UISlider!
    @IBOutlet weak var spokeNumberLabel: UILabel!

    @IBOutlet weak var theClock: ClockView!
    var clockTimer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        clockTimer = NSTimer.scheduledTimerWithTimeInterval(
            1.0,
            target: self,
            selector: Selector("oneSecondPassed:"),
            userInfo: nil,
            repeats: true
        )
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func userChangedWheelSize(sender: UISlider) {
        wheelSizeSlider.value = round(sender.value)
        theWheel.wheelSize = Int(wheelSizeSlider.value)
        wheelSizeLabel.text = "Wheel size: \(Int(wheelSizeSlider.value))\""
    }

    @IBAction func userChangedNumberOfSpokes(sender: UISlider) {
        spokeNumberSlider.value = round(sender.value)
        theWheel.numberOfSpokes = Int(spokeNumberSlider.value)
        spokeNumberLabel.text = "Number of spokes: \(Int(spokeNumberSlider.value))"
    }
    
    @IBAction func userChoseCrossSpokes(sender: UISwitch) {
        theWheel.hasCrossSpokes = !(theWheel.hasCrossSpokes)
    }
    
    @IBAction func userChangedWheelColor(sender: UISegmentedControl) {
        theWheel.wheelColor = theWheel.wheelColorChoices[sender.selectedSegmentIndex]
    }
    
    func oneSecondPassed(timer: NSTimer) {
        theClock.incrementByOneSecond()
    }
}