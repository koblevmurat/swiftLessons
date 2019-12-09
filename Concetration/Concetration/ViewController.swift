//
//  ViewController.swift
//  Concetration
//
//  Created by Лилия Коблева on 06.11.2019.
//  Copyright © 2019 Stanford University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = Concetntration(numberOfPairsOfCards: (cardButtons.count + 1)/2)
    
    var flipCount: Int = 0 {
        didSet {
            FlipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    //: Array<String>
    var emojiChoices = ["🎃","👻","🦁","🐵","🐬","🍎","🍦","🍭","🍬"]//,"🏀"]
    
    var emoji = [Int: String]() // == Dictionary<Int, String>()
    
    func emoji (for card: Card) -> String {
        
    if emoji [card.identifier] == nil, emojiChoices.count > 0 {
        let randomIndex = Int(arc4random_uniform(UInt32( emojiChoices.count)))
        emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
    }
        
       /* if( emoji[card.identifier] != nil ){
            return emoji[card.identifier]!
        }
        else {
            return "?"
        }
         ==
         ->
         */
        
        return emoji[card.identifier] ?? "?"
    }
       
    
    @IBOutlet weak var FlipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
   
    //@IBOutlet var cardButons: Array<UIButton>!
    
    @IBAction func TouchCard(_ sender: UIButton) {
        flipCount+=1
        if let cardNumber = cardButtons.firstIndex(of: sender){
            //print("Card number \(cardNumber)")
            //flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else{
            print("Chosen card not in cardButtons")
        }
        
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji (for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 0) : #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            }
        }
    }
    
   
    func flipCard(withEmoji emoji: String, on button: UIButton)  {
        print("flip card (withEmoji: \(emoji))")
        if button.currentTitle! == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        }
        else {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
}

