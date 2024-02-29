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

class SettingsStorage: SettingsStorageProtocol {
    static let shared = SettingsStorage()
    private var storage = UserDefaults.standard
    
    enum SettingsKeys: String {
        case countOfCardPairs
    }
    
    var countOfCardPairs: Float {
        get {
            return getSettingWithKey(.countOfCardPairs) as! Float
        }
        
        set {
            setSettingForKey(newValue, .countOfCardPairs)
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
        }
    }
    
    private func setSettingForKey(_ value: Any, _ key: SettingsKeys) {
        storage.setValue(value, forKey: key.rawValue)
    }
}
