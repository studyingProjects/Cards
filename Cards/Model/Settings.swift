//
//  Settings.swift
//  Cards
//
//  Created by Andrei Shpartou on 27/02/2024.
//

import Foundation

protocol SettingsStorageProtocol {
    var countOfCardPairs: Float { get set }
    var cardColors: [CardColor] { get set }
    var cardTypes: [CardType] { get set }
    var cardBackCovers: [CardCover] { get set }
}

class SettingsStorage: SettingsStorageProtocol {
    static let shared = SettingsStorage()
    private var storage = UserDefaults.standard
    
    enum SettingsKeys: String {
        case countOfCardPairs
        case cardColors
        case cardTypes
        case cardCovers
    }
    
    var countOfCardPairs: Float {
        get {
            return getSettingWithKey(.countOfCardPairs) as! Float
        }
        
        set {
            setSettingForKey(newValue, .countOfCardPairs)
        }
    }
    
    var cardColors: [CardColor] {
        get {
            return getSettingWithKey(.cardColors) as! [CardColor]
        }
        
        set {
            setSettingForKey(newValue, .cardColors)
        }
    }
    
    var cardTypes: [CardType] {
        get {
            return getSettingWithKey(.cardTypes) as! [CardType]
        }
        
        set {
            setSettingForKey(newValue, .cardTypes)
        }
    }
    
    var cardBackCovers: [CardCover] {
        get {
            return getSettingWithKey(.cardCovers) as! [CardCover]
        }
        
        set {
            setSettingForKey(newValue, .cardCovers)
        }
    }
    
    private init() {}
    // MARK: - Get settings with Key
    private func getSettingWithKey(_ key: SettingsKeys) -> Any {
        let value = storage.value(forKey: key.rawValue)
        
        switch key {
        case .countOfCardPairs:
            guard let castedValue = value as? Float else {
                return Float(8.0)
            }
            return castedValue
        case .cardColors:
            guard let castedDict = value as? [String: Bool] else {
                return CardColor.allCases
            }
            var arrayOfColors = [CardColor]()
            CardColor.allCases.forEach { cardColor in
                let isChosen = castedDict[cardColor.rawValue] ?? true
                if isChosen {
                    arrayOfColors.append(cardColor)
                }
            }
            return arrayOfColors
        case .cardTypes:
            guard let castedDict = value as? [String: Bool] else {
                return CardType.allCases
            }
            var arrayOfTypes = [CardType]()
            CardType.allCases.forEach { cardType in
                let isChosen = castedDict[cardType.rawValue] ?? true
                if isChosen {
                    arrayOfTypes.append(cardType)
                }
            }
            return arrayOfTypes
        case .cardCovers:
            guard let castedDict = value as? [String: Bool] else {
                return CardCover.allCases
            }
            var arrayOfCovers = [CardCover]()
            CardCover.allCases.forEach { cardCover in
                let isChosen = castedDict[cardCover.rawValue] ?? true
                if isChosen {
                    arrayOfCovers.append(cardCover)
                }
            }
            
            return arrayOfCovers
        }
    }
    
    private func setSettingForKey(_ value: Any, _ key: SettingsKeys) {
        storage.setValue(value, forKey: key.rawValue)
    }
}
