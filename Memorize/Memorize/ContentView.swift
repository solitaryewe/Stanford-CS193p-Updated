//
//  ContentView.swift
//  Memorize
//
//  Created by Woolly on 4/18/22.
//

import SwiftUI

struct ContentView: View {
    @State var emojis: [String] = plantEmojis
    @State var highlightColor: Color = plantColor
    
    static let plantEmojis = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝", "🍅", "🍆", "🥑", "🥦", "🥬", "🥒", "🌶", "🫑", "🌽", "🥕", "🫒", "🧄", "🧅", "🍠"]
    static let plantColor = Color.green
    
    static let animalEmojis = ["🦋", "🐈", "🐩", "🐝", "🐸", "🦆", "🐓", "🦀", "🐛", "🐺", "🐬", "🦎", "🐘", "🦜", "🦙", "🐏", "🦩", "🐋"]
    static let animalsColor = Color.red
    
    static let spaceEmojis = ["🚀", "☀️", "🌙", "🪐", "✨", "🌎", "👽", "🛸", "👾", "⭐️", "☄️", "🛰", "🔭"]
    static let spaceColor = Color.blue
    
    // Extra Credit #2
    func widthThatBestFits(cardCount: Int, height: CGFloat, width: CGFloat) -> CGFloat {
        let canBeLarger = true
        var cardWidth = 45.0
        
        while (canBeLarger == true) {
            cardWidth += 10
            
            let cardHeight = (3/2) * cardWidth
            let columns = ceil(width / cardWidth)
            let rows = ceil(Double(cardCount) / columns)
            
            if (height < (rows * cardHeight)) {
                cardWidth -= 10
                
                // Trying to account for padding of the cards.
                return cardWidth - ((cardWidth/columns) > 75 ? 75 : cardWidth/columns)
            }
        }
    }
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            
            // Extra Credit #2
            GeometryReader { geo in
                let height = geo.size.height
                let width = geo.size.width
                
                ScrollView {
                    // Extra Credit #1
                    let maxToShow = Int.random(in: 4..<emojis.count)
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: widthThatBestFits(cardCount: maxToShow, height: height, width: width - 50)))]) {    // Subtract some from width to account for padding.
                            ForEach(emojis[0..<maxToShow], id: \.self) {
                                CardView(emoji: $0)
                                .aspectRatio(2/3, contentMode: .fit)
                            }
                        }
                        .padding(.horizontal)
                        .foregroundColor(highlightColor)
                }
            }
            
            Spacer()
            
            HStack {
                Spacer()
                plantsButton
                Spacer()
                animalsButton
                Spacer()
                spaceButton
                Spacer()
            }
            .padding([.top, .leading, .trailing])
            .font(.largeTitle)
        }
    }
    
    var plantsButton: some View {
        Button {
            emojis = Self.plantEmojis.shuffled()
            highlightColor = Self.plantColor
        } label: {
            VStack {
                Image(systemName: "line.3.crossed.swirl.circle")
                Text("Plants")
                    .font(.subheadline)
            }
        }
    }
    
    var animalsButton: some View {
        Button {
            emojis = Self.animalEmojis.shuffled()
            highlightColor = Self.animalsColor
        } label: {
            VStack {
                Image(systemName: "sun.max.circle")
                Text("Animals")
                    .font(.subheadline)
            }
        }
    }
    
    var spaceButton: some View {
        Button {
            emojis = Self.spaceEmojis.shuffled()
            highlightColor = Self.spaceColor
        } label: {
            VStack {
                Image(systemName: "moon.circle")
                Text("Space")
                    .font(.subheadline)
            }
        }
    }
    
}

struct CardView: View {
    var emoji: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(emoji).font(.largeTitle)
            } else {
                shape
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Show both light and dark previews.
        ContentView()
            .preferredColorScheme(.light)
//        ContentView()
//            .preferredColorScheme(.dark)
    }
}
