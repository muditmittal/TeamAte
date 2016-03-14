//
//  TrayVCDelegate.swift
//  CraveApp
//
//  Created by Jenn Leung on 3/13/16.
//  Copyright © 2016 Jenn Leung. All rights reserved.
//

protocol TrayVCDelegate: class {
    func foodPicker(vc: TrayVC, foodType: String)
}
