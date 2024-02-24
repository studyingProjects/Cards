//
//  Card.swift
//  Cards
//
//  Created by Andrei Shpartou on 23/02/2024.
//

import Foundation

// типы фигуры карт
enum CardType: CaseIterable {
    case circle
    case cross
    case square
    case fill
}

// цвета карт
enum CardColor: CaseIterable {
    case red
    case green
    case black
    case gray
    case brown
    case yellow
    case purple
    case orange
}

typealias Card = (type: CardType, color: CardColor)

