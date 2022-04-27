# Memorize: *Assignment 1*
The complete code for this assignment can be found [here](https://github.com/solitaryewe/Stanford-CS193p-Updated/tree/9394bc9fb356d754cacf46016d54d471cbb77e61/Memorize/Memorize).

![Memorize: Assignment 1](https://github.com/solitaryewe/Stanford-CS193p-Updated/blob/main/Memorize/Screenshots/memorize-assignment1a-large.png)![Memorize: Assignment 1](https://github.com/solitaryewe/Stanford-CS193p-Updated/blob/main/Memorize/Screenshots/memorize-assignment1b-large.png)

## Task 1
> Get the Memorize game working as demonstrated in lectures 1 and 2.  Type in all the code.  Do not copy/paste from anywhere.

✔️

## Task 2
> You can remove the ⊖ and ⊕ buttons at the bottom of the screen.

✔️

## Task 3
>Add a title “Memorize!” to the top of the screen.

```swift
Text("Memorize!")
    .font(.largeTitle)
```

## Task 4
> Add at least 3 “theme choosing” buttons to your UI, each of which causes all of the
cards to be replaced with new cards that contain emoji that match the chosen theme.
You can use Vehicles from lecture as one of the 3 themes if you want to, but you are
welcome to create 3 (or more) completely new themes.

There are 3 such themes present.

```swift
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
```

## Task 5
> The number of cards in each of your 3 themes should be different, but in no case
fewer than 8.

✔️

## Task 6
> The cards that appear when a theme button is touched should be in an unpredictable
(i.e. random) order. In other words, the cards should be shuffled each time a theme
button is chosen.

Within each "theme choosing" button we shuffle:
```swift
emojis = Self.plantEmojis.shuffled()
```

## Task 7
> The theme-choosing buttons must include an image representing the theme and text
describing the theme stacked on top of each other vertically.

Within each "theme choosing" button:
```swift
VStack {
    Image(systemName: "line.3.crossed.swirl.circle")
    Text("Plants")
        .font(.subheadline)
}
```

## Task 8
> The image portion of each of the theme-choosing buttons must be created using an
SF Symbol which evokes the idea of the theme it chooses (like the car symbol and the
Vehicles theme shown in the Screenshot section below).

✔️

## Task 9
>The text description of the theme-choosing buttons must use a noticeably smaller font
than the font we chose for the emoji on the cards.

```swift
.font(.subheadline)
```

## Task 10
> Your UI should work in portrait or landscape on any iPhone. This probably will not
require any work on your part (that’s part of the power of SwiftUI), but be sure to
experiment with running on different simulators in Xcode to be sure.

✔️

## Extra Credit 1
> Make a random number of cards appear each time a theme button is chosen. The
function Int.random(in: Range<Int>) can generate a random integer in any range,
for example, let random = Int.random(in: 15...75) would generate a random
integer between 15 and 75 (inclusive). Always show at least 4 cards though.

```swift
let maxToShow = Int.random(in: 4..<emojis.count)

...

ForEach(emojis[0..<maxToShow], id: \.self) {
  CardView(emoji: $0)
  .aspectRatio(2/3, contentMode: .fit)
}
```

## Extra Credit 2
> Try to come up with some sort of equation that relates the number of cards in the game
to the width you pass when you create your LazyVGrid’s GridItem(.adaptive(minimum:maximum:)) such that each time a theme button is chosen, the LazyVGrid makes the cards as big as possible without having to scroll.
...
Your reading assignment covers func syntax in detail of course, but you probably just want something like this: func widthThatBestFits(cardCount: Int) -> CGFloat.

I'm not sure if this is what he was looking for, but this is the best I could come up with with my current level of knowledge!

```swift
GeometryReader { geo in
    let height = geo.size.height
    let width = geo.size.width

...

// Subtract some from width to account for padding.
LazyVGrid(columns: [GridItem(.adaptive(minimum: widthThatBestFits(cardCount: maxToShow, height: height, width: width - 50)))]) {

...

func widthThatBestFits(cardCount: Int, height: CGFloat, width: CGFloat) -> CGFloat {
    var canBeLarger = true
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
```
