//
//  SimulationViewController.swift
//  MemorySimulator
//
//  Created by Anne Kariny Silva Freitas on 22/09/16.
//  Copyright © 2016 Alan Rabelo Martins. All rights reserved.
//

import UIKit

var simulationViewController : SimulationViewController?

class SimulationViewController: UIViewController {
    
    @IBOutlet weak var waitingProcessesTableView: UITableView!
    
    
    @IBOutlet weak var finishedProcessesTableView: UITableView!
    
    @IBOutlet weak var memoryView: UIView!
    
    var totalSizeOfMemory = 0
    static var usedMemory = 0
    
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
        memory?.printListSizes()
        drawNodesInMemory(memory: memory!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawNodesInMemory(memory : MemoryList){
        
        var countOfProcesses = memory.countOfProcesses
        var actualNode : MemoryNode?
        var isSONode = true
        
        actualNode = memory.head
        
        while (countOfProcesses)>=0 {
            
            if actualNode != nil {
                
                let processSize = actualNode?.totalSize
                
                let processHeight = calcY(memory: memory, sizeOfProcess: processSize!)
                
                var processY = 500 - SimulationViewController.usedMemory
                
                if isSONode{
                    processY = 500 - processHeight
                    isSONode = false
                }
                
                print("Tamanho do processo \(processHeight)")
                print("Altura do processo \(processY)")
                
                if !(actualNode?.isFreeSpace)!{
                    drawProcess (x: 0, y: processY, width: 105, height: processHeight)
                } else {
                    drawFree (x: 0, y: processY, width: 105, height: processHeight)
                }
                
                actualNode = actualNode?.nextNode
                countOfProcesses -= 1
                
            } else{
                countOfProcesses -= 1
            }
        }
        
    }
    
    func calcY(memory : MemoryList, sizeOfProcess: Int) -> Int {
        SimulationViewController.usedMemory = SimulationViewController.usedMemory + (500*sizeOfProcess)/totalSizeOfMemory
        return (500*sizeOfProcess)/totalSizeOfMemory
        
    }
    
    func drawProcess(x: Int, y: Int, width: Int, height: Int) {
        
        let square = UIView(frame: CGRect(x: x, y: y , width: width, height: height))
        
        square.backgroundColor = UIColor.red
        
        self.memoryView.addSubview(square)
    }
    func drawFree(x: Int, y: Int, width: Int, height: Int) {
        
        let square = UIView(frame: CGRect(x: x, y: y , width: width, height: height))
        
        square.backgroundColor = UIColor.green
        
        self.memoryView.addSubview(square)
    }
    
}
