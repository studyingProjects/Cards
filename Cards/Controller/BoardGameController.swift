//
//  BoardGameController.swift
//  Cards
//
//  Created by Andrei Shpartou on 23/02/2024.
//

import UIKit

class BoardGameController: UIViewController {
    // MARK: - Properties
    // количество пар уникальных карточек
    var cardsPairsCounts = 8
    // сущность "Игра"
    lazy var game: Game = getNewGame()
    // кнопка для запуска/перезапуска игры
    lazy var startButtonView = getStartButtonView()
    // игровое поле
    lazy var boardGameView = getBoardGameView()
    // размеры карточек
    private var cardSize: CGSize {
        CGSize(width: 80, height: 120)
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        // добавляем кнопку на сцену
        view.addSubview(startButtonView)
        // добавляем игровое поле на сцену
        view.addSubview(boardGameView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // MARK: - Events handliers
    @objc func startGame(_ sender: UIButton) {
        print("Button was pressed")
    }
    // MARK: - Private methods
    private func getNewGame() -> Game {
        let game = Game()
        game.cardsCount = self.cardsPairsCounts
        game.generateCards()
        return game
    }
    
    private func getStartButtonView() -> UIButton {
        // 1
        // Создаем кнопку
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        // 2
        // Изменяем положение кнопки
        button.center.x = view.center.x
        // получаем доступ к текущему окну
        //let window = UIApplication.shared.windows[0]
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first
        else { return button}
        // определяем отступ сверху от границ окна до Safe Area
        let topPadding = window.safeAreaInsets.top
        button.frame.origin.y = topPadding
        // 3
        // Настраиваем внешний вид кнопки
        // устанавливаем текст
        button.setTitle("Начать игру", for: .normal)
        // устанавливаем цвет текста для обычного (не нажатого) состояния
        button.setTitleColor(.black, for: .normal)
        // устанавливаем цвет текста для нажатого состояния
        button.setTitleColor(.gray, for: .highlighted)
        // устанавливаем фоновый цвет
        button.backgroundColor = .systemGray4
        // скругляем углы
        button.layer.cornerRadius = 10
        
        // подключаем обработчик нажатия на кнопку
        button.addTarget(nil, action: #selector(startGame(_:)), for: .touchUpInside)
        
        return button
    }
    
    private func getBoardGameView() -> UIView {
        // отступ игрового поля от ближайших элементов
        let margin: CGFloat = 10
        let boardView = UIView()
        // указываем координаты
        // x
        boardView.frame.origin.x = margin
        // y
        //let window = UIApplication.shared.windows[0] / let topPadding = window.safeAreaInsets.top
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first
        else { return boardView}
        let topPadding = window.safeAreaInsets.top
        boardView.frame.origin.y = topPadding + startButtonView.frame.height + margin
        // рассчитываем ширину
        boardView.frame.size.width = UIScreen.main.bounds.width - margin*2
        // рассчитываем высоту
        // c учетом нижнего отступа
        let bottomPadding = window.safeAreaInsets.bottom
        boardView.frame.size.height = UIScreen.main.bounds.height - boardView.frame.origin.y - margin - bottomPadding
        // изменяем стиль игрового поля
        boardView.layer.cornerRadius = 5
        boardView.backgroundColor = UIColor(red: 0.1, green: 0.9, blue: 0.1,
                                            alpha: 0.3)
        
        return boardView
    }
    
    // генерация массива карточек на основе данных Модели
    private func getCardsBy(modelData: [Card]) -> [UIView] {
        // хранилище для представлений карточек
        var cardViews = [UIView]()
        // фабрика карточек
        let cardViewFactory = CardViewFactory() // перебираем массив карточек в Модели
        for (index, modelCard) in modelData.enumerated() {
            // добавляем первый экземпляр карты
            let cardOne = cardViewFactory.get(modelCard.type, withSize: cardSize, andColor: modelCard.color)
            cardOne.tag = index
            cardViews.append(cardOne)
            // добавляем второй экземпляр карты
            let cardTwo = cardViewFactory.get(modelCard.type, withSize: cardSize, andColor: modelCard.color)
            cardTwo.tag = index
            cardViews.append(cardTwo)
        }
        // добавляем всем картам обработчик переворота
        for card in cardViews {
            (card as! FlippableView).flipCompletionHandler = { flippedCard in
                // переносим карточку вверх иерархии
                flippedCard.superview?.bringSubviewToFront(flippedCard)
            }
        }
        return cardViews
    }
}
