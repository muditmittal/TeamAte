//
//  TrayVC.swift
//  CraveApp
//
//  Created by Jenn Leung on 3/10/16.
//  Copyright © 2016 Jenn Leung. All rights reserved.
//

import UIKit

//protocol here?

var searchQueries: [String] = ["Ramen", "Burger", "Taco", "Desserts", "Sushi", "Pizza", "Drinks", "Local"]

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

    }

    func handleButtonClicked (food: String) {
        print (food)
        
        //api_call(food).done(populate_result_view(results))
        //load_result_view(food) // in loading state
        // load result view, pass the response into result view
        //someone clicks on button, send api request of respective button
        //
        
    }
    
    
    @IBAction func foodClicked(button: UIButton) {
        switch button {

            case foodItem1Button:
                handleButtonClicked(searchQueries[0])
                delegate?.foodPicker(self, searchQuery: searchQueries[0])

            case foodItem2Button:
                handleButtonClicked(searchQueries[1])
                delegate?.foodPicker(self, searchQuery: searchQueries[1])

            case foodItem3Button:
                handleButtonClicked(searchQueries[2])
                delegate?.foodPicker(self, searchQuery: searchQueries[2])

            case foodItem4Button:
                handleButtonClicked(searchQueries[3])
                delegate?.foodPicker(self, searchQuery: searchQueries[3])

            case foodItem5Button:
                handleButtonClicked(searchQueries[4])
                delegate?.foodPicker(self, searchQuery: searchQueries[4])
            
            case foodItem6Button:
                handleButtonClicked(searchQueries[5])
                delegate?.foodPicker(self, searchQuery: searchQueries[5])

            case foodItem7Button:
                handleButtonClicked(searchQueries[6])
                delegate?.foodPicker(self, searchQuery: searchQueries[6])
            
            case foodItem8Button:
                handleButtonClicked(searchQueries[7])
                delegate?.foodPicker(self, searchQuery: searchQueries[7])
            
            default:
                handleButtonClicked("Local")
                delegate?.foodPicker(self, searchQuery: "Local")
                
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
