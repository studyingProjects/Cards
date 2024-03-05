//
//  CardViewFactory.swift
//  Cards
//
//  Created by Andrei Shpartou on 24/02/2024.
//

import UIKit

class CardViewFactory {
    
    func getCardView(from cardModel: Card, withSize size: CGSize, withProperties viewProperty: CardViewProperty, _ cardNumber: Int) -> UIView {
        
        let frame = CGRect(origin: .zero, size: size)
        let viewColor = getViewColorBy(modelColor: cardModel.color)
        
        let view: FlippableView = switch cardModel.type {
        case .circle:
            CardView<CircleShape>(frame: frame, color: viewColor, viewProperty.cover, cardIndex: cardNumber)
        case .cross:
            CardView<CrossShape>(frame: frame, color: viewColor, viewProperty.cover, cardIndex: cardNumber)
        case .square:
            CardView<SquareShape>(frame: frame, color: viewColor, viewProperty.cover, cardIndex: cardNumber)
        case .fill:
            CardView<FillShape>(frame: frame, color: viewColor, viewProperty.cover, cardIndex: cardNumber)
        case .emptyCircle:
            CardView<EmtyCircleShape>(frame: frame, color: viewColor, viewProperty.cover, cardIndex: cardNumber)
        }
        
        if let opacity = viewProperty.opacity {
            view.layer.opacity = opacity
        }
        if let originX = viewProperty.originX {
            view.frame.origin.x = originX
        }
        if let originY = viewProperty.originY {
            view.frame.origin.y = originY
        }
        if let isFlipped = viewProperty.isFlipped {
            view.isFlipped = isFlipped
        }
        
        return view
        
    }
    
    
    
//    func get(_ shape: CardType, withSize size: CGSize, andColor color: CardColor, and cover: CardCover) -> UIView {
//        // на основе размеров определяем фрейм
//        let frame = CGRect(origin: .zero, size: size)
//        // определяем UI-цвет на основе цвета модели
//        let viewColor = getViewColorBy(modelColor: color)
//        // генерируем и возвращаем карточку
//        switch shape {
//        case .circle:
//            return CardView<CircleShape>(frame: frame, color: viewColor, cover)
//        case .cross:
//            return CardView<CrossShape>(frame: frame, color: viewColor, cover)
//        case .square:
//            return CardView<SquareShape>(frame: frame, color: viewColor, cover)
//        case .fill:
//            return CardView<FillShape>(frame: frame, color: viewColor, cover)
//        case .emptyCircle:
//            return CardView<EmtyCircleShape>(frame: frame, color: viewColor, cover)
//        }
//    }
    
    func getSettingsChoiceView(_ shape : CardType, withSize size: CGSize, andColor color: CardColor, andCover cover: CardCover? = nil, settingType: Any) -> SettingsChoiceViewProtocol {
        let frame = CGRect(origin: .zero, size: size)
        let viewColor = getViewColorBy(modelColor: color)
        switch shape {
        case .circle:
            return SettingsChoiceView<CircleShape>(frame: frame, color: viewColor, settingType: settingType)
        case .cross:
            return SettingsChoiceView<CrossShape>(frame: frame, color: viewColor, settingType: settingType)
        case .square:
            return SettingsChoiceView<SquareShape>(frame: frame, color: viewColor, settingType: settingType)
        case .fill:
            return SettingsChoiceView<FillShape>(frame: frame, color: viewColor, cover, settingType: settingType)
        case .emptyCircle:
            return SettingsChoiceView<EmtyCircleShape>(frame: frame, color: viewColor, settingType: settingType)
        }
        
    }
    
    // преобразуем цвет Модели в цвет Представления
    private func getViewColorBy(modelColor: CardColor) -> UIColor {
        switch modelColor {
        case .black:
            return .black
        case .red:
            return .red
        case .green:
            return .green
        case .gray:
            return .gray
        case .brown:
            return .brown
        case .yellow:
            return .yellow
        case .purple:
            return .purple
        case .orange:
            return .orange
        }
    }
}
