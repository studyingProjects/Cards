//
//  Card.swift
//  Cards
//
//  Created by Andrei Shpartou on 23/02/2024.
//

import Foundation

// типы фигуры карт
enum CardType: String, CaseIterable, Codable {
    case circle
    case cross
    case square
    case fill
    case emptyCircle
}
// типы обложек карт
enum CardCover: String, CaseIterable, Codable {
    case circle
    case line
}
// цвета карт
enum CardColor: String, CaseIterable, Codable {
    case red
    case green
    case black
    case gray
    case brown
    case yellow
    case purple
    case orange
}

//typealias Card = (type: CardType, color: CardColor, covers: [CardCover])

struct Card: Codable {
    let type: CardType
    let color: CardColor
    var viewProperties: [CardViewProperty]
}

class CardViewProperty: Codable {
    var originX: CGFloat?
    var originY: CGFloat?
    var opacity: Float?
    var isFlipped: Bool?
    var cover: CardCover
    
    init(originX: CGFloat? = nil, originY: CGFloat? = nil, opacity: Float? = nil, isFlipped: Bool? = nil, cover: CardCover) {
        self.originX = originX
        self.originY = originY
        self.opacity = opacity
        self.isFlipped = isFlipped
        self.cover = cover
    }
}
