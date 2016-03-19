//
//  TrayVC.swift
//  CraveApp
//
//  Created by Jenn Leung on 3/10/16.
//  Copyright © 2016 Jenn Leung. All rights reserved.
//

import UIKit
import MapKit

//protocol here?

var searchQueries: [String] = ["Ramen", "Burger", "Taco", "Desserts", "Sushi", "Pizza", "Drinks", "Local"]

class TrayVC: UIViewController, CLLocationManagerDelegate {
    
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
    
    // location variables
    // location variables
    var locationManager: CLLocationManager!
    let distanceSpan:Double = 500
    var locations: [CLLocation]!
    var lat: Double!
    var long: Double!
    
    // query string
    var query: String!
    
    // data array
    var data: [NSDictionary]!
    
    
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
        
        fetchVenues(food)
        
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
    
    func fetchVenues(query: String) {
        
        print("query:", query)
        
        // venue information
        let venueUrl = NSURL(string:"https://api.foursquare.com/v2/venues/search?ll=\(lat),\(long)&query=\(query)&client_id=XX13QSMNHNNKUAIXH2U5KUNNQ3AT1JY2AX5OCT4Q34ZXXUZM&client_secret=2UFHBTTZNFTGLE5DRBJ0MUXRWKLSPSI3TX3X4AVQKL4KPSF5&v=20160313")
        
        
        let venueRequest = NSURLRequest(URL: venueUrl!)
        
        //            print (venueUrl)
        
        NSURLConnection.sendAsynchronousRequest(venueRequest, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            
            let venueJson = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            
            //                print(venueJson)
            
            
            // store the venueIds, venueLocations, and venueNames from the search API request
            
            self.data = venueJson.valueForKeyPath("response.venues") as! [NSDictionary]
            let venueIds = venueJson.valueForKeyPath("response.venues.id") as! [String]
            let venueNames = venueJson.valueForKeyPath("response.venues.name") as! [String]
            let venueLocations = venueJson.valueForKeyPath("response.venues.location") as! [NSDictionary]
            
            // store venueIds
            let venueId0 = venueIds[0]
            let venueId1 = venueIds[1]
            let venueId2 = venueIds[2]
            let venueId3 = venueIds[3]
            let venueId4 = venueIds[4]
            let venueId5 = venueIds[5]
            
            // store venueNames
            let venueName0 = venueNames[0]
            let venueName1 = venueNames[1]
            let venueName2 = venueNames[2]
            let venueName3 = venueNames[3]
            let venueName4 = venueNames[4]
            let venueName5 = venueNames[5]
            
            // fetch 6 menus, if count > 0, then store data
            // parse through menu items in menu; for menuItem in [menuItems] by string match
            
            // get menu information
            
            // menu information 0
            let menuUrl0 = NSURL(string:"https://api.foursquare.com/v2/venues/\(venueId0)/menu?client_id=XX13QSMNHNNKUAIXH2U5KUNNQ3AT1JY2AX5OCT4Q34ZXXUZM&client_secret=2UFHBTTZNFTGLE5DRBJ0MUXRWKLSPSI3TX3X4AVQKL4KPSF5&v=20160313")
            let menuRequest0 = NSURLRequest(URL: menuUrl0!)
            
            //                print (menuUrl0)
            
            NSURLConnection.sendAsynchronousRequest(menuRequest0, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                
                let menuJson0 = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                
                //                    print (menuJson0)
                
                // check if there is a menu object in JSON response
                
                let menuCount0 = menuJson0.valueForKeyPath("response.menu.menus.count") as! Int
                
                if menuCount0 > 0 {
                    
                    // if there is a menu, store the items in an array
                    
                    let menuItems = menuJson0.valueForKeyPath("response.menu.menus.items.entries.items.entries.items") as! NSArray
                    
                    // the outer array is [0] for some reason
                    
                    for var j = 0; j < menuItems[0].count; ++j {
                        
                        for var i = 0; i < menuItems[0][j].count; ++i {
                            
                            let itemDictionary = menuItems[0][j][i] as! NSDictionary
                            let itemName = itemDictionary.valueForKeyPath("name") as! String
                            var itemDescription = ""
                            
                            var itemString = ""
                            
                            // concatenate item name and item description stirng
                            if itemDictionary.valueForKeyPath("description") != nil {
                                itemDescription = itemDictionary.valueForKeyPath("description") as! String
                                itemString = itemName + itemDescription
                            }
                                
                            else {
                                itemString = itemName
                            }
                            
                            //                                print (itemName)
                            
                            // string match itemString for the query string
                            if itemString.lowercaseString.rangeOfString(self.query) != nil {
                                print ("menu0 query item: ", itemName, itemDescription)
                            }
                        }
                    }
                }
            }
            
            // menu information 1
            let menuUrl1 = NSURL(string:"https://api.foursquare.com/v2/venues/\(venueId1)/menu?client_id=XX13QSMNHNNKUAIXH2U5KUNNQ3AT1JY2AX5OCT4Q34ZXXUZM&client_secret=2UFHBTTZNFTGLE5DRBJ0MUXRWKLSPSI3TX3X4AVQKL4KPSF5&v=20160313")
            let menuRequest1 = NSURLRequest(URL: menuUrl1!)
            
            //                print (menuUrl1)
            
            NSURLConnection.sendAsynchronousRequest(menuRequest1, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                
                let menuJson1 = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                
                //                    print (menuJson1)
                
                // check if there is a menu object in JSON response
                
                let menuCount1 = menuJson1.valueForKeyPath("response.menu.menus.count") as! Int
                
                if menuCount1 > 0 {
                    
                    // if there is a menu, store the items in an array
                    
                    let menuItems = menuJson1.valueForKeyPath("response.menu.menus.items.entries.items.entries.items") as! NSArray
                    
                    // the outer array is [0] for some reason
                    
                    for var j = 0; j < menuItems[0].count; ++j {
                        
                        for var i = 0; i < menuItems[0][j].count; ++i {
                            
                            let itemDictionary = menuItems[0][j][i] as! NSDictionary
                            let itemName = itemDictionary.valueForKeyPath("name") as! String
                            var itemDescription = ""
                            
                            var itemString = ""
                            
                            // concatenate item name and item description stirng
                            if itemDictionary.valueForKeyPath("description") != nil {
                                itemDescription = itemDictionary.valueForKeyPath("description") as! String
                                itemString = itemName + itemDescription
                            }
                                
                            else {
                                itemString = itemName
                            }
                            
                            //                                print (itemName)
                            
                            // string match itemString for the query string
                            if itemString.lowercaseString.rangeOfString(self.query) != nil {
                                print ("menu1 query item: ", itemName, itemDescription)
                            }
                        }
                    }
                }
            }
            
            // menu information 2
            let menuUrl2 = NSURL(string:"https://api.foursquare.com/v2/venues/\(venueId2)/menu?client_id=XX13QSMNHNNKUAIXH2U5KUNNQ3AT1JY2AX5OCT4Q34ZXXUZM&client_secret=2UFHBTTZNFTGLE5DRBJ0MUXRWKLSPSI3TX3X4AVQKL4KPSF5&v=20160313")
            let menuRequest2 = NSURLRequest(URL: menuUrl2!)
            
            //                print (menuUrl2)
            
            NSURLConnection.sendAsynchronousRequest(menuRequest2, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                
                let menuJson2 = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                
                //                    print (menuJson2)
                
                // check if there is a menu object in JSON response
                
                let menuCount2 = menuJson2.valueForKeyPath("response.menu.menus.count") as! Int
                if menuCount2 > 0 {
                    
                    // if there is a menu, store the items in an array
                    
                    let menuItems = menuJson2.valueForKeyPath("response.menu.menus.items.entries.items.entries.items") as! NSArray
                    
                    // the outer array is [0] for some reason
                    
                    for var j = 0; j < menuItems[0].count; ++j {
                        
                        for var i = 0; i < menuItems[0][j].count; ++i {
                            
                            let itemDictionary = menuItems[0][j][i] as! NSDictionary
                            let itemName = itemDictionary.valueForKeyPath("name") as! String
                            var itemDescription = ""
                            
                            var itemString = ""
                            
                            // concatenate item name and item description stirng
                            if itemDictionary.valueForKeyPath("description") != nil {
                                itemDescription = itemDictionary.valueForKeyPath("description") as! String
                                itemString = itemName + itemDescription
                            }
                                
                            else {
                                itemString = itemName
                            }
                            
                            //                                print (itemName)
                            
                            // string match itemString for the query string
                            if itemString.lowercaseString.rangeOfString(self.query) != nil {
                                print ("menu2 query item: ", itemName, itemDescription)
                            }
                        }
                    }
                }
            }
            
            // menu information 3
            let menuUrl3 = NSURL(string:"https://api.foursquare.com/v2/venues/\(venueId3)/menu?client_id=XX13QSMNHNNKUAIXH2U5KUNNQ3AT1JY2AX5OCT4Q34ZXXUZM&client_secret=2UFHBTTZNFTGLE5DRBJ0MUXRWKLSPSI3TX3X4AVQKL4KPSF5&v=20160313")
            let menuRequest3 = NSURLRequest(URL: menuUrl3!)
            
            //                print (menuUrl3)
            
            NSURLConnection.sendAsynchronousRequest(menuRequest3, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                
                let menuJson3 = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                
                //                    print (menuJson3)
                
                // check if there is a menu object in JSON response
                
                let menuCount3 = menuJson3.valueForKeyPath("response.menu.menus.count") as! Int
                if menuCount3 > 0 {
                    
                    // if there is a menu, store the items in an array
                    
                    let menuItems = menuJson3.valueForKeyPath("response.menu.menus.items.entries.items.entries.items") as! NSArray
                    
                    // the outer array is [0] for some reason
                    
                    // print menu items outer array and inner array counts
                    //                        print("menu3 items[0] count:", menuItems[0].count)
                    //                        print("menu3 items[0]", menuItems[0])
                    //                        print("menu3 items[0][0] count:", menuItems[0][0].count)
                    //                        print("menu3 items[0][0]", menuItems[0][0])
                    
                    for var j = 0; j < menuItems[0].count; ++j {
                        
                        for var i = 0; i < menuItems[0][j].count; ++i {
                            
                            let itemDictionary = menuItems[0][j][i] as! NSDictionary
                            let itemName = itemDictionary.valueForKeyPath("name") as! String
                            var itemDescription = ""
                            
                            var itemString = ""
                            
                            // concatenate item name and item description stirng
                            if itemDictionary.valueForKeyPath("description") != nil {
                                itemDescription = itemDictionary.valueForKeyPath("description") as! String
                                itemString = itemName + itemDescription
                            }
                                
                            else {
                                itemString = itemName
                            }
                            
                            //                                print (itemName)
                            
                            // string match itemString for the query string
                            if itemString.lowercaseString.rangeOfString(self.query) != nil {
                                print ("menu3 query item: ", itemName, itemDescription)
                            }
                        }
                    }
                }
            }
            
            // menu information 4
            let menuUrl4 = NSURL(string:"https://api.foursquare.com/v2/venues/\(venueId4)/menu?client_id=XX13QSMNHNNKUAIXH2U5KUNNQ3AT1JY2AX5OCT4Q34ZXXUZM&client_secret=2UFHBTTZNFTGLE5DRBJ0MUXRWKLSPSI3TX3X4AVQKL4KPSF5&v=20160313")
            let menuRequest4 = NSURLRequest(URL: menuUrl4!)
            
            //                print (menuUrl4)
            
            NSURLConnection.sendAsynchronousRequest(menuRequest4, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                
                let menuJson4 = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                
                //                    print (menuJson4)
                
                // check if there is a menu object in JSON response
                
                let menuCount4 = menuJson4.valueForKeyPath("response.menu.menus.count") as! Int
                
                if menuCount4 > 0 {
                    
                    // if there is, store the menu in an array
                    
                    let menuItems = menuJson4.valueForKeyPath("response.menu.menus.items.entries.items.entries.items") as! NSArray
                    
                    // the outer array is [0] for some reason
                    
                    for var j = 0; j < menuItems[0].count; ++j {
                        
                        for var i = 0; i < menuItems[0][j].count; ++i {
                            
                            let itemDictionary = menuItems[0][j][i] as! NSDictionary
                            let itemName = itemDictionary.valueForKeyPath("name") as! String
                            var itemDescription = ""
                            
                            var itemString = ""
                            
                            // concatenate item name and item description stirng
                            if itemDictionary.valueForKeyPath("description") != nil {
                                itemDescription = itemDictionary.valueForKeyPath("description") as! String
                                itemString = itemName + itemDescription
                            }
                                
                            else {
                                itemString = itemName
                            }
                            
                            //                                print (itemName)
                            
                            // string match itemString for the query string
                            if itemString.lowercaseString.rangeOfString(self.query) != nil {
                                print ("menu4 query item: ", itemName, itemDescription)
                            }
                        }
                    }
                }
            }
            
            // menu information 5
            let menuUrl5 = NSURL(string:"https://api.foursquare.com/v2/venues/\(venueId5)/menu?client_id=XX13QSMNHNNKUAIXH2U5KUNNQ3AT1JY2AX5OCT4Q34ZXXUZM&client_secret=2UFHBTTZNFTGLE5DRBJ0MUXRWKLSPSI3TX3X4AVQKL4KPSF5&v=20160313")
            let menuRequest5 = NSURLRequest(URL: menuUrl5!)
            
            //                print (menuUrl5)
            
            NSURLConnection.sendAsynchronousRequest(menuRequest5, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                
                // check if there is a menu object in JSON response
                
                let menuJson5 = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                
                //                    print (menuJson5)
                
                let menuCount5 = menuJson5.valueForKeyPath("response.menu.menus.count") as! Int
                
                if menuCount5 > 0 {
                    
                    // if there is, store the menu in an array
                    
                    let menuItems = menuJson5.valueForKeyPath("response.menu.menus.items.entries.items.entries.items") as! NSArray
                    
                    // print menu items outer array and inner array counts
                    //                        print("menu5 items[0] count:", menuItems[0].count)
                    //                        print("menu5 items[0]", menuItems[0])
                    //                        print("menu5 items[0][0] count:", menuItems[0][0].count)
                    //                        print("menu5 items[0][0]", menuItems[0][0])
                    
                    // the outer array is [0] for some reason
                    
                    for var j = 0; j < menuItems[0].count; ++j {
                        
                        for var i = 0; i < menuItems[0][j].count; ++i {
                            
                            let itemDictionary = menuItems[0][j][i] as! NSDictionary
                            let itemName = itemDictionary.valueForKeyPath("name") as! String
                            var itemDescription = ""
                            
                            var itemString = ""
                            
                            // concatenate item name and item description stirng
                            if itemDictionary.valueForKeyPath("description") != nil {
                                itemDescription = itemDictionary.valueForKeyPath("description") as! String
                                itemString = itemName + itemDescription
                            }
                                
                            else {
                                itemString = itemName
                            }
                            
                            //                                print (itemName)
                            
                            // string match itemString for the query string
                            if itemString.lowercaseString.rangeOfString(self.query) != nil {
                                print ("menu5 query item: ", itemName, itemDescription)
                            }
                        }
                    }
                }
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
