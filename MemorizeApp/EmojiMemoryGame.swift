//
//  EmojiMemoryGame.swift
//  MemorizeApp
//
//  Created by Kevin Kim on 8/20/20.
//  Copyright © 2020 Kevin Kim. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String>{
        var emojis: Array<String> = ["🙄", "😅", "😇", "😛", "🥳", "🤬"]
        emojis.shuffle()
        let randomNum = Int.random(in: 2...emojis.count)
        var game = MemoryGame<String>(numberOfPairsOfCards: randomNum) { pairIndex in
            return emojis[pairIndex]
        }
        game.cards.shuffle()
        print(game)
        return game
    }
        
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
