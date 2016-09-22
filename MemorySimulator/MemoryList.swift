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
                actualNodeInLoop.allocDate = Date()
                print("Process: \(actualNodeInLoop.processID!) added in memory at \(actualNodeInLoop.allocDate)")
                
                let vc = ViewController()
                
                //actualNodeInLoop.timerToFinish = Timer.scheduledTimer(timeInterval: TimeInterval(actualNodeInLoop.duration!), target: vc, selector: #selector(uau), userInfo: nil, repeats: false)
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
        
    }
    
    func firstFistRemove(processID : Int) {
        
        var actualNodeInLoop = self.head

        while true {
            if actualNodeInLoop.processID! == processID {
                actualNodeInLoop.isFreeSpace = true
                print("Process: \(actualNodeInLoop.processID!) removed at \(Date())")
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
        
    }
    
    func firstFistRemove(withProcess process: MemoryNode) {
        
        var actualNodeInLoop = self.head
        
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
        
    }
    
    func mergeFreeSpaces() {
        
        var actualNode = self.head
        
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
    
    func printListSizes() {
        var node = self.head
        print("-------x-------x------")
        while true {
            
            if node.isFreeSpace {
                print("Free Space: \(node.totalSize)MB")
            } else {
                print("Process: \(node.processID!) - \(node.totalSize)MB of used space")

            }
            
            if let nextNode = node.nextNode {
                node = nextNode
            } else {
                break
            }
        }
        print("-------x-------x------")

    }
    
    func verifyFreeSpaces() {
        
    }
    
    
}
