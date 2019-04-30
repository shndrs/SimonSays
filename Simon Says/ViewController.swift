//
//  ViewController.swift
//  Simon Says
//
//  Created by Sahand Raeisi on 4/30/19.
//  Copyright © 2019 shndrs. All rights reserved.
//

import UIKit
import SHNDStuffs

final class ViewController: UIViewController {

    private var currentPlayer = 0
    private var scores = [0,0]
    private var sequenceIndex = 0
    private var colorSequence = Array<Int>()
    private var colorsToTap = Array<Int>()
    private var gameEnded = false
    
    @IBOutlet private var colorButtons: [SHNDCircularButton]!
    @IBOutlet private weak var actionButton: UIButton!
    @IBOutlet private var playerLabels: [UILabel]!
    @IBOutlet private var scoreLabels: [UILabel]!

    @IBAction private func colorButtonHandler(_ sender: SHNDCircularButton) {
        print("on \(sender.tag) button tapped")
        if sender.tag == colorsToTap.removeFirst() {
            
        } else {
            for button in colorButtons {
                button.isEnabled = false
            }
            endGame()
            return
        }
        if colorsToTap.isEmpty {
            for button in colorButtons {
                button.isEnabled = false
            }
            scores[currentPlayer] += 1
            updateScoresLabels()
            switchPlayers()
            actionButton.setTitle("Continue", for: .normal)
            actionButton.isEnabled = true
        }
    }
    
    @IBAction private func actionButtonHandler(_ sender: UIButton) {
        sequenceIndex = 0
        actionButton.setTitle("Memorize", for: .normal)
        actionButton.isEnabled = false
        view.isUserInteractionEnabled = false
        addNewColor()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
            guard let shndSelf = self else { return }
            shndSelf.playSequence()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameEnded {
            gameEnded = false
            createNewGame()
        }
    }
    
    private func createNewGame() {
        colorSequence.removeAll()
        
        actionButton.setTitle("Start Game", for: .normal)
        actionButton.isEnabled = true
        for button in colorButtons {
            button.alpha = 0.7
            button.isEnabled = false
        }
        
        currentPlayer = 0
        scores = [0,0]
        playerLabels[currentPlayer].alpha = 1.0
        playerLabels[1].alpha = 0.75
        updateScoresLabels()
    }
    
    private func updateScoresLabels() {
        for (index,label) in scoreLabels.enumerated() {
            label.text = "\(scores[index])"
        }
    }
    
    private func switchPlayers() {
        playerLabels[currentPlayer].alpha = 0.5
        currentPlayer = currentPlayer == 0 ? 1 : 0
        playerLabels[currentPlayer].alpha = 1.0
    }
    
    private func endGame() {
        let message = currentPlayer == 0 ? "Player 2 Wins!" : "Player 1 Wins!"
        actionButton.setTitle(message, for: .normal)
        gameEnded = true
    }
    
    private func addNewColor() {
        colorSequence.append(Int(arc4random_uniform(UInt32(4)))) // random number between 0 ti
    }
    
    private func playSequence() {
        if sequenceIndex < colorSequence.count {
            flash(button: colorButtons[colorSequence[sequenceIndex]])
            sequenceIndex += 1
        } else {
            colorsToTap = colorSequence
            view.isUserInteractionEnabled = true
            actionButton.setTitle("Tap the Circles", for: .normal)
            for button in colorButtons {
                button.isEnabled = true
            }
        }
    }
    
    private func flash(button:SHNDButton) {
        UIView.animate(withDuration: 0.5, animations: {
            button.alpha = 1.0
            button.alpha = 0.7
        }) { [unowned self] (success) in
            self.playSequence()
        }
    }
    
    private func sortUIElements() {
        colorButtons = colorButtons.sorted() {
            $0.tag < $1.tag
        }
        
        playerLabels = playerLabels.sorted() {
            $0.tag < $1.tag
        }
        
        scoreLabels = scoreLabels.sorted() {
            $0.tag < $1.tag
        }
    }
}

// MARK - Life Cycle

extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        sortUIElements()
        createNewGame()
    }
}

