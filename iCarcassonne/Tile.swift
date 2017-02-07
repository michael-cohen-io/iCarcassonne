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
    var terrains: [String: TerrainType]
    var meeple: Meeple?
    
    //Printable attributes
    var description: String {
        var desc = "Tile: "
        if let meep = self.meeple {
            desc += "Meeple = \(meep)"
        }
        
        desc += "Terrains: ["
        for (side, type) in terrains {
            desc += " \(side): \(type),"
        }
        desc.remove(at: desc.index(before: desc.endIndex))
        desc += "]"
        
        
        return desc
    }
    
    // NULL init
    init() {
        terrains = [String: TerrainType]()
        terrains["UP"] = .NullTerrain
        terrains["Down"] = .NullTerrain
        terrains["Right"] = .NullTerrain
        terrains["Left"] = .NullTerrain
    }
    
    init(withTerrains t: [String: TerrainType]) {
        terrains = t
    }
    
    init(withTerrains t: [String: TerrainType], withMeeple m: Meeple) {
        terrains = t
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
        
        return Tile(withTerrains: self.terrains, withMeeple: self.meeple!)
    }
    
    // Equatable Methods
    
    static func ==(lhs: Tile, rhs: Tile) -> Bool {
        return lhs.terrains == rhs.terrains &&
            lhs.meeple == rhs.meeple
    }
}
