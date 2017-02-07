//
//  Board.swift
//  iCarcassonne
//
//  Created by Michael Cohen on 2/3/17.
//  Copyright © 2017 Michael Cohen. All rights reserved.
//

import Foundation


class Board {
    
    //TODO: Refactor into better data structure for grids
    var tiles: Tile?
 
    
    static let sharedInstance = Board()
    
    
    init() {
        tiles = nil
    }
    
    
    func addTile(tile: Tile, x: Int, y: Int) throws {
        if tile == nil {
            throw BoardError.invalidTileLocation(givenX: x, givenY: y)
        }
        
        
    }
}


enum BoardError: Error {
    case invalidTileLocation(givenX: Int, givenY: Int)
    case singletonError
}
