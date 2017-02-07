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
    
    init(width: Int, height: Int) {
        
        tiles = Array(repeatElement(Array(repeatElement(Tile(), count: height)), count: width))
    }
    
    
    func printGrid() {
        for (width, row) in tiles.enumerated() {
            for (height,tile) in row.enumerated() {
                print("[\(width)][\(height)] \(tile)")
            }
        }
    }
}
