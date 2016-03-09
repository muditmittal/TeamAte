//
//  TrayViewController.swift
//  CraveApp
//
//  Created by Jenn Leung on 3/2/16.
//  Copyright © 2016 Jenn Leung. All rights reserved.
//

import UIKit


class TrayViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var trayCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trayCollectionView.delegate = self
        trayCollectionView.dataSource = self
        
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Set the number of items in your collection view.
        return 8
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // Access
        let cell = trayCollectionView.dequeueReusableCellWithReuseIdentifier("CustomCell", forIndexPath: indexPath) as! CustomCell
        // Do any custom modifications you your cell, referencing the outlets you defined in the Custom cell file.
        //cell.backgroundColor = UIColor.whiteColor()
        //cell.label.text = "item \(indexPath.item)"
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
