//
//  MenuViewController.swift
//  CraveApp
//
//  Created by Mudit Mittal on 3/19/16.
//  Copyright © 2016 Jenn Leung. All rights reserved.
//

import UIKit
var searchQueries: [String] = ["tea", "coffee", "beer", "taco", "dessert", "sushi", "pizza", "ramen", "burger"]
var searchQuery: String!

class MenuViewController: UIViewController {

//    weak var delegate: MenuVCDelegate?
    
    var duration = 0.4

    var homeposition: CGPoint!
    var buttonpositions: [CGPoint]!
    var labelpositions: [CGPoint]!
    
    var buttons: [UIButton]!
    var labels: [UILabel]!
    
    
    @IBOutlet var menuView: UIView!
    @IBOutlet weak var craveLogo: UIImageView!
    @IBOutlet weak var menuBackground: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!

    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    @IBOutlet weak var Button4: UIButton!
    @IBOutlet weak var Button5: UIButton!
    @IBOutlet weak var Button6: UIButton!
    @IBOutlet weak var Button7: UIButton!
    @IBOutlet weak var Button8: UIButton!
    @IBOutlet weak var Button9: UIButton!

    @IBOutlet weak var Label1: UILabel!
    @IBOutlet weak var Label2: UILabel!
    @IBOutlet weak var Label3: UILabel!
    @IBOutlet weak var Label4: UILabel!
    @IBOutlet weak var Label5: UILabel!
    @IBOutlet weak var Label6: UILabel!
    @IBOutlet weak var Label7: UILabel!
    @IBOutlet weak var Label8: UILabel!
    @IBOutlet weak var Label9: UILabel!

    var selectedMenuItem: UIImageView!
    var menuTransition: MenuTransition!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttons = [Button1, Button2, Button3, Button4, Button5, Button6, Button7, Button8, Button9]
        labels = [Label1, Label2, Label3, Label4, Label5, Label6, Label7, Label8, Label9]
        
        homeposition = cancelButton.center
        buttonpositions = [Button1.center, Button2.center, Button3.center, Button4.center, Button5.center, Button6.center, Button7.center, Button8.center, Button9.center]
        labelpositions = [Label1.center, Label2.center, Label3.center, Label4.center, Label5.center, Label6.center, Label7.center, Label8.center, Label9.center]
        
    }

    
    override func viewWillAppear(animated: Bool) {
        
        let blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark))
        blurredView.frame = menuBackground.bounds
        menuBackground.addSubview(blurredView)

        craveLogo.alpha = 0
        menuBackground.alpha = 0
        cancelButton.center = homeposition
        cancelButton.transform = CGAffineTransformMakeScale(0, 0)
        for index in 0...8 {
            buttons[index].center = homeposition
            labels[index].center = homeposition
            labels[index].alpha = 0
        }

    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.5, options: [.CurveEaseInOut, .AllowUserInteraction], animations: {
            self.craveLogo.alpha = 1
            self.menuBackground.alpha = 1
        }, completion: nil)
        for index in 0...8 {
            UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0.5, options: [.CurveEaseInOut, .AllowUserInteraction], animations: {
                self.buttons[index].center = self.buttonpositions[index]
                self.buttons[index].transform = CGAffineTransformMakeScale(1, 1)
                self.labels[index].center = self.labelpositions[index]
                self.labels[index].alpha = 1
            }, completion: nil)
        }
    }
    

    @IBAction func onMenuButtonTap(sender: AnyObject) {

        //open menu
        if sender.center == self.homeposition {
            for index in 0...8 {
                UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.8,
                    initialSpringVelocity: 0.5, options: [.CurveEaseInOut, .AllowUserInteraction], animations: {
                    
                    //move buttons to homeposition
                    self.buttons[index].alpha = 1
                    self.buttons[index].center = self.buttonpositions[index]
                    self.buttons[index].transform = CGAffineTransformMakeScale(1, 1)
                    
                    //move labels to homeposition
                    self.labels[index].center = self.labelpositions[index]
                    self.labels[index].alpha = 1
                }, completion: nil)
            }
            //hide logo and cancel button
            UIView.animateWithDuration(duration*2/3, delay: 0.0, usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0.5, options: [.CurveEaseInOut, .AllowUserInteraction], animations: {
                self.craveLogo.alpha = 1
                self.menuBackground.alpha = 1
                self.cancelButton.transform = CGAffineTransformMakeScale(1, 1)
                self.cancelButton.alpha = 1
            }, completion: nil)
        }
        //close menu
        else if sender.center != self.homeposition {
            for index in 0...8 {
                UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.8,
                    initialSpringVelocity: 0.5, options: [.CurveEaseInOut, .AllowUserInteraction], animations: {
                    
                    //move all buttons to homeposition
                    self.buttons[index].center = self.homeposition
                    self.buttons[index].transform = CGAffineTransformMakeScale(0.75, 0.75)
                    
                    //hide all buttons except the one that is pressed
                    if index == sender.tag {
                        self.buttons[index].alpha = 1
                        
                        self.buttons[index].selected = true
                        searchQuery = searchQueries[index]
//                        self.delegate?.searchFor(self, searchQuery: searchQueries[index])
                    } else {
                        self.buttons[index].alpha = 1
                        self.buttons[index].selected = false
                    }
                    
                    //move labels to homeposition
                    self.labels[index].center = self.homeposition
                    self.labels[index].alpha = 0
                }, completion: nil)
            }
            //hide logo and cancel button
            UIView.animateWithDuration(duration*2/3, delay: 0.0, usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0.5, options: [.CurveEaseInOut, .AllowUserInteraction], animations: {
                self.craveLogo.alpha = 0
                self.menuBackground.alpha = 0
                self.cancelButton.transform = CGAffineTransformMakeScale(0.001, 0.001)
                self.cancelButton.alpha = 0
            }, completion: nil)
            
            performSegueWithIdentifier("menuSegue", sender: nil)
        }
        
    }
    
    
    @IBAction func onCancelButtonTap(sender: AnyObject) {

        for index in 0...8 {
            UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0.5, options: [.CurveEaseInOut, .AllowUserInteraction], animations: {
                
                //move all buttons to homeposition
                self.buttons[index].center = self.homeposition
                self.buttons[index].transform = CGAffineTransformMakeScale(0.75, 0.75)
                
                //hide all buttons except the one that is pressed
                if self.buttons[index].selected {
                    self.buttons[index].alpha = 1
                } else {
                    self.buttons[index].alpha = 0
                }
                
                //move labels to homeposition
                self.labels[index].center = self.homeposition
                self.labels[index].alpha = 0
            }, completion: nil)
        }
        //hide logo and cancel button
        UIView.animateWithDuration(duration*2/3, delay: 0.0, usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.5, options: [.CurveEaseInOut, .AllowUserInteraction], animations: {
            self.craveLogo.alpha = 0
            self.menuBackground.alpha = 0
            self.cancelButton.transform = CGAffineTransformMakeScale(0.001, 0.001)
            self.cancelButton.alpha = 0
        }, completion: nil)
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var containerViewController = segue.destinationViewController as! ContainerViewController
        containerViewController.view.layoutIfNeeded()
        containerViewController.initiateSearch(searchQuery)
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
