//
//  ViewController.swift
//  iCarcassonne
//
//  Created by Michael Cohen on 2/3/17.
//  Copyright © 2017 Michael Cohen. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView: SKView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.showsDrawCount = true
        
        
        let builder = TileBuilder(plist: "Tile_Try1")
        let aTile = builder.loadFromPlist(TileWithId: 1)
        
        aTile?.printNodes() 
        print(aTile)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let mainScene = GameplayScene(size: CGSize(width: 768, height: 1024))
        let skView = self.view as! SKView
        
        skView.presentScene(mainScene)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

