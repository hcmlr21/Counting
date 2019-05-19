//
//  editViewController.swift
//  Counting
//
//  Created by Jkookoo on 19/05/2019.
//  Copyright © 2019 Jkookoo. All rights reserved.
//

import UIKit
protocol sendBackDelegate {
    func receiveData(data: Int)
}

class editViewController: UIViewController {
    @IBOutlet weak var numberForAddLabel: UITextField!
    
    var sendBackDelegate: sendBackDelegate?
    
    @IBAction func addButton(_ sender: UIButton) {
        if let number = self.numberForAddLabel.text {
            if let numberOfInt = Int(number) {
                self.sendBackDelegate?.receiveData(data: numberOfInt)
                navigationController?.popViewController(animated: true)
            } else {
                typeAlert()
            }
        }
    }
    
    func typeAlert() {
        let alert = UIAlertController(title: "Check Type", message: "잘못 된 정보 입력", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
