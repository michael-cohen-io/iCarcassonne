//
//  Deck.swift
//  iCarcassonne
//
//  Created by Michael Cohen on 2/8/17.
//  Copyright © 2017 Michael Cohen. All rights reserved.
//

import Foundation

class Deck {
    
    static let sharedInstance = Deck()
    
    init() {
        
    }
    
    func makeNullTile() -> Tile {
        return Tile()
    }
    
    func makeRandomTile() {
        //Load random terrains
        var terrainDictionary = ["UP": TerrainType.randomTerrain(), "DOWN": TerrainType.randomTerrain(), "RIGHT": TerrainType.randomTerrain(), "LEFT": TerrainType.randomTerrain()]
        
        
        //verify that they are good to go
        while !verifyTerrains(terrains: terrainDictionary) {
            terrainDictionary = ["UP": TerrainType.randomTerrain(), "DOWN": TerrainType.randomTerrain(), "RIGHT": TerrainType.randomTerrain(), "LEFT": TerrainType.randomTerrain()]
        }
        
        //return tile
        //return Tile(withTerrains: terrainDictionary)
    }
    
    private func verifyTerrains(terrains t: [String: TerrainType]) -> Bool {
        //verify size
        if (t.count != 4) {
            return false
        }
        
        //verify that up, down, left, right exist
        if t["UP"] == nil {
            print("Terrain dictionary does not contain UP element")
            return false
        }
        
        if t["DOWN"] == nil {
            print("Terrain dictionary does not contain DOWN element")
            return false
        }
        
        if t["RIGHT"] == nil {
            print("Terrain dictionary does not contain RIGHT element")
            return false
        }
        
        if t["LEFT"] == nil {
            print("Terrain dictionary does not contain LEFT element")
            return false
        }
        
        
        //verify that none of the terrains are null
        if t["UP"]! == .NullTerrain ||
            t["DOWN"]! == .NullTerrain ||
            t["RIGHT"]! == .NullTerrain ||
            t["LEFT"]! == .NullTerrain  {
                return false
        }
        
        return true
    }
    
}
