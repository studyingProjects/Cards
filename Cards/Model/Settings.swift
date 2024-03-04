//
//  Settings.swift
//  Cards
//
//  Created by Andrei Shpartou on 27/02/2024.
//

import Foundation

protocol SettingsStorageProtocol {
    var countOfCardPairs: Float { get set }
}

enum SettingsChoiceViewTypes {
    
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
    
    private func getSettingWithKey(_ key: SettingsKeys) -> Any {
        let value = storage.value(forKey: key.rawValue)
        
        switch key {
        case .countOfCardPairs:
            guard let castedValue = value as? Float else {
                return Float(8.0)
            }
            return castedValue
        case .cardColors:
            return [CardColor.black, CardColor.green, CardColor.orange]
        case .cardTypes:
            return [CardType.cross, CardType.circle, CardType.fill]
        case .cardCovers:
            return [CardCover.line]
        }
    }
    
    private func setSettingForKey(_ value: Any, _ key: SettingsKeys) {
        storage.setValue(value, forKey: key.rawValue)
    }
}
