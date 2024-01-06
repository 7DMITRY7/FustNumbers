//
//  GameViewController.swift
//  OneMinutes
//
//  Created by Дима on 07.10.2023.
//

import UIKit

class GameViewController:
    
UIViewController {
    @IBOutlet weak var nextDigit: UILabel!
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var statusLable: UILabel!
    
    @IBOutlet weak var timerLable: UILabel!
    
    @IBOutlet weak var newGameButton: UIButton!
    
    lazy var game = Game(countItems: buttons.count) { [weak self](status, time) in
        guard let self = self else {return}
        self.timerLable.text = time.secondToString()
        self.updateInfoGame(with: status)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        game.stopGame()
        timerLable.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
    }

    

    @IBAction func pressButton(_ sender: UIButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else {return}
        game.check(index:buttonIndex)
        updateUI()
        
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
        sender.isHidden = true
        setupScreen()
    }
    
    private func setupScreen(){
        
        for index in game.items.indices{
            buttons[index].setTitle(game.items[index].title, for: .normal)
            buttons[index].alpha = 1
            buttons[index].isEnabled = true
        }
        
        nextDigit.text = game.nextItem?.title
        
    }
    private func updateUI(){
        for index in game.items.indices{
            buttons[index].alpha = game.items[index].isFound ? 0 : 1
            buttons[index].isEnabled = !game.items[index].isFound
            if game.items[index].isError{
                UIView.animate(withDuration: 0-3) {[weak self] in
                    self?.buttons[index].backgroundColor = .red
                }completion: {[weak self] (_) in
                    self?.buttons[index].backgroundColor = .systemOrange
                    self?.game.items[index].isError = false
                }
            }
        }
        nextDigit.text = game.nextItem?.title
       
        updateInfoGame(with: game.status)
    }
    private func updateInfoGame(with status: StasusGame){
        switch status{
        case .start:
            statusLable.text = "Игра началась"
            statusLable.textColor = .black
            newGameButton.isHidden = true
        case .win:
            statusLable.text = "Вы выйграли"
            statusLable.textColor = .green
            newGameButton.isHidden = false
            if game.isNewRecord{
                showAlert()
            }else{
                showAlertActionSheet()
            }
        case .lose:
            statusLable.text = "Вы проиграли"
            statusLable.textColor = .red
            newGameButton.isHidden = false
            showAlertActionSheet()
        }
    }
    
    private func showAlert(){
        
        let alert = UIAlertController(title: "Поздравляем!", message: "Вы установили новый рекорд", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    private func showAlertActionSheet(){
        let alert = UIAlertController(title: "Что вы хотите сделать дальше?", message: nil, preferredStyle: .actionSheet)
        
        let newGameAction = UIAlertAction(title: "Начать новую игру", style: .default) { [weak self](_) in
            self?.game.newGame()
            self?.setupScreen()
        }
        let showRecord = UIAlertAction(title: "Посмотреть рекорд", style: .default) {[weak self] (_) in
             
            self?.performSegue(withIdentifier: "recordVC", sender: nil)
            
            
        }
        let menuAtion = UIAlertAction(title: "Перейти в меню", style: .destructive) { [weak self] (_) in
            self?.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(newGameAction)
        alert.addAction(showRecord)
        alert.addAction(menuAtion)
        alert.addAction(cancelAction)
        
        if let popover = alert.popoverPresentationController{
            popover.sourceView = self.view
            popover.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popover.permittedArrowDirections = UIPopoverArrowDirection.init(rawValue: 0)
        }
        
        present(alert, animated: true, completion: nil)
    }
    
        
}
