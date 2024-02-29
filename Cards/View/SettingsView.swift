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
    func updateNumberOfPairs(with value: Float)
}

class SettingsView: UIView {
    var delegate: SettingsViewDelegate?
    
    // MARK: - Number of pairs section
    private lazy var numberOfPairsView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private lazy var numberOfPairsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Количество пар одинаковых карт"
        
        return label
    }()
    
    private lazy var numberOfPairsSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 2
        slider.maximumValue = 14
        slider.tintColor = .systemOrange
        slider.isContinuous = true
        slider.addTarget(self, action: #selector(updateSliderLabel(_:)), for: .valueChanged)
        
        return slider
    }()
    
    private lazy var numberOfPairsResultLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.text = "8"
        
        return label
    }()
    
    
    // MARK: - Card types section
    private lazy var cardTypesView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private lazy var cardTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Типы фигур"
        
        return label
    }()
    // MARK: - Card colors section
    private lazy var cardColorsView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        
        return view
    }()
    // MARK: - back side shapes section
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
        numberOfPairsView.addSubview(numberOfPairsLabel)
        numberOfPairsView.addSubview(numberOfPairsSlider)
        numberOfPairsView.addSubview(numberOfPairsResultLabel)
        
        addSubview(cardTypesView)
        
        
        addSubview(cardColorsView)
        
        
        addSubview(backSideShapesView)
    }
    
    private func setupAppearance() {
        backgroundColor = .systemGray6
    }
    // MARK: - Action methods
    @objc private func updateSliderLabel(_ sender: UISlider) {
        let valueRounded = sender.value.rounded()
        sender.setValue(valueRounded, animated: false)
        numberOfPairsResultLabel.text = String(format: "%.0f", valueRounded)
        
        delegate?.setCountOfCard(valueRounded)
    }
}

// MARK: - Extensions
extension SettingsView: SettingsControllerDelegate {
    func setViewsSizes() {
        let commonPadding = 20.0
        let safeAreaTopPadding = self.safeAreaInsets.top
        let safeAreaBottomPadding = self.safeAreaInsets.bottom
        let commonViewWidth = self.frame.width - commonPadding * 2
        let commonViewHeight = (self.frame.height - safeAreaTopPadding - safeAreaBottomPadding) / 7
        
        let innerViewPadding = 10.0
        let innerlabelWidth = commonViewWidth - innerViewPadding * 2
        let innerlabelHeight = 25.0
        
        // Number of pairs
        numberOfPairsView.frame.size.width = commonViewWidth
        numberOfPairsView.frame.size.height = commonViewHeight
        numberOfPairsView.center.x = self.center.x
        numberOfPairsView.frame.origin.y = safeAreaTopPadding + commonPadding
        let centerNumberOfPairsView = numberOfPairsView.convert(numberOfPairsView.center, from: self)
        
        numberOfPairsLabel.frame.size.width = innerlabelWidth
        numberOfPairsLabel.frame.size.height = innerlabelHeight
        numberOfPairsLabel.center = centerNumberOfPairsView
        numberOfPairsLabel.frame.origin.y = innerViewPadding
        
        numberOfPairsSlider.frame.size.width = innerlabelWidth - commonPadding * 2
        numberOfPairsSlider.frame.size.height = innerlabelHeight
        numberOfPairsSlider.center.x = centerNumberOfPairsView.x
        numberOfPairsSlider.frame.origin.y = innerViewPadding * 2 + numberOfPairsLabel.frame.height
        
        numberOfPairsResultLabel.frame.size.width = innerlabelWidth
        numberOfPairsResultLabel.frame.size.height = innerlabelHeight
        numberOfPairsResultLabel.center.x = centerNumberOfPairsView.x
        numberOfPairsResultLabel.frame.origin.y = innerViewPadding * 3 + numberOfPairsSlider.frame.height + numberOfPairsLabel.frame.height
        
        
        // Card types
        cardTypesView.frame.size.width = commonViewWidth
        cardTypesView.frame.size.height = commonViewHeight
        cardTypesView.center.x = self.center.x
        cardTypesView.frame.origin.y = numberOfPairsView.frame.maxY + commonPadding
        
        // Card colors
        cardColorsView.frame.size.width = commonViewWidth
        cardColorsView.frame.size.height = commonViewHeight
        cardColorsView.center.x = self.center.x
        cardColorsView.frame.origin.y = cardTypesView.frame.maxY + commonPadding
        
        // Back side shapes
        backSideShapesView.frame.size.width = commonViewWidth
        backSideShapesView.frame.size.height = commonViewHeight
        backSideShapesView.center.x = self.center.x
        backSideShapesView.frame.origin.y = cardColorsView.frame.maxY + commonPadding
    }
    // MARK: - Update through settings
    func updateNumberOfPairs(with value: Float) {
        numberOfPairsSlider.value = value
        numberOfPairsResultLabel.text = String(format: "%.0f", value)
    }
    
    
}
