//
//  CardViewFactory.swift
//  Cards
//
//  Created by Andrei Shpartou on 24/02/2024.
//

import UIKit

class CardViewFactory {
    
    func get(_ shape: CardType, withSize size: CGSize, andColor color: CardColor, and cover: CardCover) -> UIView {
        // на основе размеров определяем фрейм
        let frame = CGRect(origin: .zero, size: size)
        // определяем UI-цвет на основе цвета модели
        let viewColor = getViewColorBy(modelColor: color)
        // генерируем и возвращаем карточку
        switch shape {
        case .circle:
            return CardView<CircleShape>(frame: frame, color: viewColor, cover)
        case .cross:
            return CardView<CrossShape>(frame: frame, color: viewColor, cover)
        case .square:
            return CardView<SquareShape>(frame: frame, color: viewColor, cover)
        case .fill:
            return CardView<FillShape>(frame: frame, color: viewColor, cover)
        case .emptyCircle:
            return CardView<EmtyCircleShape>(frame: frame, color: viewColor, cover)
        }
    }
    
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
