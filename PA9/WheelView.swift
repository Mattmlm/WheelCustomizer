//
//  WheelView.swift
//  PA9
//
//  Created by student on 3/15/16.
//  Copyright © 2016 JLB. All rights reserved.
//

import UIKit

class WheelView: UIView {
    var wheelCenterPoint: CGPoint!
    var tireRadius: CGFloat!
    
    var wheelRadius: CGFloat {
        get {
            return tireRadius - tireWidth
        }
    }
    
    var tireWidth: CGFloat {
        get {
            return CGFloat(55 - wheelSize * 2)
        }
    }
    
    var numberOfSpokes:Int = 5 {
        didSet {
            if numberOfSpokes < 5 || numberOfSpokes > 10 {
                numberOfSpokes = oldValue
            }
            setNeedsDisplay()
        }
    }
    
    var wheelSize: Int = 16 {
        didSet {
            if wheelSize < 16 || wheelSize > 20 {
                wheelSize = oldValue
            }
            setNeedsDisplay()
        }
    }
    
    var hasCrossSpokes: Bool = false
    
    let wheelColorChoices: [UIColor] = [
        UIColor.lightGrayColor(),
        UIColor.whiteColor(),
        UIColor.blackColor(),
        UIColor.brownColor(),
        UIColor.grayColor()
    ]
    
    var wheelColor: UIColor = UIColor.lightGrayColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        wheelCenterPoint = CGPoint(
            x: (self.bounds.width / 2),
            y: (self.bounds.height / 2)
        )
        
        if self.bounds.height > self.bounds.width {
            tireRadius = CGFloat(self.bounds.width / 2) - tireWidth
        } else {
            tireRadius = CGFloat(self.bounds.height / 2) - tireWidth
        }
    }
    
    override func drawRect(rect: CGRect) {
        // First, we'll draw the tire
        let tirePath = UIBezierPath(
            arcCenter: wheelCenterPoint,
            radius: tireRadius,
            startAngle: 0,
            endAngle: CGFloat(2 * M_PI),
            clockwise: true
        )

        tirePath.lineWidth = tireWidth
        tirePath.stroke()
        
        // Second, we'll draw the rim of the wheel
        let wheelPath = UIBezierPath(
            arcCenter: wheelCenterPoint,
            radius: wheelRadius,
            startAngle: 0,
            endAngle: CGFloat(2 * M_PI),
            clockwise: true
        )
        
        let wheelStrokeColor = wheelColor
        wheelStrokeColor.setStroke()
        
        wheelPath.lineWidth = 10
        wheelPath.stroke()
        
        // Third, we'll draw the spokes
        if hasCrossSpokes == false {
            for n in 0..<numberOfSpokes {
                wheelPath.moveToPoint(wheelCenterPoint)
                
                // I used M_PI_2 because I wanted the first spoke to be drawn at 90 degrees,
                // but it looks like it's getting drawn at 270 degrees instead.
                wheelPath.addLineToPoint(CGPoint(
                    x: Double(wheelCenterPoint.x) + Double(wheelRadius) * cos(M_PI_2 + (Double(n) * 2 * M_PI / Double(numberOfSpokes))),
                    y: Double(wheelCenterPoint.y) + Double(wheelRadius) * sin(M_PI_2 + (Double(n) * 2 * M_PI / Double(numberOfSpokes)))
                    ))
                
                wheelPath.stroke()
            }
        } else {
            // Do the same exact thing until I can figure out how to draw cross spokes
            
            for n in 0..<numberOfSpokes {
                wheelPath.moveToPoint(wheelCenterPoint)

                wheelPath.addLineToPoint(CGPoint(
                    x: Double(wheelCenterPoint.x) + Double(wheelRadius) * cos(M_PI_2 + (Double(n) * 2 * M_PI / Double(numberOfSpokes))),
                    y: Double(wheelCenterPoint.y) + Double(wheelRadius) * sin(M_PI_2 + (Double(n) * 2 * M_PI / Double(numberOfSpokes)))
                    ))
                
                wheelPath.stroke()
            }
        }

        
        // Finally, we'll draw the hub of the wheel
        let hubPath = UIBezierPath(
            arcCenter: wheelCenterPoint,
            radius: wheelRadius / 3,
            startAngle: 0,
            endAngle: CGFloat(2 * M_PI),
            clockwise: true
        )
        
        let hubFillColor = wheelColor
        hubFillColor.setFill()
        
        hubPath.fill()
        hubPath.closePath()
    }
}
