//
//  HomeVCDelegate.swift
//  CraveApp
//
//  Created by Jenn Leung on 3/17/16.
//  Copyright © 2016 Jenn Leung. All rights reserved.
//

protocol HomeVCDelegate: class {
    func clickedCloseButton(vc: HomeViewController, clicked: Bool)
}