//
//  SettingsChoiceView.swift
//  Cards
//
//  Created by Andrei Shpartou on 01/03/2024.
//

import UIKit


enum SettingsChoiceViewTypes {
    case cardType
    case cardCover
    case cardColor
}

protocol SettingsChoiceViewProtocol: UIView {
    var choiceCompletionHandler: ((SettingsChoiceViewProtocol) -> Void)? { get set }
    var isChosen: Bool { get set }
    var settingType: SettingsChoiceViewTypes! { get set }
    
    func choose()
    func setupSubViews()
}

class SettingsChoiceView<ShapeType: ShapeLayerProtocol>: UIView, SettingsChoiceViewProtocol {
    var choiceCompletionHandler: ((SettingsChoiceViewProtocol) -> Void)?
    var isChosen: Bool = true {
        didSet {
            self.setNeedsDisplay()
        }
    }
    var settingType: SettingsChoiceViewTypes!
    
    private var color: UIColor!
    private var cover: CardCover?
    private let cornerRadius = 5
    private let margin: Int = 5
    lazy private var isChosenSideView: UIView = self.getChosenSideView()
    lazy private var isNotChoisenSideView: UIView = self.getNotChoisenSideView()
    
    init(frame: CGRect, color: UIColor, _ cover: CardCover? = nil, settingType: SettingsChoiceViewTypes) {
        super.init(frame: frame)
        self.color = color
        self.cover = cover
        self.settingType = settingType
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        choose()
    }
    
    override func draw(_ rect: CGRect) {
        // удаляем добавленные ранее дочерние представления
        isNotChoisenSideView.removeFromSuperview()
        isChosenSideView.removeFromSuperview()
        // добавляем новые представления
        setupSubViews()
    }
    
    func choose() {
        // определяем, между какими представлениями осуществить переход
        let fromView = isChosen ? isChosenSideView : isNotChoisenSideView
        let toView = isChosen ? isNotChoisenSideView : isChosenSideView
        // запускаем анимированный переход
        UIView.transition(from: fromView, to: toView, duration: 0, options:
                            [.transitionCrossDissolve], completion: { _ in
        })
        isChosen.toggle()
    }
    
    func setupSubViews() {
        if isChosen {
            addSubview(isNotChoisenSideView)
            addSubview(isChosenSideView)
            
            self.layer.borderWidth = 5
            self.layer.borderColor = UIColor.blue.cgColor
        } else {
            addSubview(isChosenSideView)
            addSubview(isNotChoisenSideView)
            
            self.layer.borderWidth = 2
            self.layer.borderColor = UIColor.black.cgColor
        }
        setupBorders()
    }
    
    private func getChosenSideView() -> UIView {
        //let view = getNotChoisenSideView()
        let view = self.isNotChoisenSideView
        // add bold border
        //view.layer.borderWidth = 5
        //view.layer.borderColor = UIColor.systemBlue.cgColor
        // check color equality
        //let fillCollor = (self.color == UIColor.green) ? UIColor.white.cgColor : UIColor.green.cgColor
        //let checkMarkLayer = CheckMark(size: view.frame.size, fillColor: fillCollor)
        //checkMarkLayer.backgroundColor = UIColor.white.cgColor
        //view.layer.addSublayer(checkMarkLayer)
        return view
    }
    
    private func getNotChoisenSideView() -> UIView {
        let view = UIView(frame: self.bounds)
        view.backgroundColor = .white
        let shapeView = UIView(frame: CGRect(x: margin, y: margin,
                                             width: Int(self.frame.width)-margin*2,
                                             height: Int(self.frame.height)-margin*2))
        view.addSubview(shapeView)
        var shapeLayer: ShapeLayerProtocol
        if let cover = self.cover {
            switch cover {
            case .circle:
                shapeLayer = BackSideCircle(size: self.bounds.size, fillColor: UIColor.black.cgColor)
            case .line:
                shapeLayer = BackSideLine(size: self.bounds.size, fillColor: UIColor.black.cgColor)
            }
        } else {
            shapeLayer = ShapeType(size: shapeView.frame.size, fillColor: self.color.cgColor)
        }
        shapeView.layer.addSublayer(shapeLayer)
        
        // скругляем углы корневого слоя
        view.layer.masksToBounds = true
        view.layer.cornerRadius = CGFloat(cornerRadius)
        
        return view
    }
    
    // настройка границ
    private func setupBorders() {
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(cornerRadius)
    }
    

}
