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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
    }

    func getLabelForCell(atIndexPath indexpath : IndexPath) -> String {
        
        switch indexpath.row {
        case 0:
            return String(numberOfProcesses)
        case 1:
            return String(describing: strategy)
        case 2:
            return String("\(sizeOfMemory) MB")
        case 3:
            return String("\(spaceForOS) MB")
        case 4:
            return String("\(intervalOfProcessSizeInMemory) MB")
        case 5:
            return String("\(intervalOfTimeOfInstantiationOfAProcess) MB")
        case 6:
            return String("\(intervalOfDurationOfAProcess) MB")
        default:
            return "OI"
        }
        
    }
    
    //MARK: TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        
        
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.textColor = UIColor.lightGray
        cell.backgroundView = nil
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = labelsText[indexPath.row]
        cell.detailTextLabel?.text = getLabelForCell(atIndexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        lastSelectedIndexpath = indexPath
        performSegue(withIdentifier: "changeOptions", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let changeOptionsViewController = segue.destination as! ChangeOptionsViewController
        changeOptionsViewController.previousViewSelectedRow = lastSelectedIndexpath.row
        
    }

}

