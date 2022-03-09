//
//  CustomTabBar.swift
//  CustomTabBar
//
//  Created by Mohamed Ramadan on 28/02/2022.
//

import UIKit

@IBDesignable
class CustomTabBar: UITabBar {
    
    private var shapeLayer: CALayer?
    
    override func draw(_ rect: CGRect) {
        self.addShape()
    }
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.fillColor = #colorLiteral(red: 0.9782002568, green: 0.9782230258, blue: 0.9782107472, alpha: 1)
        shapeLayer.lineWidth = 0.1
        shapeLayer.shadowOffset = CGSize(width:0, height:-3)
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowColor = UIColor.lightGray.cgColor
        shapeLayer.shadowOpacity = 0.1
        
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }
    
    func createPath() -> CGPath {
        let height: CGFloat = self.frame.height - UIViewController.safeAreaBottomHeight() //86.0
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        path.move(to: CGPoint(x: 0, y: height/2))
        
        // left curve
        path.addCurve(to: CGPoint(x: 25, y: 0),
                      controlPoint1: CGPoint(x: 0, y: 0),
                      controlPoint2: CGPoint(x: 25, y: 0))
        
        path.addLine(to: CGPoint(x: (centerWidth - height*2), y: 0))
        
        // left curve to center button
//        path.addCurve(to: CGPoint(x: centerWidth, y: height),
//                      controlPoint1: CGPoint(x: centerWidth, y: 0),
//                      controlPoint2: CGPoint(x: centerWidth - height/2, y: height))
//
        path.addCurve(to: CGPoint(x: centerWidth, y: height),
                      controlPoint1: CGPoint(x: (centerWidth - 10), y: 0),
                      controlPoint2: CGPoint(x: (centerWidth - height + 5), y: height))
        
        path.addCurve(to: CGPoint(x: centerWidth + height*2, y: 0),
                      controlPoint1: CGPoint(x: (centerWidth + height - 5), y: height),
                      controlPoint2: CGPoint(x: centerWidth + 10, y: 0))
        
//        path.addArc(withCenter: CGPoint(x: centerWidth, y: 0), radius: (height - 10) - UIViewController.safeAreaBottomHeight() , startAngle: CGFloat(Double.pi), endAngle: 0, clockwise: false)
        
        path.addLine(to: CGPoint(x: self.frame.width-25, y: 0))
        path.addCurve(to: CGPoint(x: self.frame.width, y: 25),
                      controlPoint1: CGPoint(x: self.frame.width, y: 0),
                      controlPoint2: CGPoint(x: self.frame.width, y: 25))
        
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        return path.cgPath
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
        for member in subviews.reversed() {
            let subPoint = member.convert(point, from: self)
            guard let result = member.hitTest(subPoint, with: event) else { continue }
            return result
        }
        return nil
    }
}
