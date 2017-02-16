//
//  TileGrid.swift
//  iCarcassonne
//
//  Created by Michael Cohen on 2/7/17.
//  Copyright © 2017 Michael Cohen. All rights reserved.
//

import Foundation


class TileGrid {
    
    var tiles: [[Tile]]
    let nullTile = Tile()
    
    let gridHeight: Int
    let gridWidth: Int
    
    init(width: Int, height: Int) {
        
        tiles = Array(repeatElement(Array(repeatElement(Tile(), count: height)), count: width))
        gridWidth = width
        gridHeight = height
    }
    
    
    // default init, should almost never be used
    init() {
        tiles = Array(repeatElement(Array(repeatElement(Tile(), count: 10)), count: 10))
        gridWidth = 10
        gridHeight = 10
    }
    
    // check if tile is valid, and if tile placement is valid before committing
    func addTile(toTile t: Tile, x_pos x: Int, y_pos y: Int) -> Bool {
        
        //tile's terrains must match its neighbors' terrains
        if !isTileValidHere(tile: t, x_pos: x, y_pos: y) {
            print("TileGrid: one of the tile's neighbors has a mismatched terrain")
            return false
        }
        
        //one of the tile's potential neighbors must have a non-null tile
        if !locationIsNextToTile(x_pos: x, y_pos: y) {
            print("TileGrid: none of the tile's potential neighbors are occupied tiles")
            return false
        }
        
        //current tile in [x][y] must be null for addition to occur
        if tiles[x][y] != nullTile {
            print("TileGrid: selected tile location is already occupied")
            return false
        }
        
        tiles[x][y] = t
        return true
    }
    
    
    //checks all four neighbors of the location to make sure that an active tile is present in one of them
    private func locationIsNextToTile(x_pos x: Int, y_pos y: Int) -> Bool {
        if (y-1 >= 0) && tiles[x][y-1] != nullTile {
            return true
        }
        
        if (y+1 >= 0) && tiles[x][y+1] != nullTile {
            return true
        }
        
        if (x-1 >= 0) && tiles[x-1][y] != nullTile {
            return true
        }
        
        if (x+1 >= 0) && tiles[x+1][y] != nullTile {
            return true
        }
        
        return false
    }
    
    //checks that the provided tile matches the terrains that neighbor it
    private func isTileValidHere(tile t: Tile, x_pos x: Int, y_pos y: Int) -> Bool {
        
//        //Compare type with above
//        if (y-1 >= 0) {
//            if !terrainTypesValid(Terrain1: t.terrains["UP"]!, Terrain2: tiles[x][y-1].terrains["DOWN"]!) { return false }
//        }
//        
//        //Compare type with below
//        if (y+1 <= gridHeight) {
//            if !terrainTypesValid(Terrain1: t.terrains["DOWN"]!, Terrain2: tiles[x][y+1].terrains["UP"]!) { return false }
//        }
//        
//        //Compare type with right
//        if (x+1 <= gridWidth) {
//            if !terrainTypesValid(Terrain1: t.terrains["RIGHT"]!, Terrain2: tiles[x][y-1].terrains["LEFT"]!) { return false }
//        }
//        
//        //Compare type with left
//        if (x-1 >= 0) {
//            if !terrainTypesValid(Terrain1: t.terrains["LEFT"]!, Terrain2: tiles[x][y-1].terrains["RIGHT"]!) { return false }
//        }
        
        return true
    }
    
    private func terrainTypesValid(Terrain1 t1: TerrainType, Terrain2 t2: TerrainType) -> Bool {
        return t1 == t2 || t2 == .NullTerrain
    }
}
