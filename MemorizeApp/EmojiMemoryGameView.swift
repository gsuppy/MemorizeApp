//
//  ContentView.swift
//  MemorizeApp
//
//  Created by Kevin Kim on 8/19/20.
//  Copyright © 2020 Kevin Kim. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color.blue)
                        .padding()
                    Text("Number of Matches: \(self.viewModel.numMatches)")
                        .foregroundColor(Color.white)
                }
                .frame(minHeight: 0, maxHeight: 100.0)
                
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color.gray)
                        .padding()
                    Text("Theme: \(self.viewModel.themeName)")
                        .foregroundColor(Color.white)
                }
                .frame(minHeight: 0, maxHeight: 80.0)
            }

            
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
            .padding(5)
            }
            .padding()
            .foregroundColor(self.viewModel.themeColor)
            
            HStack {
                Button(action: {
                    print(self.viewModel.numMatches)
                    self.viewModel.resetModel()
                }) {
                    Text("Reset")
                    Image(systemName: "arrow.counterclockwise")
                }
                .frame(minWidth: 0, maxWidth: maxWidth, minHeight: 0, maxHeight: maxHeight)
                .foregroundColor(Color.white)
                .background(Color.red)
                .cornerRadius(cornerRadius)
                .padding(10)
                
                Button(action: {
                    print(self.viewModel.numMatches)
                    self.viewModel.resetTheme()
                }) {
                    Text("New Theme")
                    Image(systemName: "star.fill")
                }
                .frame(minWidth: 0, maxWidth: maxWidth, minHeight: 0, maxHeight: maxHeight)
                .foregroundColor(Color.white)
                .background(Color.pink)
                .cornerRadius(cornerRadius)
                .padding(10)
            }

        }
    }
    
    //MARK: - Drawing Constants
    let cornerRadius: CGFloat = 10.0
    let maxHeight: CGFloat = 40.0
    let maxWidth: CGFloat = 200.0
}

struct CardView: View {
    var card: MemoryGame<String>.Card
     
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack{
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(self.card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: 10.0).fill()
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    //MARK: - Drawing Constants
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    let fontScaleFactor: CGFloat = 0.75
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}
 

struct EmojiMemoryGameView_Previews: PreviewProvider {

    static var previews: some View {
        let game = EmojiMemoryGame()
        return EmojiMemoryGameView(viewModel: game)
    }
}
