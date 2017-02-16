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
        self.backgroundColor = SKColor.blue
        self.scaleMode = .aspectFill
        
        self.addChild(createTileNode())
    }
    
    
    // refactor into another class (namely into a FM inside SKTileNode
    func createTileNode() -> SKLabelNode {
        let skLabel = SKLabelNode(fontNamed: "Arial")
        skLabel.text = "Tile1"
        skLabel.fontSize = 20
        
        return skLabel
    }
    
}
