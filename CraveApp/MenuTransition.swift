//
//  MenuTransition.swift
//
//  Created by Mudit Mittal on 03/20/2016.
//

import UIKit

class MenuTransition: BaseTransition {
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        let menuVC = toViewController as! MenuViewController
        
        toViewController.view.alpha = 0
        
        for index in 0...8 {
            UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.5, options: [.CurveEaseInOut, .AllowUserInteraction], animations: {
                    
                //move buttons to homeposition
                menuVC.buttons[index].alpha = 1
                menuVC.buttons[index].center = menuVC.buttonpositions[index]
                menuVC.buttons[index].transform = CGAffineTransformMakeScale(1, 1)
                
                //move labels to homeposition
                menuVC.labels[index].center = menuVC.labelpositions[index]
                menuVC.labels[index].alpha = 1
            }, completion: nil)
        }

        //hide logo and cancel button
        UIView.animateWithDuration(duration*2/3, delay: 0.0, usingSpringWithDamping: 0.8,
        initialSpringVelocity: 0.5, options: [.CurveEaseInOut, .AllowUserInteraction], animations: {
            menuVC.craveLogo.alpha = 1
            menuVC.menuBackground.alpha = 1
            menuVC.cancelButton.transform = CGAffineTransformMakeScale(1, 1)
            menuVC.cancelButton.alpha = 1
        }, completion: nil)
        
        
        UIView.animateWithDuration(duration/2, animations: {
            toViewController.view.alpha = 1
        }) { (finished: Bool) -> Void in
            self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {

        let menuVC = fromViewController as! MenuViewController
        
        fromViewController.view.alpha = 1
        
        for index in 0...8 {
            UIView.animateWithDuration(duration*2, delay: 0.0, usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.5, options: [.CurveEaseInOut, .AllowUserInteraction], animations: {
                    
                //move all buttons to homeposition
                menuVC.buttons[index].center = menuVC.homeposition
                menuVC.buttons[index].transform = CGAffineTransformMakeScale(0.75, 0.75)
                
                //hide all buttons except the one that is pressed
                if index == 0 {
                    menuVC.buttons[index].alpha = 1
                    menuVC.buttons[index].selected = true
                    searchQuery = searchQueries[index]
                } else {
                    menuVC.buttons[index].alpha = 0
                    menuVC.buttons[index].selected = false
                }
                
                //move labels to homeposition
                menuVC.labels[index].center = menuVC.homeposition
                menuVC.labels[index].alpha = 0
            }, completion: nil)
        }

        //hide logo and cancel button
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.5, options: [.CurveEaseInOut, .AllowUserInteraction], animations: {
            menuVC.craveLogo.alpha = 0
            menuVC.menuBackground.alpha = 0
            menuVC.cancelButton.transform = CGAffineTransformMakeScale(0.001, 0.001)
            menuVC.cancelButton.alpha = 0
        }, completion: nil)
        
        
        
        
        UIView.animateWithDuration(duration/2, animations: {
            fromViewController.view.alpha = 0
        }) { (finished: Bool) -> Void in
            self.finish()
        }
    }
}
