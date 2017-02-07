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
    
    init(width: Int, height: Int) {
        
        tiles = Array(repeatElement(Array(repeatElement(Tile(), count: height)), count: width))
    }
    
    
    // default init, should almost never be used
    init() {
        tiles = Array(repeatElement(Array(repeatElement(Tile(), count: 10)), count: 10))
    }
    
    func addTile(toTile t: Tile, x_pos: Int, y_pos: Int) -> Bool {
        if t != nullTile {
            return false
        }
        
        tiles[x_pos][y_pos] = t
        return true
    }
    
    func printGrid() {
        for (width, row) in tiles.enumerated() {
            for (height,tile) in row.enumerated() {
                print("[\(width)][\(height)] \(tile)")
            }
        }
    }
}
