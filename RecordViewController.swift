//
//  RecordViewController.swift
//  OneMinutes
//
//  Created by Дима on 13.11.2023.
//

import UIKit

class RecordViewController: UIViewController {

    @IBOutlet weak var recordLable: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let record = UserDefaults.standard.integer(forKey: keysUserDefaulets.recordGame)
        if record != 0{
            recordLable.text = "Ваш рекорд - \(record)"
        }else{
            recordLable.text = "Рекорд не установлен"
        }
    }

}
