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
    func updateCardColors(with array: [UIView])
    func updateCardTypes(with array: [UIView])
    func updateCardCovers(with array: [UIView])
}
// MARK: - CardSettingStackView
class CardSettingsStackView: UIStackView {
    override func layoutSubviews() {
        super.layoutSubviews()
        arrangedSubviews.forEach { view in
            if let settingsChoiceView = view as? SettingsChoiceViewProtocol {
                settingsChoiceView.setupSubViews()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .horizontal
        self.spacing = 10.0
        self.distribution = .fillEqually
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
        
        return label
    }()
    // MARK: - Card colors section
    private lazy var cardColorsView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private lazy var cardColorsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Используемые цвета"
        
        return label
    }()
    
    private lazy var cardColorsStackView = CardSettingsStackView()
    
    // MARK: - Card types section
    private lazy var cardTypesView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private lazy var cardTypesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Типы фигур"
        
        return label
    }()
    
    private lazy var cardTypesStackView = CardSettingsStackView()
    
    // MARK: - Back side shapes section
    private lazy var backSideShapesView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private lazy var backSideShapeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Обложки карт"
        
        return label
    }()
    
    private lazy var backSideShapeStackView = CardSettingsStackView()
    
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
        
        addSubview(cardColorsView)
        cardColorsView.addSubview(cardColorsLabel)
        cardColorsView.addSubview(cardColorsStackView)
        
        addSubview(cardTypesView)
        cardTypesView.addSubview(cardTypesLabel)
        cardTypesView.addSubview(cardTypesStackView)

        addSubview(backSideShapesView)
        backSideShapesView.addSubview(backSideShapeLabel)
        backSideShapesView.addSubview(backSideShapeStackView)
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
        
        // MARK: - Number of Pairs sizes
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
        
        // MARK: - Card colors sizes
        cardColorsView.frame.size.width = commonViewWidth
        cardColorsView.frame.size.height = commonViewHeight
        cardColorsView.center.x = self.center.x
        cardColorsView.frame.origin.y = numberOfPairsView.frame.maxY + commonPadding
        
        cardColorsLabel.frame.size.width = innerlabelWidth
        cardColorsLabel.frame.size.height = innerlabelHeight
        cardColorsLabel.center = cardColorsView.convert(cardColorsView.center, from: self)
        cardColorsLabel.frame.origin.y = innerViewPadding
        
        cardColorsStackView.frame.size.width = innerlabelWidth
        cardColorsStackView.frame.size.height = innerlabelHeight * 2
        cardColorsStackView.center = cardColorsLabel.center
        cardColorsStackView.frame.origin.y = cardColorsLabel.frame.maxY + innerViewPadding
        
        //colorView.backgroundColor = .blue
        
        // MARK: - Card types sizes
        cardTypesView.frame.size.width = commonViewWidth
        cardTypesView.frame.size.height = commonViewHeight
        cardTypesView.center.x = self.center.x
        cardTypesView.frame.origin.y = cardColorsView.frame.maxY + commonPadding
        
        cardTypesLabel.frame.size.width = innerlabelWidth
        cardTypesLabel.frame.size.height = innerlabelHeight
        cardTypesLabel.center = cardTypesView.convert(cardTypesView.center, from: self)
        cardTypesLabel.frame.origin.y = innerViewPadding
        
        cardTypesStackView.frame.size.width = innerlabelWidth
        cardTypesStackView.frame.size.height = innerlabelHeight * 2
        cardTypesStackView.center = cardTypesLabel.center
        cardTypesStackView.frame.origin.y = cardTypesLabel.frame.maxY + innerViewPadding
        
        // MARK: - Back side shapes sizes
        backSideShapesView.frame.size.width = commonViewWidth
        backSideShapesView.frame.size.height = commonViewHeight
        backSideShapesView.center.x = self.center.x
        backSideShapesView.frame.origin.y = cardTypesView.frame.maxY + commonPadding
        
        backSideShapeLabel.frame.size.width = innerlabelWidth
        backSideShapeLabel.frame.size.height = innerlabelHeight
        backSideShapeLabel.center = backSideShapesView.convert(backSideShapesView.center, from: self)
        backSideShapeLabel.frame.origin.y = innerViewPadding
        
        backSideShapeStackView.frame.size.width = innerlabelWidth
        backSideShapeStackView.frame.size.height = innerlabelHeight * 2
        backSideShapeStackView.center = backSideShapeLabel.center
        backSideShapeStackView.frame.origin.y = backSideShapeLabel.frame.maxY + innerViewPadding
        
    }
    // MARK: - Update through settings
    func updateNumberOfPairs(with value: Float) {
        numberOfPairsSlider.value = value
        numberOfPairsResultLabel.text = String(format: "%.0f", value)
    }
    
    func updateCardColors(with array: [UIView]) {
        array.forEach { colorView in
            cardColorsStackView.addArrangedSubview(colorView)
        }
    }
    
    func updateCardTypes(with array: [UIView]) {
        array.forEach { cardTypeView in
            cardTypesStackView.addArrangedSubview(cardTypeView)
        }
    }
    
    func updateCardCovers(with array: [UIView]) {
        array.forEach { cardCoverView in
            backSideShapeStackView.addArrangedSubview(cardCoverView)
        }
    }
    
    
}
