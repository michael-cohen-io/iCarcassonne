//
//  Tile.swift
//  iCarcassonne
//
//  Created by Michael Cohen on 2/3/17.
//  Copyright © 2017 Michael Cohen. All rights reserved.
//

import Foundation


class Tile: Prototype, CustomStringConvertible {
    
    //Tile attributes
    let terrain: TerrainType 
    var meeple: Meeple?
    
    //Printable attributes
    var description: String {
        var desc = "Tile: Type = \(self.terrain)"
        if let meep = self.meeple {
            desc += ", Meeple = \(meep)"
        }
        
        return desc
    }
    
    init() {
        terrain = .NullTerrain
    }
    
    init(withTerrain t: TerrainType) {
        terrain = t
    }
    
    init(withTerrain t: TerrainType, withMeeple m: Meeple) {
        terrain = t
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
        
        return Tile(withTerrain: self.terrain, withMeeple: self.meeple!)
    }
}
