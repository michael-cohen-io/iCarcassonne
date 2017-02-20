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
    let id: Int
    var meeple: Meeple?
    
    //         [ID: Node]
    var nodes: [String: TerrainNode]?
    
    //                [Edge: Coordinate]
    var coordinates = [Direction8 : TileCoordinate]()
    
    
    //              [Edge: [N1: Node, N2: Node, N3: Node] ]
    var edgeNodes = [Direction4: [String: TerrainNode]]()
    
    //Printable attributes
    var description: String {
        var desc = "Tile: "
        if let meep = self.meeple {
            desc += "Meeple = \(meep)"
        }
        
        return desc
    }
    
    // NULL init
    convenience init() {
        self.init(withID: -1)
    }
    
    init(withID i: Int) {
        id = i
        
        coordinates[.NORTHWEST] = TileCoordinate(withCorner: .NORTHWEST, firstTerrain: .NullTerrain, secondTerrain: .NullTerrain)
        coordinates[.NORTH] = TileCoordinate(withEdge: .NORTH, terrain: .NullTerrain)
        coordinates[.NORTHEAST] = TileCoordinate(withCorner: .NORTHEAST, firstTerrain: .NullTerrain, secondTerrain: .NullTerrain)
        coordinates[.WEST] = TileCoordinate(withEdge: .WEST, terrain: .NullTerrain)
        coordinates[.SOUTHWEST] = TileCoordinate(withCorner: .SOUTHWEST, firstTerrain: .NullTerrain, secondTerrain: .NullTerrain)
        coordinates[.SOUTH] = TileCoordinate(withEdge: .SOUTH, terrain: .NullTerrain)
        coordinates[.SOUTHEAST] = TileCoordinate(withCorner: .SOUTHEAST, firstTerrain: .NullTerrain, secondTerrain: .NullTerrain)
        coordinates[.EAST] = TileCoordinate(withEdge: .EAST, terrain: .NullTerrain)
    }
    
    //Tile Methods
    
    func hasMeeple() -> Bool {
        return meeple != nil
    }
    
    func setCoordinateTerrains(toTerrainTypes t: [Direction8: TileCoordinate]) -> Bool {
        if !correctCoordinatesExist(terrainTypes: t) {
            return false
        }
        
        self.coordinates = t
        return true
    }
    
    private func correctCoordinatesExist(terrainTypes t: [Direction8: TileCoordinate]) -> Bool {
        
        if t[.NORTHWEST] == nil {
            print("TileError: setCoordinateTerrains(): .NORTHWEST coordinate not set")
            return false
        }
        
        if t[.NORTHWEST] == nil {
            print("TileError: setCoordinateTerrains(): .NORTHWEST coordinate not set")
            return false
        }
        if t[.NORTHWEST] == nil {
            print("TileError: setCoordinateTerrains(): .NORTHWEST coordinate not set")
            return false
        }
        if t[.NORTHWEST] == nil {
            print("TileError: setCoordinateTerrains(): .NORTHWEST coordinate not set")
            return false
        }
        if t[.NORTHWEST] == nil {
            print("TileError: setCoordinateTerrains(): .NORTHWEST coordinate not set")
            return false
        }
        if t[.NORTHWEST] == nil {
            print("TileError: setCoordinateTerrains(): .NORTHWEST coordinate not set")
            return false
        }
        if t[.NORTHWEST] == nil {
            print("TileError: setCoordinateTerrains(): .NORTHWEST coordinate not set")
            return false
        }
        if t[.NORTHWEST] == nil {
            print("TileError: setCoordinateTerrains(): .NORTHWEST coordinate not set")
            return false
        }
        
        return true
    }
    
    
    //Helper methods
    func printNodes() {
        for (id, node) in self.nodes! {
            var str = id + ": "
            for (dir, neighbor) in node.neighbors {
                str += "\(dir)=\(neighbor.id), "
            }
            print(str)
        }
    }
    
    func printEdges() {
        var str = "Coords: "
        for (_, coord) in self.coordinates {
            str += "Edge: \(coord) \n"
        }
        print(str)
    }
    
 
    
    //Prototype Methods
    func clone() -> Prototype {
        
        //In case Tile ever adopts a superclass GameObject
        //var tileClone = super.clone()
        
        return Tile()
    }
    
    // Equatable Methods
    
    static func ==(lhs: Tile, rhs: Tile) -> Bool {
        return lhs.id == rhs.id
    }
}
