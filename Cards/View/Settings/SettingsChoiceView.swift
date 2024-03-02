//
//  SettingsChoiceView.swift
//  Cards
//
//  Created by Andrei Shpartou on 01/03/2024.
//

import UIKit

protocol SettingsChoiceViewProtocol: UIView {
    var choiceCompletionHandler: ((SettingsChoiceViewProtocol) -> Void)? { get set }
    var isChosen: Bool { get set }
    
    func choose()
}

class SettingsChoiceView<ShapeType: ShapeLayerProtocol>: UIView, SettingsChoiceViewProtocol {
    
    var choiceCompletionHandler: ((SettingsChoiceViewProtocol) -> Void)?
    var isChosen: Bool = true {
        didSet {
            self.setNeedsDisplay()
        }
    }
    private var color: UIColor!
    lazy private var isChosenSideView: UIView = self.getChosenSideView()
    lazy private var isNotChoisenSideView: UIView = self.getNotChoisenSideView()
    
    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        self.color = color
        
        if isChosen {
            addSubview(isNotChoisenSideView)
            addSubview(isChosenSideView)
        } else {
            addSubview(isChosenSideView)
            addSubview(isNotChoisenSideView)
        }
        
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
        if isChosen {
            self.addSubview(isNotChoisenSideView)
            self.addSubview(isChosenSideView)
        } else {
            self.addSubview(isChosenSideView)
            self.addSubview(isNotChoisenSideView)
        }
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
    
    private func getChosenSideView() -> UIView {
        let view = getNotChoisenSideView()
        // add bold border
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.systemBlue.cgColor
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
        let shapeLayer = ShapeType(size: view.frame.size, fillColor: self.color.cgColor)
        view.layer.addSublayer(shapeLayer)
        
        return view
    }
    

}
