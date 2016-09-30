//
//  SimulationViewController.swift
//  MemorySimulator
//
//  Created by Anne Kariny Silva Freitas on 22/09/16.
//  Copyright © 2016 Alan Rabelo Martins. All rights reserved.
//

import UIKit

var percentOfUsedMemoryStr = String()

var simulationViewController : SimulationViewController?

class SimulationViewController: UIViewController {
    
    @IBOutlet weak var percentOfUsedMemory: UILabel!
    
    @IBOutlet weak var logTextView: UITextView!
    
    @IBOutlet weak var memoryView: UIView!
    
    var totalSizeOfMemory = 0
    static var usedMemory = 0
    
    var memory : MemoryList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        simulationViewController = self
        
        //let headNode = MemoryNode(totalSize: 100, isFreeSpace: true)
        //totalSizeOfMemory = headNode.totalSize
        //let _15Node = MemoryNode(totalSize: 20, isFreeSpace: false)
        //let _25Node = MemoryNode(totalSize: 25, isFreeSpace: false)
        //        let _35Node = MemoryNode(totalSize: 35, isFreeSpace: false)
        //        let _35Node2 = MemoryNode(totalSize: 35, isFreeSpace: false)
        
        //let memory = MemoryList(withHead: headNode)
        //memory.firstFitInsert(node: _15Node)
        //memory.firstFitInsert(node: _25Node)
        //
        //        memory.firstFistRemove(processID: 1)
        //
        //        memory.firstFitInsert(node: _35Node)
        //        memory.firstFitInsert(node: _35Node2)
        //
        //        memory.firstFistRemove(processID: 3)
        //        memory.firstFistRemove(processID: 4)
        //
        //        memory.mergeFreeSpaces()
        //memory?.printListSizes()
        
        SimulationViewController.usedMemory = 0
        totalSizeOfMemory = MemoryProperties.sizeOfMemory
        
        logTextView.text = self.memory.printListSizes()
        drawNodesInMemory(memory: self.memory!)
        
        percentOfUsedMemory.text = percentOfUsedMemoryStr
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawNodesInMemory(memory : MemoryList){
        
        
        var memoryUsed = 0
        
        let countOfProcesses = memory.countOfProcesses
        var actualNode : MemoryNode?
        
        actualNode = memory.head
        while (countOfProcesses)>=0 {
            
            if actualNode != nil {
                
                let processSize = actualNode?.totalSize
                
                let processHeight = calcY(memory: memory, sizeOfProcess: processSize!)
                
                let processY = 500 - SimulationViewController.usedMemory
                
//                if isSONode{
//                    processY = 500 - processHeight
//                    isSONode = false
//                }
                
                if !(actualNode?.isFreeSpace)!{
                    draw (x: 0, y: processY, width: 105, height: processHeight, color: UIColor.red, actualProcess: actualNode!, boolIsFree:  false)
                    memoryUsed += processSize!

                } else {
                    draw (x: 0, y: processY, width: 105, height: processHeight, color: UIColor.blue, actualProcess: actualNode!, boolIsFree:  true)
                }
                
                actualNode = actualNode?.nextNode
                if actualNode?.nextNode == nil {
                    break
                }
                
            }
        }
        
        percentOfUsedMemoryStr = String((Double(memoryUsed)/Double(MemoryProperties.sizeOfMemory))*100)+"%"
        percentOfUsedMemory.text = String(format: "%.2f", percentOfUsedMemoryStr)
        
        
        
    }
    func calcY(memory : MemoryList, sizeOfProcess: Int) -> Int {
        SimulationViewController.usedMemory = SimulationViewController.usedMemory + (500*sizeOfProcess)/totalSizeOfMemory
        return (500*sizeOfProcess)/totalSizeOfMemory
        
    }
    
    func draw(x: Int, y: Int, width: Int, height: Int, color: UIColor, actualProcess: MemoryNode, boolIsFree: Bool) {
        
        simulationViewController?.memory.mergeFreeSpaces()
        
        let square = UIView(frame: CGRect(x: x, y: y , width: width, height: height))
        square.backgroundColor = color
        self.memoryView.addSubview(square)
        
        let label = UILabel(frame: CGRect(x: x, y: y , width: width, height: height))
        label.textColor = UIColor.white
        if !boolIsFree {
            label.text = "ID: \(actualProcess.processID!) - \(actualProcess.totalSize) MB"
        }
        label.font = UIFont(name: label.font.fontName, size: 10)
        label.textAlignment = NSTextAlignment.center
        label.center = square.center
        self.memoryView.addSubview(label)
    }
    
}
