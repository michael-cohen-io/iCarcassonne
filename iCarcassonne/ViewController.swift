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
        
        for (dir, nodeDict) in (tile1?.edgeNodes)! {
            print("\(dir): N1=\(nodeDict["N1"]), N2=\(nodeDict["N2"]), N3=\(nodeDict["N3"])")
        }
        
        print("\nTILE2")
        let tile2 = builder.loadFromPlist(TileWithId: 2)
        
        for (dir, nodeDict) in (tile2?.edgeNodes)! {
            print("\(dir): N1=\(nodeDict["N1"]), N2=\(nodeDict["N2"]), N3=\(nodeDict["N3"])")
        }
        
        print("\nTILE3")
        let tile3 = builder.loadFromPlist(TileWithId: 3)
        
        for (dir, nodeDict) in (tile3?.edgeNodes)! {
            print("\(dir): N1=\(nodeDict["N1"]), N2=\(nodeDict["N2"]), N3=\(nodeDict["N3"])")
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

