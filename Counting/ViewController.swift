//
//  ViewController.swift
//  Counting
//
//  Created by Jkookoo on 10/05/2019.
//  Copyright © 2019 Jkookoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, sendBackDelegate {
    @IBOutlet weak var numberOfLeftLabel: UILabel!
    
    var totalNumber: Int? = 0
    
    @IBAction func reduceNumberButton(_ sender: UIButton) {
        if let totalNumber = self.totalNumber {
            if totalNumber > 4 {
                self.totalNumber = totalNumber - 1
            } else if totalNumber > 0 {
                self.totalNumber = totalNumber - 1
                self.chargingAlert()
            } else {
                self.emptyAlert()
            }
        }
        putTotalNumber()
    }
    
    func receiveData(data: Int) {
        if let totalNumber = self.totalNumber {
            self.totalNumber = totalNumber + data
            print("받았다")
        }
    }
    
    func emptyAlert() {
        let alert = UIAlertController(title: "경고!", message: "충전이 필요합니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func chargingAlert() {
        guard let totalNumber = self.totalNumber else {
            return
        }
        let alert = UIAlertController(title: "경고!", message: "\(totalNumber)번 남았습니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        let chargingAction = UIAlertAction(title: "Charge", style: .destructive, handler: {
            action in self.performSegue(withIdentifier: "editSegue", sender: self)
            
        })
        
        alert.addAction(okAction)
        alert.addAction(chargingAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func putTotalNumber() {
        if let totalNumber = self.totalNumber {
            self.numberOfLeftLabel.text = "\(totalNumber)"
        }
    }
    func saveTotalNumber() {
        if let totalNumber = self.totalNumber {
            UserDefaults.standard.set(totalNumber, forKey: "totalNumber")
        }
    }
    
    func loadTotalNumber() {
        if let data = UserDefaults.standard.value(forKey: "totalNumber") as? Int {
                self.totalNumber = data
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        putTotalNumber()
        saveTotalNumber()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        putTotalNumber()
        loadTotalNumber()
        
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue" {
            guard let editViewController = segue.destination as? editViewController else {
                return
            }
            editViewController.sendBackDelegate = self
        }
    }
}

