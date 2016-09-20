//
//  ViewController.swift
//  MemorySimulator
//
//  Created by Alan Rabelo Martins on 9/15/16.
//  Copyright © 2016 Alan Rabelo Martins. All rights reserved.
//

import UIKit

enum strategyForMemoryManagement {
    case firstFit
    case bestFit
    case worstFit
    case nextFit
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var labelsText = ["Quantidade de Processos","Estratégia","Tamanho da Memória", "Espaço S.O.","Intervalo Tamanho de Memória","Intervalo Tempo","Intervalo Duração"]
    
    //VARIÁVEIS ACESSÓRIO
    var lastSelectedIndexpath : IndexPath!
    
    // VARIÁVEIS PARA GERAR A ESTRUTURA DA MEMÓRIA
    var numberOfProcesses = 0
    var strategy = strategyForMemoryManagement.firstFit
    var sizeOfMemory = 0
    var spaceForOS = 0
    var intervalOfProcessSizeInMemory = 0...1
    var intervalOfTimeOfInstantiationOfAProcess = 0...1
    var intervalOfDurationOfAProcess = 0...1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headNode = MemoryNode(totalSize: 150, isFreeSpace: true)
        let _15Node = MemoryNode(totalSize: 15, isFreeSpace: false)
        let _25Node = MemoryNode(totalSize: 25, isFreeSpace: false)
        let _35Node = MemoryNode(totalSize: 35, isFreeSpace: false)
        let _35Node2 = MemoryNode(totalSize: 35, isFreeSpace: false)


        
        let memory = MemoryList(withHead: headNode)
        memory.firstFistInsert(node: _15Node)
        memory.firstFistInsert(node: _25Node)

        memory.firstFistRemove(processID: 1)

        memory.firstFistInsert(node: _35Node)
        memory.firstFistInsert(node: _35Node2)

        memory.firstFistRemove(processID: 3)
        memory.firstFistRemove(processID: 4)
        
        memory.mergeFreeSpaces()
        memory.printListSizes()

    }

        
    //MARK: TableView
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}

