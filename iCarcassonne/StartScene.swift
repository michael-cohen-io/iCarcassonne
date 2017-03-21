//
//  StartScene.swift
//  iCarcassonne
//
//  Created by Michael Cohen on 3/20/17.
//  Copyright © 2017 Michael Cohen. All rights reserved.
//

import UIKit
import SpriteKit

class StartScene: SKScene {

    var contentCreated = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        if(!contentCreated) {
            createContent()
            contentCreated = true
        }
    }
    
    private func createContent() {
        self.backgroundColor = SKColor.gray
        self.scaleMode = .aspectFill
        
        addHelloText()
        //addPairToCastButton()
    }
    
    private func addHelloText() {
        let helloLabel = SKLabelNode(fontNamed: "Helvetica")
        helloLabel.name = "HelloLabel"
        helloLabel.text = "Hello, World"
        helloLabel.color = SKColor.white
        helloLabel.fontSize = 42
        helloLabel.position = CGPoint(x: self.frame.midX,
                                      y: self.frame.midY)
        
        self.addChild(helloLabel)
    }
    
    private func addPairToCastButton() {
        //TODO: Replace with textured sprite

        
        let pairButton = SKSpriteNode(imageNamed: "CastButtonWhite")
        pairButton.anchorPoint = CGPoint(x: 1.0, y: 1.0)
        pairButton.position = CGPoint(x: self.frame.maxX,
                                     y: self.frame.maxY)
        pairButton.name = "CastButton"
        
        self.addChild(pairButton)
    }
    
    /* 
        TOUCH FUNCTIONS
     */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            fatalError("touchesBegan called erroneously")
        }
        let positionInScene = touch.location(in: self)
        
        let selectedNode = getSelectedNode(forTouchLocation: positionInScene)
        
        if selectedNode.isEqual(to: self.childNode(withName: "HelloLabel")!) {
            loadGameScene()
        }
        else if selectedNode.isEqual(to: self.childNode(withName: "CastButton")!) {
            selectedNode.run(SKAction.colorize(with: .black, colorBlendFactor: 1, duration: 0.0))
            //            loadCastSelection()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            fatalError("touchesBegan called erroneously")
        }
        let positionInScene = touch.location(in: self)
        
        let selectedNode = getSelectedNode(forTouchLocation: positionInScene)
        
        if selectedNode.isEqual(to: self.childNode(withName: "CastButton")!) {
            selectedNode.run(SKAction.colorize(withColorBlendFactor: 0.0, duration: 0.0))
        }
    }
    
    
    private func getSelectedNode(forTouchLocation t: CGPoint) -> SKNode {
        let touchedNodes = self.nodes(at: t)
        return touchedNodes[0]
    }
    
    private func loadGameScene() {
        let gameScene = GameplayScene(size: (self.view?.frame.size)!)
        self.view?.presentScene(gameScene)
    }
}
