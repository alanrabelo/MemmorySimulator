//
//  MemoryNode.swift
//  MemorySimulator
//
//  Created by Alan Rabelo Martins on 9/16/16.
//  Copyright © 2016 Alan Rabelo Martins. All rights reserved.
//

import UIKit

class MemoryNode: NSObject {
    var totalSize : Int
    var isFreeSpace : Bool
    var nextNode : MemoryNode?
    var processID : Int!
    
    init(totalSize : Int, isFreeSpace : Bool) {
        self.totalSize = totalSize
        self.isFreeSpace = isFreeSpace
        nextNode = nil
        
    }
    
    
    
}
