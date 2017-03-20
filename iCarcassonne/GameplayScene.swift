//
//  GameplayScene.swift
//  iCarcassonne
//
//  Created by Michael Cohen on 2/8/17.
//  Copyright © 2017 Michael Cohen. All rights reserved.
//

import UIKit
import SpriteKit

private let kMovableNodeName = "movable"

class GameplayScene: SKScene {
    
    var contentCreated = false
    
    var selectedNode = SKSpriteNode()
    let background = SKSpriteNode(imageNamed: "horses")
    
    let grid = TileGrid(width: 10, height: 10)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.background.name = "background"
        self.background.anchorPoint = CGPoint.zero
        self.addChild(background)
        
        
    }
    
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
        if (self.grid.addTile(aTile: tile0!, x_pos: 0, y_pos: 0)) {
            //TODO: Refactor into addTile() method
            
            let tile0Sprite = SKSpriteNode(imageNamed: "tile0")
               //SKNodeTextTile(withTile: tile0!, x_pos: (Int(self.frame.size.width) / 2), y_pos: (Int(self.frame.size.height) / 2))
            tile0Sprite.size = CGSize(width: 100, height: 100)
            
            let offsetFraction = (CGFloat(0) + 1.0)/(CGFloat(2) + 1.0)
            tile0Sprite.position = CGPoint(x: size.width * offsetFraction, y: size.height / 2)
            
            tile0Sprite.name = kMovableNodeName
            
            self.addChild(tile0Sprite)
            
        }
        
        
        let tile2 = builder.loadFromPlist(TileWithId: 2)
        tile2?.rotateTile()
        tile2?.rotateTile()
        tile2?.rotateTile()
        if (self.grid.addTile(aTile: tile2!, x_pos: 1, y_pos: 0)) {
            //TODO: Refactor into addTile() method
            
            let tile2Sprite = SKSpriteNode(imageNamed: "tile0")
            tile2Sprite.size = CGSize(width: 100, height: 100)
               // SKNodeTextTile(withTile: tile2!, x_pos: Int(self.frame.size.width / 2) + 150, y_pos: Int(self.frame.size.height / 2))
            
            let offsetFraction = (CGFloat(1) + 1.0)/(CGFloat(2) + 1.0)
            tile2Sprite.position = CGPoint(x: size.width * offsetFraction, y: size.height / 2)
            
            tile2Sprite.name = kMovableNodeName
            
            self.addChild(tile2Sprite)
            
        }
        print("Width: \(self.frame.size.width)")
        print("Height: \(self.frame.size.height)")
        
    }
    
    func addTile(aTile t: Tile, x_pos x: Int, y_pos y: Int) {
        //TODO: Calculations on x and y positions
        
        let tileSprite = SKNodeTextTile(withTile: t, x_pos: x, y_pos: y)
        self.addChild(tileSprite)
    }

    /* 
        TOUCH FUNCTIONS
     */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            fatalError("touchesBegan called erroneously")
        }
        let positionInScene = touch.location(in: self)
        selectNodeForTouch(touchLocation: positionInScene)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            fatalError("touchesMoved called erroneously")
        }
        
        let positionInScene = touch.location(in: self)
        let previousPosition = touch.previousLocation(in: self)
        
        let translation = CGPoint(x: positionInScene.x - previousPosition.x,
                                  y: positionInScene.y - previousPosition.y)
        
        panForTranslation(translation: translation)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            fatalError("touchesEnded called erroneously")
        }
        
        let positionInScene = touch.location(in: self)
        
        let touchedNode = self.nodes(at: positionInScene)
        if touchedNode[0].isEqual(to: selectedNode) {
            selectedNode.removeAllActions()
            selectedNode.run(SKAction.rotate(toAngle: 0.0, duration: 0.1))
        }
    }

    
    private func selectNodeForTouch(touchLocation: CGPoint) {
        let touchedNode = self.nodes(at: touchLocation)
        
        if !(touchedNode[0] is SKSpriteNode) {
            print("GamePlayScene: Touched node is not an SKSpriteNode")
            return
        }

        if !selectedNode.isEqual(to: touchedNode[0]) {
            selectedNode.removeAllActions()
            selectedNode.run(SKAction.rotate(toAngle: 0.0, duration: 0.1))
            
            selectedNode = touchedNode[0] as! SKSpriteNode
        
            if touchedNode[0].name == kMovableNodeName {
                let sequence = SKAction.sequence([
                    SKAction.rotate(byAngle: degToRad(degree: -4.0), duration: 0.1),
                    SKAction.rotate(byAngle: 0.0, duration: 0.1),
                    SKAction.rotate(byAngle: degToRad(degree: 4.0), duration: 0.1)
                    ])
                
                selectedNode.run(SKAction.repeatForever(sequence))
            }
        }
        
    }
    
    private func boundLayerPos(_ aNewPosition: CGPoint) -> CGPoint {
        let winSize = self.size
        var retval = aNewPosition
        
        retval.x = CGFloat(min(retval.x, 0))
        retval.x = CGFloat(max(retval.x, -(self.background.size.width) + winSize.width))
        
        retval.y = CGFloat(min(retval.y, 0))
        retval.y = CGFloat(max(retval.y, -(self.background.size.height) + winSize.height))
        
        return retval
    }
    
    private func panForTranslation(translation: CGPoint) {
        let position = selectedNode.position
        
        if selectedNode.name! == kMovableNodeName {
            selectedNode.position = CGPoint(x: position.x + translation.x, y: position.y + translation.y)
        } else {
            let aNewPosition = CGPoint(x: position.x + translation.x, y: position.y + translation.y)
            background.position = self.boundLayerPos(aNewPosition)
        }
    }
    
}

extension SKNode {
    func degToRad(degree: Double) -> CGFloat {
        return CGFloat(Double(degree) / 180.0 * M_PI)
    }
}
