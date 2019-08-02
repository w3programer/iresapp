//
//  UIView + extension.swift
//  Iris
//
//  Created by mahmoudhajar on 2/5/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit

extension UIView {
    
    func roundView() {
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
    
    func floatView() {
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 4
    }
    
    func circleView() {
        
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        
    }
    
    func cornerView() {
        self.layer.cornerRadius = 1.0
        self.clipsToBounds = true
    }
    
    
    func roundSingleConrner(_ corners:UIRectCorner,_ cormerMask:CACornerMask, radius: CGFloat) {
            if #available(iOS 11.0, *){
                self.clipsToBounds = false
                self.layer.cornerRadius = radius
                self.layer.maskedCorners = cormerMask
            }else{
                let rectShape = CAShapeLayer()
                rectShape.bounds = self.frame
                rectShape.position = self.center
                rectShape.path = UIBezierPath(roundedRect: self.bounds,    byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
                self.layer.mask = rectShape
            }
        }
    
    
    func appStoreView() {
        
        self.layer.cornerRadius = 20.0
         self.layer.shadowColor = UIColor.gray.cgColor
          self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
           self.layer.shadowRadius = 12.0
            self.layer.shadowOpacity = 0.7
             self.layer.masksToBounds = false
        
    }
    
    func setBottomRoundedEdge(desiredCurve: CGFloat?) {
        let offset: CGFloat = self.frame.width / desiredCurve!
        let bounds: CGRect = self.bounds
        
        let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height / 2)
        let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
        let ovalBounds: CGRect = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
        let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        
        // Create the shape layer and set its path
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        
        // Set the newly created shape layer as the mask for the view's layer
        self.layer.mask = maskLayer
    }
    
    
    func setRoundCorners(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    
    
}
