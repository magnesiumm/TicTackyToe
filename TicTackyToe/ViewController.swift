//
//  ViewController.swift
//  TicTackyToe
//
//  Created by AJ Radik on 1/15/20.
//  Copyright © 2020 AJ Radik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let brain = TTTBrain()
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet var board: [DesignableButton]!
    var gameBoardIsLocked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        topLabel.font = topLabel.font.withSize( (3.6/71) * UIScreen.main.bounds.height)
        resetButton(nil)
    }

    @IBAction func boardButtonWasPressed(_ sender: DesignableButton) {
        let col = sender.tag % 3
        let row = sender.tag / 3
        
        if gameBoardIsLocked {return}
        if !brain.checkForLegalMoveAtRowAndCol(row: row, col: col) {return}
        brain.placeTokenAtRowAndCol(row: row, col: col)
        sender.titleLabel!.text = "hi"
        sender.backgroundColor = brain.getCurrentPlayer() == "X" ? UIColor.systemPink : UIColor.systemGreen
        
        if brain.checkForDraw() {
            topLabel.text = "Draw!"
            topLabel.textColor = UIColor.label
            gameBoardIsLocked = true
            return
        }
        
        if brain.checkForWinner() {
            topLabel.text = "\(brain.getCurrentPlayer()) Won!"
            gameBoardIsLocked = true
            return
        }

        brain.switchPlayer()
        updateTopLabelForNextMove()
    }
    
    @IBAction func resetButton(_ sender: Any?) {
        brain.resetBrain()
        gameBoardIsLocked = false
        
        for button in board {
            button.backgroundColor = UIColor.secondarySystemFill
            button.titleLabel!.text = ""
        }
        
        updateTopLabelForNextMove()
    }
    
    func updateTopLabelForNextMove() {
        topLabel.text = "\(brain.getCurrentPlayer())'s Move"
        topLabel.textColor = brain.getCurrentPlayer() == "X" ? UIColor.systemPink : UIColor.systemGreen
    }
    
}

