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
    
    
    //tile rotation is always 90 degrees clockwise:
    //  North -> East
    //  East -> South
    //  South -> West
    //  West -> North
    func rotateTile() {
        
        //Rotation has 2 steps:
        //  1. Rotate coordinate edge types
        //  2. Rotate edge nodes
        self.rotateCoordinateEdges()
        self.rotateEdgeNodes()
    }
    
    private func rotateCoordinateEdges() {
   
        // create deep copy of coordinates dictionary
        var coordCopy = [Direction8: TileCoordinate]()
        
        for (direction, terrain) in self.coordinates {
            coordCopy[direction] = terrain.copy() as! TileCoordinate
        }
        
        
        // West -> North
        self.coordinates[.NORTHWEST]?.terrains[.NORTH] = coordCopy[.SOUTHWEST]?.terrains[.WEST]
        self.coordinates[.NORTH]?.terrains[.NORTH] = coordCopy[.WEST]?.terrains[.WEST]
        self.coordinates[.NORTHEAST]?.terrains[.NORTH] = coordCopy[.NORTHWEST]?.terrains[.WEST]

        // South -> West
        self.coordinates[.SOUTHWEST]?.terrains[.WEST] = coordCopy[.SOUTHEAST]?.terrains[.SOUTH]
        self.coordinates[.WEST]?.terrains[.WEST] = coordCopy[.SOUTH]?.terrains[.SOUTH]
        self.coordinates[.NORTHWEST]?.terrains[.WEST] = coordCopy[.SOUTHWEST]?.terrains[.SOUTH]
        
        // East -> South
        self.coordinates[.SOUTHEAST]?.terrains[.SOUTH] = coordCopy[.NORTHEAST]?.terrains[.EAST]
        self.coordinates[.SOUTH]?.terrains[.SOUTH] = coordCopy[.EAST]?.terrains[.EAST]
        self.coordinates[.SOUTHWEST]?.terrains[.SOUTH] = coordCopy[.SOUTHEAST]?.terrains[.EAST]
        
        // North -> East
        self.coordinates[.NORTHEAST]?.terrains[.EAST] = coordCopy[.NORTHWEST]?.terrains[.NORTH]
        self.coordinates[.EAST]?.terrains[.EAST] = coordCopy[.NORTH]?.terrains[.NORTH]
        self.coordinates[.SOUTHEAST]?.terrains[.EAST] = coordCopy[.NORTHEAST]?.terrains[.NORTH]
//
    }
    
    
    private func rotateEdgeNodes() {
        
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
    
    func printCoordinateEdges() {
        var str = "Coords:\n"
        str += "\((self.coordinates[.NORTHWEST]?.terrains[.NORTH])!) | \((self.coordinates[.NORTH]?.terrains[.NORTH])!) | \((self.coordinates[.NORTHEAST]?.terrains[.NORTH])!)\n"
        str += "\((self.coordinates[.NORTHWEST]?.terrains[.WEST])!) | \t\t\t| \((self.coordinates[.NORTHEAST]?.terrains[.EAST])!)\n"
        str += "------------------------------\n"
        str += "\((self.coordinates[.WEST]?.terrains[.WEST])!) | \t\t\t| \((self.coordinates[.EAST]?.terrains[.EAST])!)\n"
        str += "------------------------------\n"
        str += "\((self.coordinates[.SOUTHWEST]?.terrains[.WEST])!) | \t\t\t| \((self.coordinates[.SOUTHEAST]?.terrains[.EAST])!)\n"
        str += "\((self.coordinates[.SOUTHWEST]?.terrains[.SOUTH])!) | \((self.coordinates[.SOUTH]?.terrains[.SOUTH])!) | \((self.coordinates[.SOUTHEAST]?.terrains[.SOUTH])!)\n"
        
        
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
