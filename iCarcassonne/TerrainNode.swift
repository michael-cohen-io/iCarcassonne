//
//  TerrainNode.swift
//  iCarcassonne
//
//  Created by Michael Cohen on 2/15/17.
//  Copyright © 2017 Michael Cohen. All rights reserved.
//

import Foundation


/* 
 This class represents a terrain node. Each Tile is comprised of a map of these nodes. When Tiles are connected, their external nodes with no connections are made to connect.
 
 */

class TerrainNode: CustomStringConvertible, Equatable {
    let type: TerrainType
    var neighbors = [Direction4 : TerrainNode]()
    var isVisited: Bool = false
    
    
    //NOTE: Not my favorite approach for identifying nodes. Might revisit later
    //UPDATE: Changed from self-increasing Int to more identifying String
    let id: String
    
    //Printable attributes
    var description: String {
        let desc = "TerrainNode[\(id)][\(type)]"
        return desc
    }
    
    init(withID aID: String, withType t: TerrainType) {
        type = t
        id = aID
        
    }
    
    convenience init(withType t: TerrainType) {
        self.init(withID: "-1", withType: t)
    }
    
    convenience init() {
        self.init(withID: "-1", withType: TerrainType.NullTerrain)
    }
    
    
    // Adding a neighbord node is not guarenteed to work
    func addNeighbor(node n: TerrainNode, direction d: Direction4) -> Bool {
        if neighbors.count >= 4 {
            print("\(self) has max amount of neighbors")
            return false
        }

        if neighbors[d] != nil {
            print("\(self) already has a neighbor at \(d)")
            return false
        }
        
        neighbors[d] = n
        return true
    }
    
    // Preferred way to remove a node. Returns true if successful
    func removeNeighbor(direction d: Direction4) -> Bool {
        if neighbors[d] == nil {
            print("\(self) does not have a neighbor to remove at \(d)")
            return false
        }
        
        neighbors[d] = nil
        return true
    }
    
    // ancillary removal method. Takes longer
    func removeNeighbor(node n: TerrainNode) -> Bool {
        for (direction, neighbor) in neighbors {
            if neighbor == n {
                neighbors[direction] = nil
                return true
            }
        }
        
        return false
    }
    
    func isNullNode() -> Bool {
        return self.id == "-1"
    }
    
    // Equatable Methods
    
    static func ==(lhs: TerrainNode, rhs: TerrainNode) -> Bool {
        return lhs.id == rhs.id
    }
}

enum Direction4: String {
    case NORTH = "UP"
    case EAST = "RIGHT"
    case SOUTH = "DOWN"
    case WEST = "LEFT"
}
