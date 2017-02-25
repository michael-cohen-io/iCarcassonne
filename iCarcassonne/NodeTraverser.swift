//
//  NodeTraverser.swift
//  iCarcassonne
//
//  Created by Michael Cohen on 2/25/17.
//  Copyright © 2017 Michael Cohen. All rights reserved.
//

import Foundation


class NodeTraverser {
    private let mGrid: TileGrid
    
    init(grid: TileGrid) {
        mGrid = grid
    }
    
    
    func getGraphSize(forInitialNode n: TerrainNode) -> Int {
        mGrid.clearMarkedNodes()
        
        return traverseGraph(vertex: n)
    }
    
    private func traverseGraph(vertex v: TerrainNode) -> Int {
        var count = 0
        v.isVisited = true
        
        for (_, n) in v.neighbors {
            if !n.isVisited {
                count += traverseGraph(vertex: n)
            }
        }
        
        return count + 1
    }
    
    
}
