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
    var cards: [Card] { get set }
    var flipsCount: Int { get set }
}

class SettingsStorage: SettingsStorageProtocol {
    static let shared = SettingsStorage()
    private var storage = UserDefaults.standard
    
    enum SettingsKeys: String {
        case countOfCardPairs
        case cardColors
        case cardTypes
        case cardCovers
        case cards
        case flipsCount
    }
    
    var flipsCount: Int {
        get {
            return getSettingWithKey(.flipsCount) as! Int
        }
        
        set {
            setSettingForKey(newValue, .flipsCount)
        }
    }
    
    var countOfCardPairs: Float {
        get {
            return getSettingWithKey(.countOfCardPairs) as! Float
        }
        
        set {
            setSettingForKey(newValue, .countOfCardPairs)
        }
    }
    
    var cards: [Card] {
        get {
            guard let data = UserDefaults.standard.data(forKey: SettingsKeys.cards.rawValue) else {
                return [Card]()
            }
            
            let decoder = JSONDecoder()
            if let decodedCards = try? decoder.decode(Array.self, from: data) as [Card] {
                return decodedCards
            } else {
                print("get card error")
            }
            
            return [Card]()
        }
        
        set {
            do {
                let cards = newValue
                let encoder = JSONEncoder()
                let data = try encoder.encode(cards)
                storage.set(data, forKey: SettingsKeys.cards.rawValue)
            } catch {
                print("save cards error")
            }
        }
    }
    
    
//    guard let data = UserDefaults.standard.data(forKey: "person") else {
//        return
//    }do {
//        let decoder = JSONDecoder()
//        let person = try decoder.decode(Person.self, from: data)
//    } catch {
//        // Fallback
//    }
    
//    static func saveAllObjects(allObjects: [MyObject]) {
//          let encoder = JSONEncoder()
//          if let encoded = try? encoder.encode(allObjects){
//             UserDefaults.standard.set(encoded, forKey: "user_objects")
//          }
//     }
    
    var cardColors: [CardColor] {
        get {
            return getSettingWithKey(.cardColors) as! [CardColor]
        }
        
        set {
            var newDict: [String: Bool] = [:]
            newValue.forEach { value in
                newDict[value.rawValue] = false
            }
            setSettingForKey(newDict, .cardColors)
        }
    }
    
    var cardTypes: [CardType] {
        get {
            return getSettingWithKey(.cardTypes) as! [CardType]
        }
        
        set {
            var newDict: [String: Bool] = [:]
            newValue.forEach { value in
                newDict[value.rawValue] = false
            }
            setSettingForKey(newDict, .cardTypes)
        }
    }
    
    var cardBackCovers: [CardCover] {
        get {
            return getSettingWithKey(.cardCovers) as! [CardCover]
        }
        
        set {
            var newDict: [String: Bool] = [:]
            newValue.forEach { value in
                newDict[value.rawValue] = false
            }
            setSettingForKey(newDict, .cardCovers)
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
        case .cards:
            return [Card]()
        case .flipsCount:
            guard let castedValue = value as? Int else {
                return 0
            }
            return castedValue
        }
    }
    
    private func setSettingForKey(_ value: Any, _ key: SettingsKeys) {
        storage.setValue(value, forKey: key.rawValue)
    }
}
