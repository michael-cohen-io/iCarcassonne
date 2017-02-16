//
//  TerrainType.swift
//  iCarcassonne
//
//  Created by Michael Cohen on 2/7/17.
//  Copyright © 2017 Michael Cohen. All rights reserved.
//

import Foundation


enum TerrainType: Int {
    case NullTerrain = -1
    case Type1 = 1
    case Type2
    case Type3
    case Type4
    
    private static var _count: Int { return TerrainType.Type3.hashValue + 1}
    
    static func randomTerrain() -> TerrainType {
        //NullTerrain guarenteed to not be selected b/c NullTerrain.RawVal = -1
        let rand = arc4random_uniform(UInt32(_count)) + 1
        return TerrainType(rawValue: Int(rand))!
    }
}

