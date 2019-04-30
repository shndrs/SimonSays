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

    @IBOutlet var colorButtons: [SHNDCircularButton]!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet var playerLabels: [UILabel]!
    @IBOutlet var scoreLabels: [UILabel]!

    @IBAction func colorButtonHandler(_ sender: SHNDCircularButton) {
        print("Button \(sender.tag) tapped")
    }
    
    
    @IBAction func actionButtonHandler(_ sender: UIButton) {
    }
    
    private func createNewGame() {
        actionButton.setTitle("Start Game", for: .normal)
        for button in colorButtons {
            button.alpha = 0.7
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

