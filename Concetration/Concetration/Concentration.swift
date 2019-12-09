//
//  Concentration.swift
//  Concetration
//
//  Created by Лилия Коблева on 08.12.2019.
//  Copyright © 2019 Stanford University. All rights reserved.
//

import Foundation


class Concetntration {

    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int){
       /* if cards[index].isFaceUp {
            cards[index].isFaceUp = false
        }else{
            cards[index].isFaceUp = true
        }*/
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                //either no cards or 2 cards are face up
                for flipdownIndex in cards.indices {
                    cards[flipdownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
            //let matchingCard = card
            /*cards.append(card)
            cards.append(card)//copy not a pointer*/
        }
        Shuffle()
    }
    
    // TODO: Shuffle the cards
    func Shuffle(){
        for index in cards.indices {
            //let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            let randomEl = cards.randomElement()!
            cards.replaceSubrange(Range<Int> (index...index), with: repeatElement(randomEl, count: 1))
            cards.insert(randomEl, at: index)
        }
    }
}
