//
//  TileCoordinate.swift
//  iCarcassonne
//
//  Created by Michael Cohen on 2/15/17.
//  Copyright © 2017 Michael Cohen. All rights reserved.
//

import Foundation


// This class represents 1 of the 9 coordinates within a Tile. These coordinates are NW, N, NE, E, SE, S, SW, W.
// Each corner coordinate contains 2 terrains, each edge coordinate contains 1 terrain
class TileCoordinate: CustomStringConvertible, NSCopying {
    let direction: Direction8
    var terrains = [Direction4: TerrainType]()
    
    var description: String {
        var des = "TileCoordinate: Direction=\(direction), Terrains= {"
        for t in terrains {
            des += " \(t)"
        }
        des += " }"
        return des
    }
    
    init(withEdge d: Direction8, terrain t1: TerrainType) {
        direction = d
        
        switch direction {
        case .NORTH:
            terrains[.NORTH] = t1
        case .EAST:
            terrains[.EAST] = t1
        case .WEST:
            terrains[.WEST] = t1
        case .SOUTH:
            terrains[.SOUTH] = t1
            
        default:
            print("ERROR: Incorrect initializer used")
        }
    }
    
    init(withCorner d: Direction8, firstTerrain t1: TerrainType, secondTerrain t2: TerrainType) {
        direction = d
        
        switch direction {
        case .NORTHEAST:
            terrains[.NORTH] = t1
            terrains[.EAST] = t2
            
        case .NORTHWEST:
            terrains[.NORTH] = t1
            terrains[.WEST] = t2
            
        case .SOUTHEAST:
            terrains[.SOUTH] = t1
            terrains[.EAST] = t2
            
        case .SOUTHWEST:
            terrains[.SOUTH] = t1
            terrains[.WEST] = t2
            
        default:
            print("ERROR: Incorrect initializer used")
        }
    }
    
    init(withDirection d: Direction8, terrains t: [Direction4: TerrainType]) {
        direction = d
        
        if direction == .NORTH || direction == .NORTHWEST || direction == .NORTHEAST {
            terrains[.NORTH] = t[.NORTH]
        }
        if direction == .EAST || direction == .NORTHEAST || direction == .SOUTHEAST {
            terrains[.EAST] = t[.EAST]
        }
        if direction == .SOUTH || direction == .SOUTHWEST || direction == .SOUTHEAST {
            terrains[.SOUTH] = t[.SOUTH]
        }
        if direction == .WEST || direction == .NORTHWEST || direction == .SOUTHWEST {
            terrains[.WEST] = t[.WEST]
        }
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = TileCoordinate(withDirection: self.direction, terrains: self.terrains)
        return copy
    }
}


enum Direction8 {
    case NORTHEAST
    case NORTH
    case NORTHWEST
    case WEST
    case SOUTHWEST
    case SOUTH
    case SOUTHEAST
    case EAST
}
