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
    var root: [String: Any]?
    
    var rootWasLoaded = false
    
    init(plist p: String) {
        plistName = p
    }
    
    init() {
        plistName = "default.plist"
    }
    
    
    // TIGHT COUPLING: root element MUST be a Dictionary
    private func loadPropertyList() throws {
        guard let url = Bundle.main.url(forResource: plistName, withExtension: "plist") else {
            throw PlistError.FileDoesNotExist
        }
        
        guard let data = try? Data(contentsOf: url) else {
            throw PlistError.FileDataError
        }
        
        guard let dic = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String : Any] else {
            throw PlistError.FileLoadError
        }
        
        rootWasLoaded = true
        root = dic
    }
    
    func loadTileFromCurrentRoot() {
        if !rootWasLoaded {
            do {
                try self.loadPropertyList()
                
            } catch {
                print("Some Plist error")
            }
        }
        
        
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
