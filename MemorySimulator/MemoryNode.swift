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
    var creationDate : Date?
    var allocDate : Date?
    var finishedDate : Date?
    var timerToInstantiate : Timer?
    var timerToFinish : Timer?

    var duration : Int?
    
    init(totalSize : Int, isFreeSpace : Bool) {
        self.totalSize = totalSize
        self.isFreeSpace = isFreeSpace
        nextNode = nil
        
    }
    
    func uau() {
        print("OK")
    }
    
    func waitingTime() -> TimeInterval? {
        if self.finishedDate != nil {
            return self.finishedDate!.timeIntervalSince(creationDate!)
        }
        
        return nil
    }
    
    
    
    
    
}
