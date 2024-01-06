//
//  SettingsTableViewController.swift
//  OneMinutes
//
//  Created by Дима on 11.10.2023.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    @IBOutlet weak var switchTime: UISwitch!
    
    @IBOutlet weak var timeGameLeble: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSettings()
    }
    
    
    @IBAction func changeTime(_ sender: UISwitch) {
        Settings.sehared.currentSetings.timeState = sender.isOn
    }
    func loadSettings(){
        timeGameLeble.text = "\(Settings.sehared.currentSetings.timeForGame) ceк"
        switchTime.isOn = Settings.sehared.currentSetings.timeState
    }
    
    @IBAction func resetSettigs(_ sender: Any) {
        Settings.sehared.resetSettings()
        loadSettings()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "selectTimeVC":
            if let vc = segue.destination as? SelectTimeViewController{
                vc.data = [10,20,30,40,50,60,70,80,90,100,110,120]
            }
        default:
            break
        }
    }
}
