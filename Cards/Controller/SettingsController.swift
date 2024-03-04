//
//  SettingsController.swift
//  Cards
//
//  Created by Andrei Shpartou on 27/02/2024.
//

import UIKit

protocol SettingsViewDelegate {
    func setCountOfCard(_ newValue: Float)
}

class SettingsController: UIViewController {

    private var settingsView: SettingsView!
    private var storage: SettingsStorageProtocol!
    private var arrayOfColors: [SettingsChoiceViewProtocol] = []
    private var arrayOfTypes: [SettingsChoiceViewProtocol] = []
    private var arrayOfCovers: [SettingsChoiceViewProtocol] = []
    
    var delegate: SettingsControllerDelegate?
    // MARK: - Lifecycle
    override func loadView() {
        settingsView = SettingsView()
        settingsView.delegate = self
        self.view = settingsView
        self.delegate = settingsView
        storage = SettingsStorage.shared
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSettings()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.delegate?.setViewsSizes()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        let colorViewsToStore = arrayOfColors.filter{ $0.isChosen == false }
        var colorsToStore: [CardColor] = []
        colorViewsToStore.forEach { view in
            colorsToStore.append(view.settingType as! CardColor)
            //colorsToStore.append(getViewColorBy(color: view.color))
        }
        storage.cardColors = colorsToStore
        
        let cardTypesViewsToStore = arrayOfTypes.filter { $0.isChosen == false }
        var typesToStore: [CardType] = []
        cardTypesViewsToStore.forEach { view in
            typesToStore.append(view.settingType as! CardType)
        }
        storage.cardTypes = typesToStore
        
        let cardCoversViewsToStore = arrayOfCovers.filter{ $0.isChosen == false }
        var coversToStore: [CardCover] = []
        cardCoversViewsToStore.forEach { view in
            coversToStore.append(view.settingType as! CardCover)
        }
        storage.cardBackCovers = coversToStore
        
        
    }
    // MARK: - Load settings
    private func loadSettings() {
        self.delegate?.updateNumberOfPairs(with: storage.countOfCardPairs)
        
        let viewFactory = CardViewFactory()
        let size = CGSize(width: 50, height: 50)
        // Card Colors
        let storedColors = storage.cardColors
        CardColor.allCases.forEach { cardColor in
            let cardColorChoiceView = viewFactory.getSettingsChoiceView(
                .fill,
                withSize: size,
                andColor: cardColor,
                settingType: cardColor)
            
            if !storedColors.contains(cardColor) {
                cardColorChoiceView.isChosen = false
            }
            
            arrayOfColors.append(cardColorChoiceView)
        }
        self.delegate?.updateCardColors(with: arrayOfColors)
        
        // Card types
        let storedTypes = storage.cardTypes
        CardType.allCases.forEach { cardType in
            let cardTypeChoiceView = viewFactory.getSettingsChoiceView(
                cardType,
                withSize: size,
                andColor: .black,
                settingType: cardType)
            
            if !storedTypes.contains(cardType) {
                cardTypeChoiceView.isChosen = false
            }
            
            arrayOfTypes.append(cardTypeChoiceView)
        }
        self.delegate?.updateCardTypes(with: arrayOfTypes)
    
        // Card covers
        let storedCovers = storage.cardBackCovers
        CardCover.allCases.forEach { cardCover in
            let cardCoverChoiceView = viewFactory.getSettingsChoiceView(
                .fill,
                withSize: size,
                andColor: .black,
                andCover: cardCover,
                settingType: cardCover)
            
            if !storedCovers.contains(cardCover) {
                cardCoverChoiceView.isChosen = false
            }
            
            arrayOfCovers.append(cardCoverChoiceView)
        }
        delegate?.updateCardCovers(with: arrayOfCovers)
    }

//    // преобразуем UIColor в CardColor
//    private func getViewColorBy(color: UIColor) -> CardColor {
//        
//        switch color {
//        case .black:
//            return .black
//        case .red:
//            return .red
//        case .green:
//            return .green
//        case .gray:
//            return .gray
//        case .brown:
//            return .brown
//        case .yellow:
//            return .yellow
//        case .purple:
//            return .purple
//        case .orange:
//            return .orange
//        default:
//            return CardColor.black
//        }
// 
//    }
    
}


// MARK: - Extensions
extension SettingsController: SettingsViewDelegate {
    func setCountOfCard(_ newValue: Float) {
        storage.countOfCardPairs = newValue
    }
    
}
