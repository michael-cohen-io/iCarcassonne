//
//  ViewController.swift
//  iCarcassonne
//
//  Created by Michael Cohen on 2/3/17.
//  Copyright © 2017 Michael Cohen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let grid = TileGrid(width: 4, height: 6)
        grid.printGrid()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

