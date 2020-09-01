//
//  EmojiMemoryGame.swift
//  MemorizeApp
//
//  Created by Kevin Kim on 8/20/20.
//  Copyright © 2020 Kevin Kim. All rights reserved.
//

import SwiftUI

private let choices: [Int: Array<String>] = [
    0: ["🙄", "😅", "😇", "😛", "🥳", "🤬"],
    1: ["🐶", "🐼", "🙊", "🐝", "🐬", "🐥"],
    2: ["⚽️", "🪀", "🏉", "🏓", "⚾️", "🎱"],
    3: ["🍍", "🥦", "🧄", "🥕", "🍓", "🍐"]
]

private let color: [Int: Color] = [
    0: Color.red,
    1: Color.black,
    2: Color.yellow,
    3: Color.purple
]

 private let name: [Int: String] = [
    0: "Emotion",
    1: "Cute Animals",
    2: "Sports",
    3: "Eat Your Veggies"
]

var randomTheme: Int = Int.random(in: 0..<choices.keys.count)
var emojis: Array<String> = choices[randomTheme]!
var randomPair: Int = Int.random(in: 4...emojis.count)

func randomize() -> Void {
    randomTheme = Int.random(in: 0..<choices.keys.count)
    emojis = choices[randomTheme]!
    randomPair = Int.random(in: 4...emojis.count)
}

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String>{
        emojis.shuffle()
        var game = MemoryGame<String>(numberOfPairsOfCards: randomPair) { pairIndex in
            return emojis[pairIndex]
        }
        game.cards.shuffle()
        return game
    }
        
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var numMatches: Int {
        return model.numMatches
    }
    
    func resetModel() -> Void {
        model = EmojiMemoryGame.createMemoryGame()
    }
    
    func resetTheme() -> Void {
        randomize()
        model = EmojiMemoryGame.createMemoryGame()
    }
    
    // MARK: - Returns Themes to View
    
    var themeColor: Color {
        return color[randomTheme]!
    }
    
    var themeName: String {
        return name[randomTheme]!
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
