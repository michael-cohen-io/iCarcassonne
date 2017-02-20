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
    
    var edgeNodeDictionary = [Direction4: [String: TerrainNode]]()
    
    init() {
    
        //set up structure for edgeNodeDictionary
        let nullNode = TerrainNode()
        let nullEdgeDict = ["N1": nullNode, "N2": nullNode, "N3": nullNode]
        
        edgeNodeDictionary[.NORTH] = nullEdgeDict
        edgeNodeDictionary[.EAST] = nullEdgeDict
        edgeNodeDictionary[.SOUTH] = nullEdgeDict
        edgeNodeDictionary[.WEST] = nullEdgeDict
    }
    
    func getNodes() -> [String: TerrainNode] {
        return nodeDictionary
    }
    
    func getEdgeNodes() -> [Direction4: [String: TerrainNode]] {
        if edgeDictionaryDoesContainNullNodes() {
            print("INTERNAL STRUCTURE ERROR: One of the edge nodes was not properly loaded into edge node dictionary")
        }
        
        return edgeNodeDictionary
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
                
                //Ignore the values which are used in coordinate-terrain definition
                if directionKey == "NORTH" ||
                    directionKey == "WEST" ||
                    directionKey == "SOUTH" ||
                    directionKey == "EAST" {
                    continue
                }
                
                guard let nd = nodeData as? [String: Any] else {
                    continue
                }
                
                let aNode = buildNode(nodeData: nd)
                nodeDictionary[aNode.id] = aNode
                nodeDataDictionary[aNode.id] = nd
                
                self.addToEdgeDictionary(toEdge: key, node: aNode, withDirection: getDirection(fromDirectionString: directionKey))
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
    
    //Adds the provided node to its correct edge library contingent on the following cases:
    //  Coord: NW, Direction: N || W
    //  Coord: NE, Direction: N || E
    //  Coord: SE, Direction: S || E
    //  Coord: SW, Direction: S || W
    //  Coord: N,E,S,W figure out later
    private func addToEdgeDictionary(toEdge edgeStr: String, node n: TerrainNode, withDirection d: Direction4) {
        
        //completely ignore Middle coordinates to save time
        if (edgeStr == "M") {
            return
        }
        
        if (edgeStr.contains("NW")) {
            switch d {
            case .NORTH:
                    self.edgeNodeDictionary[.NORTH]?["N1"] = n
                    return
            case .WEST:
                    self.edgeNodeDictionary[.WEST]?["N3"] = n
                    return
            default:
                return
            }
        }
        if (edgeStr.contains("NE")) {
            switch d {
            case .NORTH:
                self.edgeNodeDictionary[.NORTH]?["N3"] = n
                return
            case .EAST:
                self.edgeNodeDictionary[.EAST]?["N1"] = n
                return
            default:
                return
            }
        }
        if (edgeStr.contains("SE")) {
            switch d {
            case .SOUTH:
                self.edgeNodeDictionary[.SOUTH]?["N1"] = n
                return
            case .EAST:
                self.edgeNodeDictionary[.EAST]?["N3"] = n
                return
            default:
                return
            }
        }
        if (edgeStr.contains("SW")) {
            switch d {
            case .SOUTH:
                self.edgeNodeDictionary[.SOUTH]?["N3"] = n
                return
            case .WEST:
                self.edgeNodeDictionary[.WEST]?["N1"] = n
                return
            default:
                return
            }
        }
        if (edgeStr == "N" && d == .NORTH) ||
            (edgeStr == "E" && d == .EAST) ||
            (edgeStr == "S" && d == .SOUTH) ||
            (edgeStr == "W" && d == .WEST) {
            self.edgeNodeDictionary[d]?["N2"] = n
        }
        
    }
    
    private func edgeDictionaryDoesContainNullNodes() -> Bool{
        for (_, nodeDict) in self.edgeNodeDictionary {
            for (_, aNode) in nodeDict {
                if aNode.isNullNode() { return true }
            }
        }
        
        return false
    }
    
    private func getDirection(fromDirectionString dStr: String) -> Direction4 {
        return Direction4(rawValue: dStr)!
    }
}
