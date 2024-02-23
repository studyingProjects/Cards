//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {

    override func loadView() {
        setupViews()
    }
 
    // настройка представлений сцены
    private func setupViews() {
        self.view = getRootView()
        
        let redView = getRedView()
        let greenView = getGreenView()
        let whiteView = getWhiteView()
        let pinkView = getPinkView()
        
        // поворот красного представления
        redView.transform = CGAffineTransform(rotationAngle: .pi / 3)
        
        set(view: greenView, toCenterOfView: redView)
        //set(view: whiteView, toCenterOfView: redView)
        // позиционируем белое представление с помощью свойства center
        whiteView.center = greenView.center
        
        self.view.addSubview(redView)
        self.view.addSubview(pinkView)
        redView.addSubview(greenView)
        redView.addSubview(whiteView)
    }
    // создание корневого представления
    private func getRootView() -> UIView {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }
    
    private func getRedView() -> UIView {
        let viewFrame = CGRect(x: 50, y: 50, width: 200, height: 200)
        let view = UIView(frame: viewFrame)
        view.backgroundColor = .red
        view.clipsToBounds = true
        return view
    }
    
    private func getGreenView() -> UIView {
        let viewFrame = CGRect(x: 50, y: 50, width: 100, height: 100)
        let view = UIView(frame: viewFrame)
        view.backgroundColor = UIColor.green
        return view
    }
    
    // создание представления белого цвета
    private func getWhiteView() -> UIView {
        let viewFrame = CGRect(x: 0, y: 0, width: 50, height: 50)
        let view = UIView(frame: viewFrame)
        view.backgroundColor = .white
        return view
    }
    
    
    private func set(view moveView:  UIView, toCenterOfView baseView: UIView) {
        
        moveView.center = CGPoint(x: baseView.bounds.midX, y: baseView.bounds.midY)
//        // размеры вложенного представления
//        let moveViewWidth = moveView.frame.width
//        let moveViewHeight = moveView.frame.height
//        // размеры родительского представления
//        let baseViewWidth = baseView.bounds.width
//        let baseViewHeight = baseView.bounds.height
//        // вычисление и изменение координат
//        let newXCoordinate = (baseViewWidth - moveViewWidth) / 2
//        let newYCoordinate = (baseViewHeight - moveViewHeight) / 2
//        moveView.frame.origin = CGPoint(x: newXCoordinate, y: newYCoordinate)
    }
    
    func getPinkView() -> UIView {
        let viewFrame = CGRect(x: 50, y: 300, width: 100, height: 100)
        let view = UIView(frame: viewFrame)
        view.layer.backgroundColor = UIColor.systemPink.cgColor
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.yellow.cgColor
        view.layer.cornerRadius = 10
        view.layer.shadowOpacity = 0.95
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = CGSize(width: 10, height: 20)
        view.layer.shadowColor = UIColor.green.cgColor
        view.layer.opacity = 0.8
        //view.layer.backgroundColor = UIColor.black.cgColor
        
        // создание дочернего
        let layer = CALayer()
        // изменение фонового
        layer.backgroundColor = UIColor.black.cgColor
        // изменение размеров и положения
        layer.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        // изменение радиуса скругления углов
        layer.cornerRadius = 10
        // добавление в иерархию слоев
        view.layer.addSublayer(layer)

        
//        // вывод на консоль размеров представления
//        print(view.frame)
//        // поворот представления
//        view.transform = CGAffineTransform(rotationAngle: .pi / 4)
//        // вывод на консоль размеров представления
//        print(view.frame)
        
//        view.transform = CGAffineTransform(scaleX: 0.5, y: 0.7)
        
        //view.transform = CGAffineTransform(translationX: 100, y: 5)
        
        //view.transform = CGAffineTransform(rotationAngle: .pi / 3).scaledBy(x: 2, y: 0.8).translatedBy(x: 50, y: 50)
        
        //view.transform = CGAffineTransform.identity
        
        //view.transform = CGAffineTransform(rotationAngle: .pi/4)
        //view.transform = view.transform.inverted()
        
        return view
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
