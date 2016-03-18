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
    
    @IBOutlet weak var firstRow: UIView!
    @IBOutlet weak var secondRow: UIView!
    
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
        deselectAllButtons()
        switch button {

            case foodItem1Button:
                foodItem1Button.selected = true
                delegate?.foodPicker(self, searchQuery: searchQueries[0])
                handleButtonClicked(searchQueries[0])

            case foodItem2Button:
                foodItem2Button.selected = true
                delegate?.foodPicker(self, searchQuery: searchQueries[1])
                handleButtonClicked(searchQueries[1])

            case foodItem3Button:
                foodItem3Button.selected = true
                delegate?.foodPicker(self, searchQuery: searchQueries[2])
                handleButtonClicked(searchQueries[2])

            case foodItem4Button:
                foodItem4Button.selected = true
                delegate?.foodPicker(self, searchQuery: searchQueries[3])
                handleButtonClicked(searchQueries[3])

            case foodItem5Button:
                foodItem5Button.selected = true
                delegate?.foodPicker(self, searchQuery: searchQueries[4])
                handleButtonClicked(searchQueries[4])
            
            case foodItem6Button:
                foodItem6Button.selected = true
                delegate?.foodPicker(self, searchQuery: searchQueries[5])
                handleButtonClicked(searchQueries[5])

            case foodItem7Button:
                foodItem7Button.selected = true
                delegate?.foodPicker(self, searchQuery: searchQueries[6])
                handleButtonClicked(searchQueries[6])
            
            case foodItem8Button:
                foodItem8Button.selected = true
                delegate?.foodPicker(self, searchQuery: searchQueries[7])
                handleButtonClicked(searchQueries[7])
            
            default:
                delegate?.foodPicker(self, searchQuery: "Local")
                handleButtonClicked("Local")
            
        }
        
    }
    
    func deselectAllButtons() {
        foodItem1Button.selected = false
        foodItem2Button.selected = false
        foodItem3Button.selected = false
        foodItem4Button.selected = false
        foodItem5Button.selected = false
        foodItem6Button.selected = false
        foodItem7Button.selected = false
        foodItem8Button.selected = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
