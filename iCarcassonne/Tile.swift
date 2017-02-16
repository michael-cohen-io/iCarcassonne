//
//  Tile.swift
//  iCarcassonne
//
//  Created by Michael Cohen on 2/3/17.
//  Copyright © 2017 Michael Cohen. All rights reserved.
//

import Foundation


class Tile: Prototype, CustomStringConvertible, Equatable {
    
    //Tile attributes
    var meeple: Meeple?
    var nodes: [TerrainNode]?
    var coordinates = [Direction8 : TileCoordinate]()
    
    
    //Printable attributes
    var description: String {
        var desc = "Tile: "
        if let meep = self.meeple {
            desc += "Meeple = \(meep)"
        }
        
        return desc
    }
    
    // NULL init
    init() {
        
        coordinates[.NORTHWEST] = TileCoordinate(withCorner: .NORTHWEST, firstTerrain: .NullTerrain, secondTerrain: .NullTerrain)
        coordinates[.NORTH] = TileCoordinate(withEdge: .NORTH, terrain: .NullTerrain)
        coordinates[.NORTHEAST] = TileCoordinate(withCorner: .NORTHEAST, firstTerrain: .NullTerrain, secondTerrain: .NullTerrain)
        coordinates[.WEST] = TileCoordinate(withEdge: .WEST, terrain: .NullTerrain)
        coordinates[.SOUTHWEST] = TileCoordinate(withCorner: .SOUTHWEST, firstTerrain: .NullTerrain, secondTerrain: .NullTerrain)
        coordinates[.SOUTH] = TileCoordinate(withEdge: .SOUTH, terrain: .NullTerrain)
        coordinates[.SOUTHEAST] = TileCoordinate(withCorner: .SOUTHEAST, firstTerrain: .NullTerrain, secondTerrain: .NullTerrain)
        coordinates[.EAST] = TileCoordinate(withEdge: .EAST, terrain: .NullTerrain)
        
        
        
    }
    
    
    init(withTerrains t: [String: TerrainType], withMeeple m: Meeple) {
        meeple = m
    }
    
    
    //Tile Methods
    
    func hasMeeple() -> Bool {
        return meeple != nil
    }
    
 
    
    //Prototype Methods
    func clone() -> Prototype {
        
        //In case Tile ever adopts a superclass GameObject
        //var tileClone = super.clone()
        
        return Tile()
    }
    
    // Equatable Methods
    
    static func ==(lhs: Tile, rhs: Tile) -> Bool {
        return lhs.meeple == rhs.meeple
    }
}
