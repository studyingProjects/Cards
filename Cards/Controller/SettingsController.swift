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
    // MARK: - Load settings
    private func loadSettings() {
        self.delegate?.updateNumberOfPairs(with: storage.countOfCardPairs)
        
        let viewFactory = CardViewFactory()
        let size = CGSize(width: 50, height: 50)
        // Card Colors
        var arrayOfColors: [UIView] = []
        let storedColors = storage.cardColors
        CardColor.allCases.forEach { cardColor in
            let cardColorChoiceView = viewFactory.getSettingsChoiceView(
                .fill,
                withSize: size,
                andColor: cardColor,
                settingType: .cardColor)
            
            if !storedColors.contains(cardColor) {
                cardColorChoiceView.isChosen = false
            }
            
            arrayOfColors.append(cardColorChoiceView)
        }
        self.delegate?.updateCardColors(with: arrayOfColors)
        
        // Card types
        var arrayOfTypes: [UIView] = []
        let storedTypes = storage.cardTypes
        CardType.allCases.forEach { cardType in
            let cardTypeChoiceView = viewFactory.getSettingsChoiceView(
                cardType,
                withSize: size,
                andColor: .black,
                settingType: .cardType)
            
            if !storedTypes.contains(cardType) {
                cardTypeChoiceView.isChosen = false
            }
            
            arrayOfTypes.append(cardTypeChoiceView)
        }
        self.delegate?.updateCardTypes(with: arrayOfTypes)
    
        // Card covers
        var arrayOfCovers: [UIView] = []
        let storedCovers = storage.cardBackCovers
        CardCover.allCases.forEach { cardCover in
            let cardCoverChoiceView = viewFactory.getSettingsChoiceView(
                .fill,
                withSize: size,
                andColor: .black,
                andCover: cardCover,
                settingType: .cardCover)
            
            if !storedCovers.contains(cardCover) {
                cardCoverChoiceView.isChosen = false
            }
            
            arrayOfCovers.append(cardCoverChoiceView)
        }
        delegate?.updateCardCovers(with: arrayOfCovers)
    }
    
}
// MARK: - Extensions
extension SettingsController: SettingsViewDelegate {
    func setCountOfCard(_ newValue: Float) {
        storage.countOfCardPairs = newValue
    }
    
}
