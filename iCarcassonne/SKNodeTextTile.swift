//
//  SKNodeTextTile.swift
//  iCarcassonne
//
//  Created by Michael Cohen on 2/22/17.
//  Copyright © 2017 Michael Cohen. All rights reserved.
//

import UIKit
import SpriteKit

class SKNodeTextTile: SKSpriteNode {

    var coordinates: [Direction8: TileCoordinate]
    
    
    init(withTile t: Tile, x_pos x: Int, y_pos y: Int) {
        coordinates = t.coordinates
        super.init(texture: nil, color: .white, size: CGSize(width: 155, height: 155))
        self.addChild(SKSpriteNode(texture: nil, color: .darkGray, size: CGSize(width: 150, height: 150)))
        loadEdges()
        self.position = CGPoint(x: x, y: y)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadEdges() {
        //NW-N
        let typeNW_N = coordinates[.NORTHWEST]?.terrains[.NORTH]
        let edgeNW_N = newCorner(territoryType: typeNW_N!, x_pos: -45, y_pos: 60)
        self.addChild(edgeNW_N)
        
        //NW-W
        let typeNW_W = coordinates[.NORTHWEST]?.terrains[.WEST]
        let edgeNW_W = newCorner(territoryType: typeNW_W!, x_pos: -60, y_pos: 45)
        self.addChild(edgeNW_W)
        
        //N-N
        let typeN_N = coordinates[.NORTH]?.terrains[.NORTH]
        let edgeN_N = newCorner(territoryType: typeN_N!, x_pos: 0, y_pos: 60)
        self.addChild(edgeN_N)
        
        //NE-N
        let typeNE_N = coordinates[.NORTHEAST]?.terrains[.NORTH]
        let edgeNE_N = newCorner(territoryType: typeNE_N!, x_pos: 45, y_pos: 60)
        self.addChild(edgeNE_N)
        
        //NE-E
        let typeNE_E = coordinates[.NORTHEAST]?.terrains[.EAST]
        let edgeNE_E = newCorner(territoryType: typeNE_E!, x_pos: 60, y_pos: 45)
        self.addChild(edgeNE_E)
        
        //W-W
        let typeW_W = coordinates[.WEST]?.terrains[.WEST]
        let edgeW_W = newCorner(territoryType: typeW_W!, x_pos: -60, y_pos: 0)
        self.addChild(edgeW_W)
        
        //E-E
        let typeE_E = coordinates[.EAST]?.terrains[.EAST]
        let edgeE_E = newCorner(territoryType: typeE_E!, x_pos: 60, y_pos: 0)
        self.addChild(edgeE_E)
        
        //SW-W
        let typeSW_W = coordinates[.SOUTHWEST]?.terrains[.WEST]
        let edgeSW_W = newCorner(territoryType: typeSW_W!, x_pos: -60, y_pos: -55)
        self.addChild(edgeSW_W)
        
        //SW-S
        let typeSW_S = coordinates[.SOUTHWEST]?.terrains[.SOUTH]
        let edgeSW_S = newCorner(territoryType: typeSW_S!, x_pos: -45, y_pos: -70)
        self.addChild(edgeSW_S)
        
        //S-S
        let typeS_S = coordinates[.SOUTH]?.terrains[.SOUTH]
        let edgeS_S = newCorner(territoryType: typeS_S!, x_pos: 0, y_pos: -70)
        self.addChild(edgeS_S)
        
        //SE-E
        let typeSE_E = coordinates[.SOUTHEAST]?.terrains[.EAST]
        let edgeSE_E = newCorner(territoryType: typeSE_E!, x_pos: 60, y_pos: -55)
        self.addChild(edgeSE_E)
        
        //SE-S
        let typeSE_S = coordinates[.SOUTHEAST]?.terrains[.SOUTH]
        let edgeSE_S = newCorner(territoryType: typeSE_S!, x_pos: 45, y_pos: -70)
        self.addChild(edgeSE_S)
    }
    
    private func newCorner(territoryType t: TerrainType, x_pos x: Int, y_pos y: Int) -> SKLabelNode {
        let cornerNode = SKLabelNode(fontNamed: "Helvetica")
        var cornerText = ""
        switch t {
        case .CityType:
            cornerText = "C"
        case .GrassType:
            cornerText = "G"
        case .RoadType:
            cornerText = "R"
        default:
            cornerText = ""
        }
        cornerNode.text = cornerText
        cornerNode.fontColor = .white
        cornerNode.fontSize = 14
        cornerNode.position = CGPoint(x: x, y: y)
        
        return cornerNode
    }
}
