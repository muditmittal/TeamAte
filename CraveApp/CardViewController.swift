//
//  CardViewController.swift
//  CraveApp
//
//  Created by Jenn Leung on 3/10/16.
//  Copyright © 2016 Jenn Leung. All rights reserved.
//

import UIKit

class CardViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var trayView: UIView!
    var trayViewController: UIViewController!
    var trayViewOriginalCenter: CGPoint!
    
    @IBOutlet var trayView2: UIView!
    @IBOutlet var trayView3: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 960, height: 568)
        
        trayViewController = storyboard!.instantiateViewControllerWithIdentifier("TrayVC") as! TrayVC
        let trayFrame = CGRect(x: 0, y: 0, width: trayView.frame.size.width, height: 154)
        
        trayViewController.view.frame = trayFrame
        trayViewController.view.frame = trayView.bounds
        
        trayView.addSubview(trayViewController.view)
        trayView.center.y += 65
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // This method is called as the user scrolls
        //if we scroll to second page
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView,
        willDecelerate decelerate: Bool) {
            // This method is called right as the user lifts their finger
            let page : Int = Int(round(scrollView.contentOffset.x / 320))
            
            if page == 0 {
                print("im on card 1")
                trayView.removeFromSuperview()
                trayView.addSubview(trayViewController.view)
                //                trayViewOriginalCenter.y = trayView.center.y
                //                if trayView.center.y == trayViewOriginalCenter.y {
                //                    trayView.center.y += 65
                //                }
                
            }
            if page == 1 {
                print("im on card 2")
                trayView.removeFromSuperview()
                trayView2.addSubview(trayViewController.view)
                //                if trayView2.center.y == trayViewOriginalCenter.y {
                //                    trayView2.center.y += 65
                //                }
            }
            
            if page == 2 {
                print("im on card 3")
                trayView2.removeFromSuperview()
                trayView3.addSubview(trayViewController.view)
                //                if trayView3.center.y == trayViewOriginalCenter.y {
                //                    trayView3.center.y += 65
                //                }
                
            }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // This method is called when the scrollview finally stops scrolling.
        
    }
    
}
