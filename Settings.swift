//
//  Settings.swift
//  OneMinutes
//
//  Created by Дима on 18.10.2023.
//

import Foundation

enum keysUserDefaulets{
    static let settingsGame = "settingsGame"
    static let recordGame = "recordGame"
}


struct SettingsGame:Codable{
    var timeState:Bool
    var timeForGame:Int
}

class Settings{
    static var sehared = Settings()
    let defaultSettings = SettingsGame(timeState: true, timeForGame: 30)
    var currentSetings:SettingsGame{
        get{
            if let data = UserDefaults.standard.object(forKey: keysUserDefaulets.settingsGame) as? Data{
                return try! PropertyListDecoder().decode(SettingsGame.self, from: data)
            }else{
                if let data = try? PropertyListEncoder().encode(defaultSettings){
                    UserDefaults.standard.setValue(data, forKey: keysUserDefaulets.settingsGame)
                }
                return defaultSettings
            }
        }
        set{
            if let data = try? PropertyListEncoder().encode(newValue){
                UserDefaults.standard.setValue(data, forKey: keysUserDefaulets.settingsGame)
            }
        }
    }
    func resetSettings(){
        currentSetings = defaultSettings
    }
    
}
