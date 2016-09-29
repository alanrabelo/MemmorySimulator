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
    
    var memory : MemoryList?
    
    
    // VARIÁVEIS PARA GERAR A ESTRUTURA DA MEMÓRIA
    var numberOfProcesses = 0
    var processesArray = [MemoryNode]()
    
    var strategy = strategyForMemoryManagement.firstFit
    var sizeOfMemory = 0
    var spaceForOS = 0
    var intervalOfProcessSizeInMemory = 0...1
    var intervalOfTimeOfInstantiationOfAProcess = 0...1
    var intervalOfDurationOfAProcess = 0...1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureProcessesData(withNumberOfProceses: 5, andSizeOfMemory: 130, andSizeOfMemoryForOS: 25, andRangeForSizeOfProcessInMemory: 35...55, andRangeForCreationDelay: 2...5, andRangeForProcessDuration: 1...4)
        
        
    }
    
    func configureProcessesData(withNumberOfProceses numberOfProcesses : Int, andSizeOfMemory sizeOfMemory : Int, andSizeOfMemoryForOS sizeOS : Int, andRangeForSizeOfProcessInMemory rangeForSize : ClosedRange<Int>, andRangeForCreationDelay rangeDelay : ClosedRange<Int>, andRangeForProcessDuration rangeDuration : ClosedRange<Int>) {
        
        let operatingSystemProcess = MemoryNode(totalSize: sizeOS, isFreeSpace: false)
        let initialFreeSpace = MemoryNode(totalSize: sizeOfMemory, isFreeSpace: true)
        
        
        let sizesArray = generateRandomValues(withRange: rangeForSize, withQuantity: numberOfProcesses)
        let creationArray = generateRandomValues(withRange: rangeDelay, withQuantity: numberOfProcesses)
        let durationArray = generateRandomValues(withRange: rangeDuration, withQuantity: numberOfProcesses)
        
        var memoryArray = [MemoryNode]()
        let actualDate = Date()
        var countOfSecondsElapsed = 0
        
        for index in 0..<numberOfProcesses {
            
            let process = MemoryNode(totalSize: sizesArray[index], isFreeSpace: false)
            countOfSecondsElapsed += creationArray[index]
            process.creationDate = actualDate.addingTimeInterval(TimeInterval(countOfSecondsElapsed))
            process.duration = durationArray[index]
            
            countOfSecondsElapsed += process.duration!
            let timerToInstantiate = Timer.scheduledTimer(timeInterval: TimeInterval(countOfSecondsElapsed), target: self, selector: #selector(uau), userInfo: nil, repeats: false)
            
            process.timerToInstantiate = timerToInstantiate

            processesArray.append(process)
        }
        
        for process in memoryArray {
            print("\(process.creationDate) - \(process.finishedDate)")
        }
        
        
        
        memory = MemoryList(withHead: initialFreeSpace)
        memory!.firstFitInsert(node: operatingSystemProcess)
        
    }

    
    func uau() {
        if let firstProcess = processesArray.first {
            
            memory!.firstFitInsert(node: firstProcess)
            processesArray.removeFirst()
        }
    }
    func manageTime() {
        
        
        
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
    
    func generateRandomValues(withRange range : ClosedRange<Int>, withQuantity quantity : Int) -> [Int] {
        
        var arrayOfNumbers = [Int]()
        
        let lowerBound = range.lowerBound as! Int
        let upperBoundChanged = range.upperBound as! Int - lowerBound
        
        
        for index in 0..<quantity {
            
            let randomNumber = (arc4random_uniform(UInt32(upperBoundChanged)))
            
            arrayOfNumbers.append(Int(randomNumber) + lowerBound)
        }
        
        return arrayOfNumbers
    }

}

