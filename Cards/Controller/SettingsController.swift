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
    }
    
}

extension SettingsController: SettingsViewDelegate {
    func setCountOfCard(_ newValue: Float) {
        storage.countOfCardPairs = newValue
    }
    
    
    
}
