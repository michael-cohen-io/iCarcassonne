//
//  SKNodeTileSprite.swift
//  iCarcassonne
//
//  Created by Michael Cohen on 3/20/17.
//  Copyright © 2017 Michael Cohen. All rights reserved.
//

import UIKit
import SpriteKit

//TODO: establish global tile size
let kTileSize = CGSize(width: 100, height: 100)

class SKNodeTileSprite: SKSpriteNode {

    init(withTile t: Tile) {
        let texture = SKTexture(imageNamed: "tile0")
        super.init(texture: texture, color: .white, size: kTileSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            fatalError("SKNodeTileSprite: touchesBegan called erroneously")
        }
        
        let positionInScene = touch.location(in: self.parent!)
        selectNodeForTouch(touchLocation: positionInScene)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            fatalError("SKNodeTileSprite: touchesMoved called erroneously")
        }
        
        let positionInScene = touch.location(in: self.parent!)
        let previousPosition = touch.previousLocation(in: self.parent!)
        
        let translation = CGPoint(x: positionInScene.x - previousPosition.x,
                                  y: positionInScene.y - previousPosition.y)
        self.panForTranslation(translation: translation)
    }
    
    private func selectNodeForTouch(touchLocation: CGPoint) {
        self.run(SKAction.rotate(toAngle: 0.0, duration: 0.1))
        let sequence = SKAction.sequence([
            SKAction.rotate(byAngle: degToRad(degree: -4.0), duration: 0.1),
            SKAction.rotate(byAngle: 0.0, duration: 0.1),
            SKAction.rotate(byAngle: degToRad(degree: 4.0), duration: 0.1)
            ])
        
        self.run(SKAction.repeatForever(sequence))
    }
    
    private func panForTranslation(translation: CGPoint) {
        let position = self.position
        
        self.position = CGPoint(x: position.x + translation.x,
                                y: position.y + translation.y)
    }
}
