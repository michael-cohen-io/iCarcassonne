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
        print("\nTILE1")
        let tile1 = builder.loadFromPlist(TileWithId: 1)
        tile1?.printCoordinateEdges()
        
        tile1?.rotateTile()
        
        tile1?.printCoordinateEdges()
        
        print("\nTILE2")
        let tile2 = builder.loadFromPlist(TileWithId: 2)
        tile2?.printCoordinateEdges()
        
        tile2?.rotateTile()
        tile2?.printCoordinateEdges()
        
        print("\nTILE3")
        let tile3 = builder.loadFromPlist(TileWithId: 3)
        tile3?.printCoordinateEdges()
        
        tile3?.rotateTile()
        
        tile3?.printCoordinateEdges()
//
        
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

