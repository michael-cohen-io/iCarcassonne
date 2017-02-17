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
    case CityType = 1
    case GrassType
    case RoadType
    case Type4
    
    static var count: Int { return TerrainType.Type4.hashValue + 1}
    
    static func randomTerrain() -> TerrainType {
        //NullTerrain guarenteed to not be selected b/c NullTerrain.RawVal = -1
        let rand = arc4random_uniform(UInt32(count)) + 1
        return TerrainType(rawValue: Int(rand))!
    }
}

