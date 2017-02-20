//
//  TileBuilder.swift
//  iCarcassonne
//
//  Created by Michael Cohen on 2/15/17.
//  Copyright © 2017 Michael Cohen. All rights reserved.
//

import Foundation


class TileBuilder {
    
    var plistName: String
    var root: [[String: Any]]?
    
    var rootWasLoaded = false
    
    init(plist p: String) {
        plistName = p
    }
    
    init() {
        plistName = "default.plist"
    }
    
    
    // TIGHT COUPLING: root element MUST be an Array
    private func loadPropertyList() throws {
        guard let url = Bundle.main.url(forResource: plistName, withExtension: "plist") else {
            throw PlistError.FileDoesNotExist
        }
        
        guard let data = try? Data(contentsOf: url) else {
            throw PlistError.FileDataError
        }
        
        guard let dic = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [[String : Any]] else {
            throw PlistError.FileLoadError
        }
        
        rootWasLoaded = true
        root = dic
    }
    
    func loadFromPlist(TileWithId id: Int) -> Tile? {
        if !rootWasLoaded {
            do {
                try self.loadPropertyList()
                
            } catch {
                print("Some Plist error")
                return nil
            }
        }
        
        if id >= (root?.count)! || id < 0{
            print("provided TileID is outside bounds of tile array")
            return nil
        }
        
        /*
         TO BUILD A TILE:
         1. Find tile data from root array
         2. Find TileID
         3. Collect Terrain edges into a proper dictionary [Direction8: TileCoordinate]
         4. Build node graph
         5. Feed terrains and nodes into tile
         */
        
        let tileIndex = getTileIndex(ofTileWithID: id)
        if tileIndex == -1 {
            print("TileBuilder Error: Could not find tile of the provided value in Tile Array")
            return nil
        }
        
        //Successfully confirmed correct ID and index of the Tile in question
        let aTile = Tile(withID: id)
        
        let tileCoordinates = getTileCoordinateTerrains(forTileData: root?[tileIndex])
        if !aTile.setCoordinateTerrains(toTerrainTypes: tileCoordinates!) {
            print("Provided coordinates are incomplete")
            return nil
        }
        
        //BUILD NODE GRAPH
        let nodeBuilder = TerrainNodeBuilder()
        nodeBuilder.buildNodes(withTileData: (root?[tileIndex])!)
        aTile.nodes = nodeBuilder.getNodes()
        aTile.edgeNodes = nodeBuilder.getEdgeNodes()
        
        return aTile
    }
    
    // Attempts to identify the index of the tile with the provided ID.
    //      Returns -1 if cannot be found
    private func getTileIndex(ofTileWithID id: Int) -> Int {
        var index = 0
        for tile in root! {
            guard let tID = tile["id"] else {
                print("TileBuilder Error: One of the provided tile dictionaries is missing an ID")
                return -1
            }
            
            guard let idStr = tID as? String else {
                print("TileBuilder Error: Provided value for tile ID is not an int")
                return -1
            }
            
            if (Int(idStr) == id) {
                return index
            }
            
            index += 1
        }
        
        return -1
    }
    
    //Get terrain for each direction,
    // build into TileCoordinate object
    // & collect into dictionary
    private func getTileCoordinateTerrains(forTileData tileData: [String: Any]?) -> [Direction8: TileCoordinate]? {
        
        var coordinates = [Direction8: TileCoordinate]()
        
        
        // NW COORDINATES
        guard let NW_Dict = tileData?["NW"] as? [String: Any] else {
            print("Missing NW coordinate date")
            return nil
        }
        
        guard let NW_north = stringIDToTerrain(terrainID: (NW_Dict["NORTH"] as? String)!) else {
            print("Incorrect Terrain ID provided")
            return nil
        }
        
        guard let NW_west = stringIDToTerrain(terrainID: (NW_Dict["WEST"] as? String)!) else {
            print("Incorrect Terrain ID provided")
            return nil
        }
        
        // N COORDINATES
        guard let N_Dict = tileData?["N"] as? [String: Any] else {
            print("Missing NW coordinate date")
            return nil
        }
        
        guard let N_north = stringIDToTerrain(terrainID: (N_Dict["NORTH"] as? String)!) else {
            print("Incorrect Terrain ID provided")
            return nil
        }
        
        // NE COORDINATES
        guard let NE_Dict = tileData?["NE"] as? [String: Any] else {
            print("Missing NW coordinate date")
            return nil
        }
        
        guard let NE_north = stringIDToTerrain(terrainID: (NE_Dict["NORTH"] as? String)!) else {
            print("Incorrect Terrain ID provided")
            return nil
        }
        
        guard let NE_east = stringIDToTerrain(terrainID: (NE_Dict["EAST"] as? String)!) else {
            print("Incorrect Terrain ID provided")
            return nil
        }
        
        // E COORDINATES
        guard let E_Dict = tileData?["E"] as? [String: Any] else {
            print("Missing NW coordinate date")
            return nil
        }
        
        guard let E_east = stringIDToTerrain(terrainID: (E_Dict["EAST"] as? String)!) else {
            print("Incorrect Terrain ID provided")
            return nil
        }
        
        
        // SE COORDINATES
        guard let SE_Dict = tileData?["SE"] as? [String: Any] else {
            print("Missing NW coordinate date")
            return nil
        }
        
        guard let SE_south = stringIDToTerrain(terrainID: (SE_Dict["SOUTH"] as? String)!) else {
            print("Incorrect Terrain ID provided")
            return nil
        }
        
        guard let SE_east = stringIDToTerrain(terrainID: (SE_Dict["EAST"] as? String)!) else {
            print("Incorrect Terrain ID provided")
            return nil
        }
        
        // S COORDINATES
        guard let S_Dict = tileData?["S"] as? [String: Any] else {
            print("Missing NW coordinate date")
            return nil
        }
        
        guard let S_south = stringIDToTerrain(terrainID: (S_Dict["SOUTH"] as? String)!) else {
            print("Incorrect Terrain ID provided")
            return nil
        }
        
        // SW COORDINATES
        guard let SW_Dict = tileData?["SW"] as? [String: Any] else {
            print("Missing NW coordinate date")
            return nil
        }
        
        guard let SW_south = stringIDToTerrain(terrainID: (SW_Dict["SOUTH"] as? String)!) else {
            print("Incorrect Terrain ID provided")
            return nil
        }
        
        guard let SW_west = stringIDToTerrain(terrainID: (SW_Dict["WEST"] as? String)!) else {
            print("Incorrect Terrain ID provided")
            return nil
        }
        
        // W COORDINATES
        guard let W_Dict = tileData?["W"] as? [String: Any] else {
            print("Missing NW coordinate date")
            return nil
        }
        
        guard let W_west = stringIDToTerrain(terrainID: (W_Dict["WEST"] as? String)!) else {
            print("Incorrect Terrain ID provided")
            return nil
        }
        
        coordinates[.NORTHWEST] = TileCoordinate(withCorner: .NORTHWEST, firstTerrain: NW_north, secondTerrain: NW_west)
        coordinates[.NORTH] = TileCoordinate(withEdge: .NORTH, terrain: N_north)
        coordinates[.NORTHEAST] = TileCoordinate(withCorner: .NORTHEAST, firstTerrain: NE_north, secondTerrain: NE_east)
        coordinates[.EAST] = TileCoordinate(withEdge: .EAST, terrain: E_east)
        coordinates[.SOUTHEAST] = TileCoordinate(withCorner: .SOUTHEAST, firstTerrain: SE_south, secondTerrain: SE_east)
        coordinates[.SOUTH] = TileCoordinate(withEdge: .SOUTH, terrain: S_south)
        coordinates[.SOUTHWEST] = TileCoordinate(withCorner: .SOUTHWEST, firstTerrain: SW_south, secondTerrain: SW_west)
        coordinates[.WEST] = TileCoordinate(withEdge: .WEST, terrain: W_west)
        
        return coordinates
    }
    


    
    private func stringIDToTerrain(terrainID id: String) -> TerrainType? {
        let idInt = Int(id)
        if idInt! >= TerrainType.count || idInt! < 0 {
            return nil
        }
        
        return TerrainType(rawValue: idInt!)
    }
    
    func setPlist(toPlist p: String) {
        plistName = p
    }
}


enum PlistError: Error {
    case FileNotWritten
    case FileDoesNotExist
    case FileDataError
    case FileLoadError
}
