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
        let tile0 = builder.loadFromPlist(TileWithId: 0)
        let tile3 = builder.loadFromPlist(TileWithId: 3)
        
        let grid = TileGrid(width: 10, height: 10)
        if !grid.addTile(aTile: tile0!, x_pos: 0, y_pos: 0) {
            print("Tile0 not added")
        }
        if !grid.addTile(aTile: tile3!, x_pos: 1, y_pos: 0) {
            print("Tile3 not added")
        }
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

