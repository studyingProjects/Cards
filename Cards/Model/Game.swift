//
//  Game.swift
//  Cards
//
//  Created by Andrei Shpartou on 23/02/2024.
//

import Foundation

class Game {
    // количество пар уникальных карточек
    var cardsCount = 0
    // Card colors to choice
    var cardColors = [CardColor]()
    // Type of figures
    var cardTypes = [CardType]()
    // Card back side covers
    var cardBackCovers = [CardCover]()
    // массив сгенерированных карточек
    var cards = [Card]()
    // Количество переворотов
    var flipCounts: Int = 0
    
    // генерация массива случайных карт
    func generateCards() {
        // генерируем новый массив карточек
        var cards = [Card]()
        for _ in 0..<cardsCount {
//            let randomElement = (type: CardType.allCases.randomElement()!, color: CardColor.allCases.randomElement()!, cover: CardCover.circle)
            let randomElement = Card(type: cardTypes.randomElement()!,
                                     color: cardColors.randomElement()!,
                                     viewProperties: generateViewProperties(with: cardBackCovers))
            cards.append(randomElement)
        }
        self.cards = cards
    }
    
    func generateViewProperties(with covers: [CardCover]) -> [CardViewProperty] {
        var arrayOfProperties = [CardViewProperty]()
        arrayOfProperties.append(CardViewProperty(cover: covers.randomElement()!))
        arrayOfProperties.append(CardViewProperty(cover: covers.randomElement()!))
        return arrayOfProperties
    }

    // проверка эквивалентности карточек
    func checkCards(_ firstCard: Card, _ secondCard: Card) -> Bool {
        if firstCard.type == secondCard.type,
           firstCard.color == secondCard.color {
            return true
        }
        return false
    }

}
