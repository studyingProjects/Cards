//
//  SettingsView.swift
//  Cards
//
//  Created by Andrei Shpartou on 27/02/2024.
//

import UIKit

// MARK: - Protocols
protocol SettingsControllerDelegate {
    func setViewsSizes()
}

class SettingsView: UIView {

    // MARK: - View properties
    private lazy var numberOfPairsView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var cardTypesView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var cardColorsView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var backSideShapesView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    private func setupView() {
        setupAppearance()
        addSubview(numberOfPairsView)
        addSubview(cardTypesView)
        addSubview(cardColorsView)
        addSubview(backSideShapesView)
    }
    
    private func setupAppearance() {
        backgroundColor = .systemGray6
    }
    // MARK: - Action methods
}

// MARK: - Extensions
extension SettingsView: SettingsControllerDelegate {
    
    func setViewsSizes() {
        let commonPadding = 20.0
        let safeAreaTopPadding = self.safeAreaInsets.top
        let safeAreaBottomPadding = self.safeAreaInsets.bottom
        let commonViewWidth = self.frame.width - commonPadding * 2
        let commonViewHeight = (self.frame.height - safeAreaTopPadding - safeAreaBottomPadding) / 7
        
        numberOfPairsView.frame.size.width = commonViewWidth
        numberOfPairsView.frame.size.height = commonViewHeight
        numberOfPairsView.center.x = self.center.x
        numberOfPairsView.frame.origin.y = safeAreaTopPadding + commonPadding
        
        cardTypesView.frame.size.width = commonViewWidth
        cardTypesView.frame.size.height = commonViewHeight
        cardTypesView.center.x = self.center.x
        cardTypesView.frame.origin.y = numberOfPairsView.frame.maxY + commonPadding
        
        cardColorsView.frame.size.width = commonViewWidth
        cardColorsView.frame.size.height = commonViewHeight
        cardColorsView.center.x = self.center.x
        cardColorsView.frame.origin.y = cardTypesView.frame.maxY + commonPadding
        
        backSideShapesView.frame.size.width = commonViewWidth
        backSideShapesView.frame.size.height = commonViewHeight
        backSideShapesView.center.x = self.center.x
        backSideShapesView.frame.origin.y = cardColorsView.frame.maxY + commonPadding

    }
}
