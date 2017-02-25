//
//  TileGrid.swift
//  iCarcassonne
//
//  Created by Michael Cohen on 2/7/17.
//  Copyright © 2017 Michael Cohen. All rights reserved.
//

import Foundation


class TileGrid {
    
    private var tiles: [[Tile]]
    private let nullTile = Tile()
    
    let gridHeight: Int
    let gridWidth: Int
    
    private var isGridEmpty = true
    
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
    func addTile(aTile t: Tile, x_pos x: Int, y_pos y: Int) -> Bool {
        
        //tile's terrains must match its neighbors' terrains
        if !isTileValidHere(tile: t, x_pos: x, y_pos: y) {
            print("TileGrid: one of the tile's neighbors has a mismatched terrain")
            return false
        }
        
        //one of the tile's potential neighbors must have a non-null tile
        // exception: if the tile about to be laid is the first tile
        if !locationIsNextToTile(x_pos: x, y_pos: y) && !isGridEmpty {
            print("TileGrid: none of the tile's potential neighbors are occupied tiles")
            return false
        }
        
        //current tile in [x][y] must be null for addition to occur
        if tiles[x][y] != nullTile {
            print("TileGrid: selected tile location is already occupied")
            return false
        }
        
        if isGridEmpty {
            isGridEmpty = false
        }
        
        if !self.connectNodes(newTile: t, x_pos: x, y_pos:y) {
            print("TileGrid: error connecting edge nodes of \(t)")
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
    //assumption: for all edges, the value of middle coordinate matches value of corners
    private func isTileValidHere(tile t: Tile, x_pos x: Int, y_pos y: Int) -> Bool {
        
        //Compare with above
        if (y-1 >= 0) {
            let t1 = t.coordinates[Direction8.NORTH]?.terrains[Direction4.NORTH]
            let t2 = tiles[x][y-1].coordinates[Direction8.SOUTH]?.terrains[Direction4.SOUTH]
            if !terrainTypesMatch(Terrain1: t1!, Terrain2: t2!) { return false }
        }
        
        //Compare with below
        if (y+1 <= gridHeight) {
            let t1 = t.coordinates[Direction8.SOUTH]?.terrains[Direction4.SOUTH]
            let t2 = tiles[x][y+1].coordinates[Direction8.NORTH]?.terrains[Direction4.NORTH]
            if !terrainTypesMatch(Terrain1: t1!, Terrain2: t2!) { return false }
        }
        
        //Compare with right
        if (x+1 <= gridWidth) {
            let t1 = t.coordinates[Direction8.EAST]?.terrains[Direction4.EAST]
            let t2 = tiles[x+1][y].coordinates[Direction8.WEST]?.terrains[Direction4.WEST]
            if !terrainTypesMatch(Terrain1: t1!, Terrain2: t2!) { return false }
        }
        
        //Compare with left
        if (x-1 >= 0) {
            let t1 = t.coordinates[Direction8.WEST]?.terrains[Direction4.WEST]
            let t2 = tiles[x-1][y].coordinates[Direction8.EAST]?.terrains[Direction4.EAST]
            if !terrainTypesMatch(Terrain1: t1!, Terrain2: t2!) { return false }
        }
        
        return true
    }
    
    private func terrainTypesMatch(Terrain1 t1: TerrainType, Terrain2 t2: TerrainType) -> Bool {
        return t1 == t2 || t2 == .NullTerrain
    }
    
    private func connectNodes(newTile t: Tile, x_pos x: Int, y_pos y: Int) -> Bool {
        //Attempt to connect tile's north to above's south edges
        if (y-1 >= 0) {
            let neighbor = tiles[x][y-1]
            if neighbor != nullTile {
                print("DELETE: Connecting \(t.id) to \(neighbor.id)")
                if !connectEdge(tile1: t, direction1: .NORTH, tile2: neighbor, direction2: .SOUTH) {
                    print("North err")
                    return false
                }
            }
        }
        
        //Attempt to connect tile's west to right's east edges
        if (x+1 <= gridWidth) {
            let neighbor = tiles[x+1][y]
            if neighbor != nullTile {
                print("DELETE: Connecting \(t.id) to \(neighbor.id)")
                if !connectEdge(tile1: t, direction1: .EAST, tile2: neighbor, direction2: .WEST) {
                    print("East err")
                    return false
                }
            }
        }
        
        //Attempt to connect tile's south to belows north edges
        if (y+1 <= gridHeight) {
            let neighbor = tiles[x][y+1]
            if neighbor != nullTile {
                print("DELETE: Connecting \(t.id) to \(neighbor.id)")
                if !connectEdge(tile1: t, direction1: .SOUTH, tile2: neighbor, direction2: .NORTH) {
                    print("South err")
                    return false
                }
            }
        }
        
        //Attempt to connect tile's east to left's west edges
        if (x-1 >= 0) {
            let neighbor = tiles[x-1][y]
            if neighbor != nullTile {
                print("DELETE: Connecting \(t.id) to \(neighbor.id)")
                if !connectEdge(tile1: t, direction1: .WEST, tile2: neighbor, direction2: .EAST) {
                    print("West err")
                    return false
                }
            }
        }
        
        return true
    }
    
    
    //TODO: FINISH TESTING
    private func connectEdge(tile1 t1: Tile, direction1 d1: Direction4,
                             tile2 t2: Tile, direction2 d2: Direction4) -> Bool {
        
        //Error cases
        guard let t1N1 = t1.edgeNodes[d1]?["N1"] else {
            print("Error unwrapping t1.n1")
            return false
        }
        
        guard let t1N2 = t1.edgeNodes[d1]?["N2"] else {
            print("Error unwrapping t1.n2")
            return false
        }
        
        guard let t1N3 = t1.edgeNodes[d1]?["N3"] else {
            print("Error unwrapping t1.n3")
            return false
        }
        
        guard let t2N1 = t2.edgeNodes[d2]?["N1"] else {
            print("Error unwrapping t2.n1")
            return false
        }
        
        guard let t2N2 = t2.edgeNodes[d2]?["N2"] else {
            print("Error unwrapping t2.n2")
            return false
        }
        
        guard let t2N3 = t2.edgeNodes[d2]?["N3"] else {
            print("Error unwrapping t2.n3")
            return false
        }
        
        //N1-N3
        if !(t1N1.addNeighbor(node: t2N3, direction: d1)) {
            return false
        }
        if !(t2N3.addNeighbor(node: t1N1, direction: d2)) {
            return false
        }
        
        //N2-N2
        if !(t1N2.addNeighbor(node: t2N2, direction: d1)) {
            return false
        }
        if !(t2N2.addNeighbor(node: t1N2, direction: d2)) {
            return false
        }
        
        //N3-N1
        if !(t1N3.addNeighbor(node: t2N1, direction: d1)) {
            return false
        }
        if !(t2N1.addNeighbor(node: t1N3, direction: d2)) {
            return false
        }
        
        return true
    }
    
    func clearMarkedNodes() {
        for column in tiles {
            for tile in column {
                if tile == self.nullTile {
                    continue
                }
                
                for (_, node) in tile.nodes! {
                    node.isVisited = false
                }
            }
        }
    }
}
