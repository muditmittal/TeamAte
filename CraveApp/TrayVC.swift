//
//  TrayVC.swift
//  CraveApp
//
//  Created by Jenn Leung on 3/10/16.
//  Copyright © 2016 Jenn Leung. All rights reserved.
//

import UIKit

//protocol here?

class TrayVC: UIViewController {
    
    weak var delegate: TrayVCDelegate?
    
    @IBOutlet var foodItem1Button: UIButton!
    @IBOutlet var foodItem2Button: UIButton!
    @IBOutlet var foodItem3Button: UIButton!
    @IBOutlet var foodItem4Button: UIButton!
    @IBOutlet var foodItem5Button: UIButton!
    @IBOutlet var foodItem6Button: UIButton!
    @IBOutlet var foodItem7Button: UIButton!
    @IBOutlet var foodItem8Button: UIButton!
    
    @IBOutlet var trayView: UIView!
    var trayOriginalCenter: CGPoint!
    var trayDown: CGPoint!
    var trayUp: CGPoint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
        
        trayView.userInteractionEnabled = true
        
        trayView.addGestureRecognizer(panGestureRecognizer)
        trayOriginalCenter = CGPoint(x: trayView.center.x, y: trayView.center.y)
        
        //setting tray up and down positions
        trayDown = CGPoint(x: 160, y: 77)
        trayUp = CGPoint(x: 160, y: 137)
    }
    
    func setupHandlers() {
        print("Hamburger")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func foodClicked(button: UIButton) {
        print("infoodclicked")
        switch button {
        case foodItem1Button:
            print("hamburger")
            handleButtonClicked("Hamburger")
            delegate?.foodPicker(self, foodType: "Hamburger")
        case foodItem2Button:
            print("pizza")
            handleButtonClicked("Pizza")
        case foodItem3Button:
            print("sushi")
            handleButtonClicked("Sushi")
        case foodItem4Button:
            print("cupcake")
            handleButtonClicked("Cupcake")
        case foodItem5Button:
            print("boba")
            handleButtonClicked("Boba")
        case foodItem6Button:
            print("spaghetti")
            handleButtonClicked("Spaghetti")
        case foodItem7Button:
            handleButtonClicked("Popcorn")
        case foodItem8Button:
            handleButtonClicked("Ice Cream")
        default:
            handleButtonClicked("Other")
            
        }
        
    }
    
    
    func handleButtonClicked (food: String) {
        print (food)
        //api_call(food).done(populate_result_view(results))
        //load_result_view(food) // in loading state
        // load result view, pass the response into result view
        //someone clicks on button, send api request of respective button
        //
        
    }
    
    
    func onCustomPan(sender: UIPanGestureRecognizer) {
        let point = sender.locationInView(view)
        //let velocity = sender.velocityInView(view)
        //let translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            
            //print("Gesture began at: \(point)")
            
            trayOriginalCenter = trayView.center
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y)
        } else if sender.state == UIGestureRecognizerState.Changed {
            //print("Gesture changed at: \(point)")
        } else if sender.state == UIGestureRecognizerState.Ended {
            //print("Gesture ended at: \(point)")
            
            if point.y > 0 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    //if panning up, then set tray to up position
                    self.trayView.center = self.trayUp
                })
            }
            if point.y < 0 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    //if panning down, then set tray to down position
                    self.trayView.center = self.trayDown
                    
                })
            }
            
        }
    }
    
    
    
}
