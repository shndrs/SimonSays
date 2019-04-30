//
//  ViewController.swift
//  Simon Says
//
//  Created by NP2 on 4/30/19.
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
    
    @IBOutlet var colorButtons: [SHNDCircularButton]!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet var playerLabels: [UILabel]!
    @IBOutlet var scoreLabels: [UILabel]!

    @IBAction func colorButtonHandler(_ sender: SHNDCircularButton) {
        print("Button \(sender.tag) tapped")
    }
    
    
    @IBAction func actionButtonHandler(_ sender: UIButton) {
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
    
    private func createNewGame() {
        colorSequence.removeAll()
        
        actionButton.setTitle("Start Game", for: .normal)
        actionButton.isEnabled = true
        for button in colorButtons {
            button.alpha = 0.7
            button.isEnabled = false
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
    
    private func addNewColor() {
        colorSequence.append(Int(arc4random_uniform(UInt32(4)))) // random number between 0 ti
    }
    
    private func playSequence() {
        if sequenceIndex < colorSequence.count {
            flash(button: colorButtons[sequenceIndex])
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
}

// MARK - Life Cycle

extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        sortUIElements()
        createNewGame()
    }
}

