//
//  Board.swift
//  iCarcassonne
//
//  Created by Michael Cohen on 2/3/17.
//  Copyright © 2017 Michael Cohen. All rights reserved.
//

import Foundation


class Board {
    
    
    var grid: TileGrid?
    
    static let sharedInstance = Board()
    
    
    init() {
        grid = TileGrid()
    }
    
    
    func addTile(tile: Tile, x: Int, y: Int) throws {
        if grid == nil {
            throw BoardError.invalidTileLocation(x_pos: x, y_pos: y)
        }
        
        
    }
}


enum BoardError: Error {
    case invalidTileLocation(x_pos: Int, y_pos: Int)
    case singletonError
}
