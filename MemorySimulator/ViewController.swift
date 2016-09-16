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
        
        let headNode = MemoryNode(totalSize: 50, isFreeSpace: true)
        let nextNode = MemoryNode(totalSize: 15, isFreeSpace: false)
        let otherNode = MemoryNode(totalSize: 25, isFreeSpace: false)
        let otherNode2 = MemoryNode(totalSize: 35, isFreeSpace: false)

        
        let memory = MemoryList(withHead: headNode)
        memory.firstFistInsert(node: nextNode)
        memory.firstFistInsert(node: otherNode)
        memory.firstFistInsert(node: otherNode2)
        memory.firstFistRemove(processID: 1)
        memory.printListSizes()
        
    }

        
    //MARK: TableView
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}

