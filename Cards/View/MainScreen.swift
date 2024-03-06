//
//  MainScreen.swift
//  Cards
//
//  Created by Andrei Shpartou on 26/02/2024.
//

import UIKit

protocol MainScreenControllerDelegate {
    func setViewsSizes()
}

class MainScreenView: UIView {
    
    // MARK: - Properties
    var delegate: MainScreenViewDelegate?
    private lazy var startGameButton: UIButton = {
        
        //        guard let windowsScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
        //              let window = windowsScene.windows.first else {
        //            return UIButton()
        //        }
        
        //let safeAreaPadding = self.safeAreaInsets.top //window.safeAreaInsets.top
        //let windowHeight = self.frame.height //window.frame.height
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 160, height: 50))
        //button.frame.origin.y = safeAreaPadding + windowHeight / 4
        //button.center.x = self.center.x
        
        button.setTitle("Новая игра", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.systemGray4, for: .highlighted)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 10
        
        button.addTarget(self, action: #selector(startNewGame(_:)), for: .touchUpInside)
        
        return button
        
    }()
    private lazy var settingsButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 160, height: 50))
        button.setTitle("Настройки", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.systemGray4, for: .highlighted)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 10
        
        button.addTarget(self, action: #selector(goToSettings(_:)), for: .touchUpInside)
        
        return button
    }()
    private lazy var continueButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 160, height: 50))
        button.setTitle("Продолжить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.systemGray4, for: .highlighted)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 10
        
        button.addTarget(self, action: #selector(continueGame(_:)), for: .touchUpInside)
        
        return button
    }()
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupView() {
        setupAppearance()
        addSubview(startGameButton)
        addSubview(settingsButton)
        addSubview(continueButton)
    }
    
    private func setupAppearance() {
        backgroundColor = #colorLiteral(red: 0, green: 0.568627451, blue: 0.5764705882, alpha: 1)   
    }

    // MARK: - Actions
    @objc func startNewGame(_ sender: UIButton) {
        delegate?.startNewGame(sender)
    }
    
    @objc func goToSettings(_ sender: UIButton) {
        delegate?.goToSettings(sender)
    }
    
    @objc func continueGame(_ sender: UIButton) {
        delegate?.continueGame(sender)
    }
    
}

extension MainScreenView: MainScreenControllerDelegate {
    func setViewsSizes() {
        let safeAreaPadding = self.safeAreaInsets.top
        let viewHeight = self.frame.height
        let commonPadding = 20.0
        
        startGameButton.center.x = self.center.x
        startGameButton.frame.origin.y = safeAreaPadding + viewHeight / 5
        
        settingsButton.center.x = self.center.x
        settingsButton.frame.origin.y = startGameButton.frame.origin.y + startGameButton.frame.height + commonPadding
        
        continueButton.center.x = self.center.x
        continueButton.frame.origin.y = settingsButton.frame.origin.y + settingsButton.frame.height + commonPadding
        
    }
}
