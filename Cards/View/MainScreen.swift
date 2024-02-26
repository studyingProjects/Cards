//
//  MainScreen.swift
//  Cards
//
//  Created by Andrei Shpartou on 26/02/2024.
//

import UIKit

class MainScreenView: UIView {
    // MARK: - Properties
    lazy var startGameButton: UIButton = {
        
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
    }
    
    private func setupAppearance() {
        backgroundColor = #colorLiteral(red: 0, green: 0.568627451, blue: 0.5764705882, alpha: 1)   
    }
    
    func setViewsSizes() {
        let safeAreaPadding = self.safeAreaInsets.top
        let viewHeight = self.frame.height
        
        startGameButton.center.x = self.center.x
        startGameButton.frame.origin.y = safeAreaPadding + viewHeight / 5
    }
    
}
