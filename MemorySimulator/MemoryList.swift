//
//  MemoryList.swift
//  MemorySimulator
//
//  Created by Alan Rabelo Martins on 9/16/16.
//  Copyright © 2016 Alan Rabelo Martins. All rights reserved.
//

import UIKit

class MemoryList: NSObject {
    var head : MemoryNode
    var numberOfProcesses : Int
    var actualNode : MemoryNode
    var countOfProcesses = 0
    
    var rowOfProcessesWaiting = [MemoryNode]()
    var processesInMemory = [MemoryNode]()

    init(withHead head : MemoryNode) {
        self.head = head
        head.processID = 0
        numberOfProcesses = 0
        countOfProcesses += 1
        actualNode = self.head
        
    }
    
    func firstFitInsert(node : MemoryNode) {
        
        var actualNodeInLoop = self.head
        var previousFromActual : MemoryNode?
        
        //ATUALIZA O CONTADOR DE PROCESSOS DA MEMÓRIA, PARA ATRIBUIR UM VALOR ÚNICO A CADA PROCESSO CASO NÃO SEJA UM ESPAÇO LIVRE
        if !node.isFreeSpace {
            node.processID = countOfProcesses
            countOfProcesses += 1
        }
        
        self.mergeFreeSpaces()
        
        while true {
            
            //Verifica se o nó selecionado é um espaço livre e se tem espaço para receber o nó
            if actualNodeInLoop.isFreeSpace == true && actualNodeInLoop.totalSize >= node.totalSize {
                
                if previousFromActual != nil {
                    previousFromActual!.nextNode = node
                } else {
                    self.head = node
                }
                
                node.nextNode = actualNodeInLoop
                actualNodeInLoop.totalSize -= node.totalSize
                node.allocDate = Date()
                
                
                if node.duration != nil {
                    node.allocDate = Date()
                    node.finishedDate = node.allocDate?.addingTimeInterval(TimeInterval(node.duration!))
                    let timerToFinish = Timer.scheduledTimer(timeInterval: TimeInterval(node.duration!), target: self, selector: #selector(uau), userInfo: nil, repeats: false)
                    node.timerToFinish = timerToFinish
                }
                
                print("finish: \(node.finishedDate!)")
  
                
                self.processesInMemory.append(node)

                

                break
                
            } else {
                //Verifica se o próximo não é nulo e repete o loop com o próximo nó
                if let nextNode = actualNodeInLoop.nextNode {
                    previousFromActual = actualNodeInLoop
                    actualNodeInLoop = nextNode
                    
                } else {
                    print("Process is waiting in a row at \(node.creationDate)")
                    rowOfProcessesWaiting.append(node)
                    break
                }
            }
            
            
        }
        
        simulationViewController?.viewDidLoad()

        
    }
    
    func uau() {
        
        print("Finish")
        processesInMemory.sort(by: { $0.finishedDate!.compare($1.finishedDate!) == ComparisonResult.orderedAscending })

        self.firstFistRemove(withProcess: self.processesInMemory.first!)
        self.processesInMemory.removeFirst()
    }
    
    func firstFistRemove(processID : Int) {


        var actualNodeInLoop = self.head
        simulationViewController?.viewDidLoad()

        while true {
            
            if actualNodeInLoop.processID! == processID {
                actualNodeInLoop.isFreeSpace = true
                print("Process: \(actualNodeInLoop.processID!) removed at \(Date())")
//                simulationViewController?.viewDidLoad()
                actualNodeInLoop.processID = 0
                break
            } else {
                if let nextNode = actualNodeInLoop.nextNode {
                    actualNodeInLoop = nextNode
                } else {
                    break
                }
            }
        }
        
        self.mergeFreeSpaces()
        simulationViewController?.viewDidLoad()
        
    }
    
    func firstFistRemove(withProcess process: MemoryNode) {
        
        var actualNodeInLoop = self.head
        simulationViewController?.viewDidLoad()

        while true {
            
            if actualNodeInLoop == process {
                actualNodeInLoop.isFreeSpace = true
                print("Process: \(actualNodeInLoop.processID!) removed at \(NSDate())")
                actualNodeInLoop.processID = 0
                break
            } else {
                if let nextNode = actualNodeInLoop.nextNode {
                    actualNodeInLoop = nextNode
                } else {
                    break
                }
                
            }
            
            
        }
        self.mergeFreeSpaces()
        simulationViewController?.viewDidLoad()
        
    }
    
    func mergeFreeSpaces() {
        
        print(self.head.nextNode?.processID)
        var actualNode = self.head
        //simulationViewController?.viewDidLoad()

        while actualNode.nextNode != nil {
            
            while actualNode.nextNode!.isFreeSpace {
                
                if actualNode.isFreeSpace && actualNode.nextNode!.isFreeSpace {
                    
                    
                    if let nextNodefromNextNode = actualNode.nextNode!.nextNode {
                        actualNode.nextNode = nextNodefromNextNode
                        actualNode.totalSize += actualNode.nextNode!.totalSize
                    } else {
                        actualNode.totalSize += actualNode.nextNode!.totalSize
                        actualNode.nextNode = nil
                        return
                    }
                    
                } else {
                    break
                }
                
            }
            
            if actualNode.nextNode != nil {
                actualNode = actualNode.nextNode!
            } else {
                break
            }
        }
        
    }
    
    func printListSizes() -> String {
        
        var str = ""
        var node = self.head
        //str += "-------x-------x------"
        while true {
            
            if node.isFreeSpace {
                str += "Free Space: \(node.totalSize)MB \n"
            } else {
                str += "Process: \(node.processID!) - \(node.totalSize)MB of used space \n"

            }
            
            if let nextNode = node.nextNode {
                node = nextNode
            } else {
                break
            }
        }
        //str += "-------x-------x------"
        return str
    }
    
    func verifyFreeSpaces() {
        
    }
    
    
}

extension Date {
    func isGreaterThanDate(dateToCompare: Date) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    func isLessThanDate(dateToCompare: Date) -> Bool {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedAscending {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    func equalToDate(dateToCompare: Date) -> Bool {
        //Declare Variables
        var isEqualTo = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        
        //Return Result
        return isEqualTo
    }
    
    func addDays(daysToAdd: Int) -> Date {
        let secondsInDays: TimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: Date = self.addingTimeInterval(secondsInDays)
        
        //Return Result
        return dateWithDaysAdded
    }
    
    func addHours(hoursToAdd: Int) -> Date {
        let secondsInHours: TimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: Date = self.addingTimeInterval(secondsInHours)
        
        //Return Result
        return dateWithHoursAdded
    }
}
