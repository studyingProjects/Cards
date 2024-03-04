//
//  Cards.swift
//  Cards
//
//  Created by Andrei Shpartou on 23/02/2024.
//

import UIKit

protocol FlippableView: UIView {
    var isFlipped: Bool { get set }
    var handleFlip: Bool { get set }
    var flipCompletionHandler: ((FlippableView) -> Void)? { get set }
    func flip()
}
// MARK: - Generic class CardView
class CardView<ShapeType: ShapeLayerProtocol>: UIView, FlippableView {
    
    var isFlipped: Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
    var handleFlip: Bool = true
    // цвет фигуры
    var color: UIColor!
    var cover: CardCover!
    var flipCompletionHandler: ((FlippableView) -> Void)?
    // внутренний отступ представления
    private let margin: Int = 10
    // представление с лицевой стороной карты
    lazy var frontSideView: UIView = self.getFrontSideView()
    // представление с обратной стороной карты
    lazy var backSideView: UIView = self.getBackSideView()
    // радиус закругления
    var cornerRadius = 20
    // точка привязки
    private var anchorDefaultPoint: CGPoint = CGPoint(x: 0, y: 0)
    private var startTouchPoint: CGPoint!
    
    
    init(frame: CGRect, color: UIColor, _ cover: CardCover) {
        super.init(frame: frame)
        self.color = color
        self.cover = cover
        
        if isFlipped {
            self.addSubview(backSideView)
            self.addSubview(frontSideView)
        } else {
            self.addSubview(frontSideView)
            self.addSubview(backSideView)
        }
        setupBorders()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        anchorDefaultPoint.x = touches.first!.location(in: window).x - frame.minX
        anchorDefaultPoint.y = touches.first!.location(in: window).y - frame.minY
        
        // сохраняем исходные координаты
        startTouchPoint = frame.origin
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let newPointMinX = touches.first!.location(in: window).x - anchorDefaultPoint.x
        let newPointMinY = touches.first!.location(in: window).y - anchorDefaultPoint.y
        let newPointMaxX = newPointMinX + bounds.width
        let newPointMaxY = newPointMinY + bounds.height
        
        let superViewWidth = superview?.bounds.width ?? 0
        let superViewHeight = superview?.bounds.height ?? 0
        
        if newPointMinX < 0
            || newPointMinY < 0
            || newPointMaxX > superViewWidth
            || newPointMaxY > superViewHeight {
            return
        }
        
        self.frame.origin.x = newPointMinX
        self.frame.origin.y = newPointMinY
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        // анимировано возвращаем карточку в исходную позицию
//        UIView.animate(withDuration: 0.5) {
//            self.frame.origin = self.startTouchPoint
//
//            // переворачиваем представление
//            if self.transform.isIdentity {
//                self.transform = CGAffineTransform(rotationAngle: .pi)
//            } else {
//                self.transform = .identity
//            }
//        }
        if self.frame.origin == startTouchPoint {
            handleFlip = true
            flip()
        }
    }
    
    override func draw(_ rect: CGRect) {
        // удаляем добавленные ранее дочерние представления
        backSideView.removeFromSuperview()
        frontSideView.removeFromSuperview()
        // добавляем новые представления
        if isFlipped {
            self.addSubview(backSideView)
            self.addSubview(frontSideView)
        } else {
            self.addSubview(frontSideView)
            self.addSubview(backSideView)
        }
    }
    
    // настройка границ
    private func setupBorders() {
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
    }
    // MARK: -  Flip
    func flip() {
        // определяем, между какими представлениями осуществить переход
        let fromView = isFlipped ? frontSideView : backSideView
        let toView = isFlipped ? backSideView : frontSideView
        // запускаем анимированный переход
        UIView.transition(from: fromView, to: toView, duration: 0.5, options:
                            [.transitionFlipFromTop], completion: { _ in
            // обработчик переворота
            self.flipCompletionHandler?(self)
        })
        isFlipped.toggle() //isFlipped = !isFlipped
    }
    // MARK: - Front/Back Side Views
    // возвращает представление для лицевой стороны карточки
    private func getFrontSideView() -> UIView {
        let view = UIView(frame: self.bounds)
        view.backgroundColor = .white
        let shapeView = UIView(frame: CGRect(x: margin, y: margin,
                                             width: Int(self.bounds.width)-margin*2,
                                             height: Int(self.bounds.height)-margin*2))
        view.addSubview(shapeView)
        // создание слоя с фигурой
        let shapeLayer = ShapeType(size: shapeView.frame.size, fillColor: color.cgColor)
        shapeView.layer.addSublayer(shapeLayer)
        
        // скругляем углы корневого слоя
        view.layer.masksToBounds = true
        view.layer.cornerRadius = CGFloat(cornerRadius)
        
        return view
    }
    
    // возвращает вью для обратной стороны карточки
    private func getBackSideView() -> UIView {
        let view = UIView(frame: self.bounds)
        view.backgroundColor = .white
        //выбор случайного узора для рубашки
        switch self.cover {
        case .circle:
            let layer = BackSideCircle(size: self.bounds.size, fillColor: UIColor.black.cgColor)
            view.layer.addSublayer(layer)
        case .line:
            let layer = BackSideLine(size: self.bounds.size, fillColor: UIColor.black.cgColor)
            view.layer.addSublayer(layer)
        default:
            break
        }
        
        // скругляем углы корневого слоя
        view.layer.masksToBounds = true
        view.layer.cornerRadius = CGFloat(cornerRadius)
        
        return view
    }
}
