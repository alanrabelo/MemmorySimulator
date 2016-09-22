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
    
    //TEXTFIELDS
    @IBOutlet weak var numberOfProcessesTextField: UITextField!
    @IBOutlet weak var strategyTextField: UITextField!
    @IBOutlet weak var sizeOfMemoryTextField: UITextField!
    @IBOutlet weak var spaceForOSTextField: UITextField!
    @IBOutlet weak var intervalOfProcessSizeInMemoryTextField: UITextField!
    @IBOutlet weak var intervalOfTimeOfInstatiationOfAProcessTextField: UITextField!
    @IBOutlet weak var intervalOfDurationOfAProcessTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    var labelsText = ["Quantidade de Processos","Estratégia","Tamanho da Memória", "Espaço S.O.","Intervalo Tamanho de Memória","Intervalo Tempo","Intervalo Duração"]
    
    //VARIÁVEIS ACESSÓRIO
    var lastSelectedIndexpath : IndexPath!
    
    var processes = [MemoryNode]()
    
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
        memory.firstFitInsert(node: _15Node)
        memory.firstFitInsert(node: _25Node)

        memory.firstFistRemove(processID: 1)

        memory.firstFitInsert(node: _35Node)
        memory.firstFitInsert(node: _35Node2)

        memory.firstFistRemove(processID: 3)
        memory.firstFistRemove(processID: 4)
        
        memory.mergeFreeSpaces()
        memory.printListSizes()

    }

        
    //MARK: TableView
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Quando muda de tela, salva as propriedades na classe estática
        if let numberOfProcessesText = numberOfProcessesTextField.text, let numberOfProcessesValue = Int(numberOfProcessesText) {
            MemoryProperties.numberOfProcesses = numberOfProcessesValue
        }
        
        if let strategyText = strategyTextField.text {
            MemoryProperties.strategy = strategyText
        }
        
        if let sizeOfMemoryText = sizeOfMemoryTextField.text, let sizeOfMemoryValue = Int(sizeOfMemoryText){
            MemoryProperties.sizeOfMemory = sizeOfMemoryValue
        }
        
        if let spaceForOSText = spaceForOSTextField.text, let spaceForOSValue = Int(spaceForOSText){
            MemoryProperties.spaceForOS = spaceForOSValue
        }
        
        if let intervalOfProcessSizeInMemoryText = intervalOfProcessSizeInMemoryTextField.text {
            
            let splitedText = intervalOfProcessSizeInMemoryText.characters.split{$0 == ","}.map(String.init)
            
            let interval = CountableClosedRange<Int>(uncheckedBounds: (lower: Int(splitedText[0])!, upper: Int(splitedText[1])!))
                
            MemoryProperties.intervalOfProcessSizeInMemory = interval
        
        }
        
        if let intervalOfTimeOfInstatiationOfAProcessText = intervalOfTimeOfInstatiationOfAProcessTextField.text {
            
            let splitedText = intervalOfTimeOfInstatiationOfAProcessText.characters.split{$0 == ","}.map(String.init)
            
            let interval = CountableClosedRange<Int>(uncheckedBounds: (lower: Int(splitedText[0])!, upper: Int(splitedText[1])!))
            
            MemoryProperties.intervalOfTimeOfInstantiationOfAProcess = interval
            
        }
        
        if let intervalOfDurationOfAProcessText = intervalOfDurationOfAProcessTextField.text {
            
            let splitedText = intervalOfDurationOfAProcessText.characters.split{$0 == ","}.map(String.init)
            
            let interval = CountableClosedRange<Int>(uncheckedBounds: (lower: Int(splitedText[0])!, upper: Int(splitedText[1])!))
            
            MemoryProperties.intervalOfDurationOfAProcess = interval
            
        }
        
        
    }

}

