//
//  NVActivityIndicatorAnimationBallScaleRippleMultiple.swift
//  NVActivityIndicatorViewDemo
//
//  Created by Nguyen Vinh on 7/24/15.
//  Copyright (c) 2015 Nguyen Vinh. All rights reserved.
//

import UIKit

class NVActivityIndicatorAnimationBallScaleRippleMultiple: NVActivityIndicatorAnimationDelegate {
    
    func setUpAnimationInLayer(layer: CALayer, size: CGSize, color: UIColor) {
        let duration: CFTimeInterval = 1.25
        let beginTime = CACurrentMediaTime()
        let beginTimes = [0.0, 0.2, 0.4]
        let timingFunction = CAMediaTimingFunction(controlPoints: 0.21, 0.53, 0.56, 0.8)
        
        // Scale animation
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        
        scaleAnimation.keyTimes = [0, 0.7]
        scaleAnimation.timingFunction = timingFunction
        scaleAnimation.values = [0, 1.0]
        scaleAnimation.duration = duration
        
        // Opacity animation
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        
        opacityAnimation.keyTimes = [0, 0.7, 1]
        opacityAnimation.timingFunctions = [timingFunction, timingFunction]
        opacityAnimation.values = [1, 0.7, 0]
        opacityAnimation.duration = duration
        
        // Animation
        let animation = CAAnimationGroup()
        
        animation.animations = [scaleAnimation, opacityAnimation]
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.removedOnCompletion = false
        
        // Draw circles
        for var i = 0; i < 3; i++ {
            let circle = NVActivityIndicatorShape.Ring.createLayerWith(size: size, color: color)
            let frame = CGRect(x: (layer.bounds.size.width - size.width) / 2,
                y: (layer.bounds.size.height - size.height) / 2,
                width: size.width,
                height: size.height)
            
            animation.beginTime = beginTime + beginTimes[i]
            circle.frame = frame
            circle.addAnimation(animation, forKey: "animation")
            layer.addSublayer(circle)
        }
    }
}
