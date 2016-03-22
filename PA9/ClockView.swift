//
//  ClockView.swift
//  PA9
//
//  Created by student on 3/16/16.
//  Copyright © 2016 JLB. All rights reserved.
//

import UIKit

class ClockView: UIView {
    
    var clockRadius: CGFloat!
    var clockCenterPoint: CGPoint!
    var clockPath: UIBezierPath!
    
    var timeIntervals: [Int] = [
        0,  // Element 0 = seconds
        0,  // Element 1 = minutes
        0   // Element 2 = hours
    ]
    
    // Clock part measurements
    var clockBezelWidth: CGFloat!
    var minuteHandLength: CGFloat!
    var hourHandLength: CGFloat!
    var handLengths = [CGFloat]()
    
    // Clock part colors
    let clockRimColor = UIColor.blackColor()
    let clockFaceColor = UIColor.whiteColor()
    let handColors: [UIColor] = [UIColor.redColor(), UIColor.greenColor(), UIColor.blueColor()]

    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!

        clockCenterPoint = CGPoint(
            x: (self.bounds.width / 2),
            y: (self.bounds.height / 2)
        )
        
        clockBezelWidth = 2.5
        
        if self.bounds.height > self.bounds.width {
            clockRadius = CGFloat((self.bounds.width / 2) - clockBezelWidth)
        } else {
            clockRadius = CGFloat((self.bounds.height / 2) - clockBezelWidth)
        }
        
        clockPath = UIBezierPath(
            arcCenter: clockCenterPoint,
            radius: clockRadius,
            startAngle: 0,
            endAngle: CGFloat(2 * M_PI),
            clockwise: true
        )
        
        clockPath.lineWidth = clockBezelWidth
        
        minuteHandLength = clockRadius * (2/3)
        hourHandLength = clockRadius * (1/2)
        
        handLengths.append(clockRadius)
        handLengths.append(minuteHandLength)
        handLengths.append(hourHandLength)
    }
    
    
    func incrementByOneSecond() {
        if timeIntervals[0] + 1 == 60 {
            timeIntervals[0] = 0
            
            if timeIntervals[1] + 1 == 60 {
                timeIntervals[1] = 0
                ++timeIntervals[2]
            } else {
                ++timeIntervals[1]
            }
        } else {
            ++timeIntervals[0]
        }
        
        setNeedsDisplay()
    }

    
    override func drawRect(rect: CGRect) {
        // Draw the outside of the clock
        clockRimColor.setStroke()
        clockPath.stroke()
        
        // Fill in the face color
        clockFaceColor.setFill()
        clockPath.fill()
        
        clockPath.closePath()
        
        // Draw the hands
        for n in 0...2 {
            let handLength: CGFloat = handLengths[n]
            
            let handPath = UIBezierPath(
                arcCenter: clockCenterPoint,
                radius: clockRadius,
                startAngle: 0,
                endAngle: CGFloat(2 * M_PI),
                clockwise: true
            )

            handPath.moveToPoint(clockCenterPoint)
            handPath.lineWidth = clockBezelWidth
            
            handPath.addLineToPoint(CGPoint(
                x: Double(clockCenterPoint.x) - Double(handLength) * cos(M_PI_2 + (Double(timeIntervals[n]) * 2 * M_PI / 60)),
                y: Double(clockCenterPoint.y) - Double(handLength) * sin(M_PI_2 + (Double(timeIntervals[n]) * 2 * M_PI / 60))
                ))
            
            let handColor = handColors[n]
            handColor.setStroke()
            handPath.stroke()
            
            handPath.closePath()
        }
    }
}