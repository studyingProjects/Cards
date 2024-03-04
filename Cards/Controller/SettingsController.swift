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
    
    private func loadSettings() {
        self.delegate?.updateNumberOfPairs(with: storage.countOfCardPairs)
        
        // Card Colors
        var arrayOfColors: [UIView] = []
        arrayOfColors.append(CardViewFactory().getSettingsChoiceView(.fill, withSize: CGSize(width: 40, height: 40), andColor: .red))
        arrayOfColors.append(CardViewFactory().getSettingsChoiceView(.fill, withSize: CGSize(width: 40, height: 40), andColor: .green))
        arrayOfColors.append(CardViewFactory().getSettingsChoiceView(.fill, withSize: CGSize(width: 40, height: 40), andColor: .black))
        arrayOfColors.append(CardViewFactory().getSettingsChoiceView(.fill, withSize: CGSize(width: 40, height: 40), andColor: .gray))
        arrayOfColors.append(CardViewFactory().getSettingsChoiceView(.fill, withSize: CGSize(width: 40, height: 40), andColor: .brown))
        arrayOfColors.append(CardViewFactory().getSettingsChoiceView(.fill, withSize: CGSize(width: 40, height: 40), andColor: .yellow))
        arrayOfColors.append(CardViewFactory().getSettingsChoiceView(.fill, withSize: CGSize(width: 40, height: 40), andColor: .purple))
        arrayOfColors.append(CardViewFactory().getSettingsChoiceView(.fill, withSize: CGSize(width: 40, height: 40), andColor: .orange))
        self.delegate?.updateCardColors(with: arrayOfColors)
        
        // card types
        var arrayOfTypes: [UIView] = []
        arrayOfTypes.append(CardViewFactory().getSettingsChoiceView(.square, withSize: CGSize(width: 50, height: 50), andColor: .black))
        arrayOfTypes.append(CardViewFactory().getSettingsChoiceView(.circle, withSize: CGSize(width: 50, height: 50), andColor: .black))
        arrayOfTypes.append(CardViewFactory().getSettingsChoiceView(.cross, withSize: CGSize(width: 50, height: 50), andColor: .black))
        arrayOfTypes.append(CardViewFactory().getSettingsChoiceView(.emptyCircle, withSize: CGSize(width: 50, height: 50), andColor: .black))
        arrayOfTypes.append(CardViewFactory().getSettingsChoiceView(.fill, withSize: CGSize(width: 50, height: 50), andColor: .black))
        self.delegate?.updateCardTypes(with: arrayOfTypes)
    
        // card covers
        var arrayOfCovers: [UIView] = []
        arrayOfCovers.append(CardViewFactory().getSettingsChoiceView(.fill, withSize: CGSize(width: 40, height: 40), andColor: .orange, andCover: CardCover.line))
        arrayOfCovers.append(CardViewFactory().getSettingsChoiceView(.fill, withSize: CGSize(width: 40, height: 40), andColor: .orange, andCover: CardCover.circle))
        delegate?.updateCardCovers(with: arrayOfCovers)
    }
    
}

extension SettingsController: SettingsViewDelegate {
    func setCountOfCard(_ newValue: Float) {
        storage.countOfCardPairs = newValue
    }
    
}
