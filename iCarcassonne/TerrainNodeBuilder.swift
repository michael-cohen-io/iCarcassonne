//
//  TerrainNodeBuilder.swift
//  iCarcassonne
//
//  Created by Michael Cohen on 2/17/17.
//  Copyright © 2017 Michael Cohen. All rights reserved.
//

import Foundation


class TerrainNodeBuilder {
    
    var tileData = [String: Any]()
    
    //                   [ID: Node]
    var nodeDictionary = [String: TerrainNode]()
    
    init() {
    
    }
    
    func getNodes() -> [String: TerrainNode] {
        return nodeDictionary
    }

    func buildNodes(withTileData t: [String: Any]) {
        tileData = t
     
        //                       [ID: RawData]
        var nodeDataDictionary = [String: [String: Any]]()
        
        for (key, aDirection) in tileData {
            if key == "id" {
                continue
            }
            
            //aDirection should be NW, N, NE...
            // needs to be cast down to a dictionary
            guard let directionDict = aDirection as? [String: Any]  else {
                continue
            }
            
            //directionDict = {NORTH: String, WEST: String, UP: {}, RIGHT: {},...
            for (directionKey, nodeData) in directionDict {
                if directionKey == "NORTH" ||
                    directionKey == "WEST" ||
                    directionKey == "SOUTH" ||
                    directionKey == "EAST" {
                    continue
                }
                
                guard let nd = nodeData as? [String: Any] else {
                    continue
                }
                
                //Skip cases in which the node already exists i.e. supernodes
                if nodeDictionary[(nd["id"] as? String)!] != nil {
                    continue
                }
                
                let aNode = buildNode(nodeData: nd)
                nodeDictionary[aNode.id] = aNode
                nodeDataDictionary[aNode.id] = nd
            }
        }
        
        self.connectNodes(withNodeDataDictionary: nodeDataDictionary)
    }
    
    private func buildNode(nodeData: [String: Any]) -> TerrainNode {
        guard let idString = nodeData["id"] as? String else {
            print("NodeBuilder Error: Node ID improperly set up")
            return TerrainNode()
        }
        
        let terrain = getTerrain(fromIDString: idString)
        
        return TerrainNode(withID: idString, withType: terrain)
    }
    
    //TODO: This is just bad craft
    private func getTerrain(fromIDString terrainString: String) -> TerrainType {
        if terrainString.contains("C") {
            return TerrainType.CityType
        }
        else if terrainString.contains("G") {
            return TerrainType.GrassType
        }
        else if terrainString.contains("R") {
            return TerrainType.RoadType
        }
        
        return TerrainType.NullTerrain
    }

    
    private func connectNodes(withNodeDataDictionary nData: [String: [String: Any]]) {
        for (id, rawConnectionData) in nData {
            let mNode = nodeDictionary[id]
            
            for (directionStr, cNodeIDStr) in rawConnectionData {
                // Skip id value
                if directionStr == "id" {
                    continue
                }
                // casting error
                guard let cNodeID = cNodeIDStr as? String else {
                    continue
                }
                
                // if cNodeID is empty, there is no neighbor to connect
                if cNodeID == "" {
                    continue
                }
                
                let connectingNode = nodeDictionary[cNodeID]
                let directionOfConnection = getDirection(fromDirectionString: directionStr)
                if !(mNode?.addNeighbor(node: connectingNode!, direction: directionOfConnection))! {
                    print("NodeBuilder Error: Connecting nodes failed")
                }
            }
        }
    }
    
    
    private func getDirection(fromDirectionString dStr: String) -> Direction4 {
        return Direction4(rawValue: dStr)!
    }
}
