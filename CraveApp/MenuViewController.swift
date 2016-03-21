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
var searchQueryIndex: Int!

class MenuViewController: UIViewController {
    
    var duration = 0.4
    
    var homeposition: CGPoint!
    var buttonpositions: [CGPoint]!
    var labelpositions: [CGPoint]!
    
    var buttons: [UIButton]!
    var labels: [UILabel]!
    
    var containerViewController: ContainerViewController!
    
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
    
    var selectedButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttons = [Button1, Button2, Button3, Button4, Button5, Button6, Button7, Button8, Button9]
        labels = [Label1, Label2, Label3, Label4, Label5, Label6, Label7, Label8, Label9]
        
        homeposition = cancelButton.center
        buttonpositions = [Button1.center, Button2.center, Button3.center, Button4.center, Button5.center, Button6.center, Button7.center, Button8.center, Button9.center]
        labelpositions = [Label1.center, Label2.center, Label3.center, Label4.center, Label5.center, Label6.center, Label7.center, Label8.center, Label9.center]
        
        if searchQuery != nil {
            searchQueryIndex = searchQueries.indexOf(searchQuery)!
            
            let button = buttons[searchQueryIndex]
            button.superview!.bringSubviewToFront(button)
        }
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
        
        searchQuery = searchQueries[sender.tag]
        containerViewController.initiateSearch(searchQuery)
        
        let currentButton = sender as! UIButton
        containerViewController.menuButton.setImage(currentButton.imageForState(UIControlState.Normal), forState: UIControlState.Normal)
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    @IBAction func onCancelButtonTap(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}