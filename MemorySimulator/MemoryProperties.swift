//
//  MemoryProperties.swift
//  MemorySimulator
//
//  Created by Anne Kariny Silva Freitas on 22/09/16.
//  Copyright © 2016 Alan Rabelo Martins. All rights reserved.
//

import Foundation

class MemoryProperties {
    static var numberOfProcesses = 0
    static var strategy = "fistFit"
    static var sizeOfMemory = 0
    static var spaceForOS = 0
    static var intervalOfProcessSizeInMemory : ClosedRange<Int> = 0...1
    static var intervalOfTimeOfInstantiationOfAProcess : ClosedRange<Int> = 0...1
    static var intervalOfDurationOfAProcess : ClosedRange<Int>  = 0...1

}
