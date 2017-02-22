//
//  iCarcassonneTests.swift
//  iCarcassonneTests
//
//  Created by Michael Cohen on 2/3/17.
//  Copyright © 2017 Michael Cohen. All rights reserved.
//

import XCTest
@testable import iCarcassonne

class iCarcassonneTests: XCTestCase {
    
    var tile1: Tile?
    var tileID = 1
    
    override func setUp() {
        super.setUp()
        let builder = TileBuilder(plist: "Tile_Try1")
        tile1 = builder.loadFromPlist(TileWithId: tileID)!
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRotation() {

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
