//
//  ViewController.swift
//  iCarcassonne
//
//  Created by Michael Cohen on 2/3/17.
//  Copyright © 2017 Michael Cohen. All rights reserved.
//

import UIKit
import SpriteKit
import GoogleCast.GCKUICastButton

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView: SKView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.showsDrawCount = true
        skView.ignoresSiblingOrder = true
        

        let castButton = GCKUICastButton.init(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        castButton.tintColor = UIColor.white
        let item = UIBarButtonItem.init(customView: castButton)
        self.navigationItem.rightBarButtonItem = item
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let skView = self.view as! SKView
        let startScene = StartScene(size: skView.frame.size)
        
        skView.presentScene(startScene)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

