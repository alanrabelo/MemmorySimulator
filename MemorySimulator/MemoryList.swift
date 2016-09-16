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
    
    init(withHead head : MemoryNode) {
        self.head = head
        head.processID = 0
        numberOfProcesses = 0
        countOfProcesses += 1
        actualNode = self.head
    }
    
    func firstFistInsert(node : MemoryNode) {
        
        var actualNodeInLoop = self.head
        
        //ATUALIZA O CONTADOR DE PROCESSOS DA MEMÓRIA, PARA ATRIBUIR UM VALOR ÚNICO A CADA PROCESSO CASO NÃO SEJA UM ESPAÇO LIVRE
        if !node.isFreeSpace {
            node.processID = countOfProcesses
            countOfProcesses += 1
        }
        
        while true {
            
            //Verifica se o nó selecionado é um espaço livre e se tem espaço para receber o nó
            if actualNodeInLoop.isFreeSpace == true && actualNodeInLoop.totalSize >= node.totalSize {
                node.nextNode = self.head
                actualNodeInLoop.totalSize -= node.totalSize
                self.head = node
                print("Adicionado com sucesso!")

                break
            } else {
                //Verifica se o próximo não é nulo e repete o loop com o próximo nó
                if let nextNode = actualNodeInLoop.nextNode {
                    actualNodeInLoop = nextNode
                } else {
                    print("Faltou Espaço")
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
                actualNodeInLoop.processID = 0
                
                var nextNodeFromActualNodeInLoop : MemoryNode
                while true {
                    if let nextNode = actualNodeInLoop.nextNode {
                        nextNodeFromActualNodeInLoop = nextNode
                        if nextNodeFromActualNodeInLoop.isFreeSpace {
                            
                            if let nextNodeFromNextNode = nextNodeFromActualNodeInLoop.nextNode {
                                actualNodeInLoop.nextNode = nextNodeFromNextNode
                                nextNodeFromActualNodeInLoop = nextNodeFromActualNodeInLoop.nextNode!
                                break
                            }  else {
                                actualNodeInLoop.totalSize += nextNodeFromActualNodeInLoop.totalSize
                                actualNodeInLoop.nextNode = nil
                                break
                            }
                        }
                        break
                    } else {
                        print("Faltou Espaço")
                        break
                    }
                }
                
                break
            } else {
                if let nextNode = actualNodeInLoop.nextNode {
                    actualNodeInLoop = nextNode
                } else {
                    print("Faltou Espaço")
                    break
                }

            }
            
        }
        
    }
    
    func printListSizes() {
        var node = self.head
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
    }
    
    
}
