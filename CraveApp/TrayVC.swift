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
//        //let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
//        
//        trayView.userInteractionEnabled = true
//        
//        trayView.addGestureRecognizer(panGestureRecognizer)
//        trayOriginalCenter = CGPoint(x: trayView.center.x, y: trayView.center.y)
//        
//        //setting tray up and down positions
//        trayDown = CGPoint(x: 160.0, y: 364.0)
//        trayUp = CGPoint(x: 160, y: 284)
//        print(trayView.center)
//        print("trayup \(self.trayView.frame.height)")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func foodClicked(button: UIButton) {
        switch button {
        case foodItem1Button:
            //print("hamburger")
            handleButtonClicked("Hamburger")
            delegate?.foodPicker(self, foodType: "Hamburger")
        case foodItem2Button:
            //print("pizza")
            handleButtonClicked("Pizza")
            delegate?.foodPicker(self, foodType: "Pizza")
        case foodItem3Button:
            handleButtonClicked("Sushi")
            delegate?.foodPicker(self, foodType: "Sushi")

        case foodItem4Button:
            handleButtonClicked("Cupcake")
            delegate?.foodPicker(self, foodType: "Cupcake")
        case foodItem5Button:
            //print("boba")
            handleButtonClicked("Boba")
            delegate?.foodPicker(self, foodType: "Boba")
        case foodItem6Button:
            //print("spaghetti")
            handleButtonClicked("Spaghetti")
            delegate?.foodPicker(self, foodType: "Spaghetti")
        case foodItem7Button:
            handleButtonClicked("Popcorn")
            delegate?.foodPicker(self, foodType: "Popcorn")
        case foodItem8Button:
            handleButtonClicked("Ice Cream")
            delegate?.foodPicker(self, foodType: "Ice Cream")
        default:
            handleButtonClicked("Local")
            delegate?.foodPicker(self, foodType: "Local")
            
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
    
    
//    func onCustomPan(sender: UIPanGestureRecognizer) {
//        let point = sender.locationInView(view)
//        let velocity = sender.velocityInView(view)
//        //let translation = sender.translationInView(view)
//        
//        if sender.state == UIGestureRecognizerState.Began {
//            
//            //print("Gesture began at: \(point)")
//            
//            trayOriginalCenter = trayView.center
//            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y)
//        } else if sender.state == UIGestureRecognizerState.Changed {
//            print("Gesture changed at: \(point)")
//        } else if sender.state == UIGestureRecognizerState.Ended {
//            //print("Gesture ended at: \(point)")
//            
//            if velocity.y < 0 {
//                UIView.animateWithDuration(0.3, animations: { () -> Void in
//                    //if panning up, then set tray to up position
//                    self.trayView.center.y = self.trayUp.y
//                    //print(self.trayUp)
//                    print("trayup \(self.trayView.center)")
//                    print("trayup \(self.trayUp)")
//                    //print("trayup \(self.trayView.frame.height)")
//                })
//            }
//            if velocity.y > 0 && self.trayView.frame.height != 568 {
//                UIView.animateWithDuration(0.3, animations: { () -> Void in
//                    //if panning down, then set tray to down position
//                    self.trayView.center = self.trayDown
//                    print("traydown \(self.trayView.frame.height)")
//                })
//            }
//            
//        }
//    }
    
    
    
}
