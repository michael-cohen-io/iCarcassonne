//
//  GameplayScene.swift
//  iCarcassonne
//
//  Created by Michael Cohen on 2/8/17.
//  Copyright © 2017 Michael Cohen. All rights reserved.
//

import UIKit
import SpriteKit

class GameplayScene: SKScene {
    
    var contentCreated = false
    
    override func didMove(to view: SKView) {
        if (!contentCreated) {
            createContent()
            contentCreated = true
        }
    }
    
    func createContent() {
        self.backgroundColor = SKColor.green
        self.scaleMode = .aspectFill
        
        let builder = TileBuilder(plist: "Tile_Try1")
        let tile0 = builder.loadFromPlist(TileWithId: 0)
        let tile0Sprite = SKNodeTextTile(withTile: tile0!, x_pos: (Int(self.frame.size.width) / 2), y_pos: (Int(self.frame.size.height) / 2))
        self.addChild(tile0Sprite)
        
//        let tile2 = builder.loadFromPlist(TileWithId: 2)
//        tile2?.rotateTile()
//        tile2?.rotateTile()
//        tile2?.rotateTile()
    }
    
    
    // refactor into another class (namely into a FM inside SKTileNode
    func createTileNode() -> SKLabelNode {
        let skLabel = SKLabelNode(fontNamed: "Arial")
        skLabel.text = "Tile1"
        skLabel.fontSize = 20
        
        return skLabel
    }
    
}
