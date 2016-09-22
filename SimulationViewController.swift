//
//  SimulationViewController.swift
//  MemorySimulator
//
//  Created by Anne Kariny Silva Freitas on 22/09/16.
//  Copyright © 2016 Alan Rabelo Martins. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController {
    
    @IBOutlet weak var waitingProcessesTableView: UITableView!
    
    
    @IBOutlet weak var finishedProcessesTableView: UITableView!

    @IBOutlet weak var memoryView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Desenha o S.O.
        draw(x: 0, y: 500, width: 105, height: 20)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawInMemory(){
        
    }
    
    func draw(x: Int, y: Int, width: Int, height: Int) {
        
        let square = UIView(frame: CGRect(x: x, y: y , width: width, height: height))
        
        square.backgroundColor = UIColor.red
        
        self.memoryView.addSubview(square)
    }
    
}
