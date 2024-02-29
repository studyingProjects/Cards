//
//  BoardGameController.swift
//  Cards
//
//  Created by Andrei Shpartou on 23/02/2024.
//

import UIKit

class BoardGameController: UIViewController {
    // MARK: - View-Poperties
    // кнопка для запуска/перезапуска игры
    private lazy var startButtonView = getStartButtonView()
    private lazy var flipAllButtonView = getFlipAllButton()
    // игровое поле
    private lazy var boardGameView = getBoardGameView()
    
    // MARK: - Game settings
    // количество пар уникальных карточек
    private var cardsPairsCounts = Int(SettingsStorage.shared.countOfCardPairs)
    
    // игральные карточки
    private var cardViews = [UIView]()
    private var flippedCards = [UIView]()
    // сущность "Игра"
    private lazy var game: Game = getNewGame()
    // размеры карточек
    private var cardSize: CGSize {
        CGSize(width: 80, height: 120)
    }
    // предельные координаты размещения карточки
    private var cardMaxXCoordinate: Int {
        Int(boardGameView.frame.width - cardSize.width)
    }
    private var cardMaxYCoordinate: Int {
        Int(boardGameView.frame.height - cardSize.height)
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        // добавляем кнопку на сцену
        view.addSubview(startButtonView)
        view.addSubview(flipAllButtonView)
        // добавляем игровое поле на сцену
        view.addSubview(boardGameView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
    }
    // MARK: - WillLayoutSubviews
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let topPadding = view.safeAreaInsets.top
        let commonPadding = 10.0
        
        startButtonView.frame.origin.y = topPadding
        startButtonView.frame.origin.x = commonPadding
        
        flipAllButtonView.frame.origin.y = topPadding
        flipAllButtonView.frame.origin.x = view.frame.width - commonPadding - flipAllButtonView.bounds.width
        
        // указываем координаты
        // x
        boardGameView.frame.origin.x = commonPadding
        // y
        boardGameView.frame.origin.y = topPadding + startButtonView.frame.height + commonPadding
        // рассчитываем ширину
        boardGameView.frame.size.width = view.bounds.width - commonPadding * 2
        // рассчитываем высоту
        // c учетом нижнего отступа
        let bottomPadding = view.safeAreaInsets.bottom
        boardGameView.frame.size.height = view.bounds.height - boardGameView.frame.origin.y - commonPadding - bottomPadding
        
    }
    
    // MARK: - Start button View
    private func getStartButtonView() -> UIButton {
        // 1
        // Создаем кнопку
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        // 2
        // Изменяем положение кнопки
        //button.center.x = view.center.x
        // получаем доступ к текущему окну
        //let window = UIApplication.shared.windows[0]
//        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//              let window = windowScene.windows.first
//        else { return button}
        // определяем отступ сверху от границ окна до Safe Area
        //let topPadding = view.safeAreaInsets.top //window.safeAreaInsets.top
        //let leftPadding = 10.0
        //button.frame.origin.y = topPadding
        //button.frame.origin.x = leftPadding
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
    // MARK: - Flip All Button View
    func getFlipAllButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 180, height: 50))
//        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//              let window = windowScene.windows.first else {
//                return button
//              }
        
        //let topPadding = window.safeAreaInsets.top
        //let sidePadding = 10.0
        
//        button.frame.origin.x = view.frame.width - sidePadding - button.bounds.width
//        button.frame.origin.y = topPadding
        
        button.setTitle("Перевернуть карты", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 10
        
        button.addTarget(nil, action: #selector(flipAllCards(_:)), for: .touchUpInside)
        
        return button
    }
    // MARK: - Board game View
    private func getBoardGameView() -> UIView {
        // отступ игрового поля от ближайших элементов
        //let margin: CGFloat = 10
        let boardView = UIView()
//        // указываем координаты
//        // x
//        boardView.frame.origin.x = margin
//        // y
//        //let window = UIApplication.shared.windows[0] / let topPadding = window.safeAreaInsets.top
//        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//              let window = windowScene.windows.first
//        else { return boardView}
//        let topPadding = window.safeAreaInsets.top
//        boardView.frame.origin.y = topPadding + startButtonView.frame.height + margin
//        // рассчитываем ширину
//        boardView.frame.size.width = UIScreen.main.bounds.width - margin*2
//        // рассчитываем высоту
//        // c учетом нижнего отступа
//        let bottomPadding = window.safeAreaInsets.bottom
//        boardView.frame.size.height = UIScreen.main.bounds.height - boardView.frame.origin.y - margin - bottomPadding
        // изменяем стиль игрового поля
        boardView.layer.cornerRadius = 5
        boardView.backgroundColor = UIColor(red: 0.1, green: 0.9, blue: 0.1,
                                            alpha: 0.3)
        
        return boardView
    }
    // MARK: - Events handliers
    @objc func startGame(_ sender: UIButton) {
        game = getNewGame()
        let cards = getCardsBy(modelData: game.cards)
        placeCardsOnBoard(cards)
    }
    // MARK: - Flip All Cards
    @objc func flipAllCards(_ sender: UIButton) {
        
//        for card in flippedCards {
//            (card as! FlippableView).isFlipped.toggle()
//        }
//        flippedCards = []
        
        for card in cardViews {
            if flippedCards.contains(card) {
                continue
            }
            let flippableCard = card as! FlippableView
            flippableCard.handleFlip = false
            flippableCard.flip()
        }
        
        flippedCards = []
    }
    
    // MARK: - Private methods
    private func getNewGame() -> Game {
        let game = Game()
        game.cardsCount = self.cardsPairsCounts
        game.generateCards()
        return game
    }
    // MARK: - Cards managment
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
                
                if !flippedCard.handleFlip {
                    return
                }
                
                // переносим карточку вверх иерархии
                flippedCard.superview?.bringSubviewToFront(flippedCard)
                
                // добавляем или удаляем карточку
                if flippedCard.isFlipped {
                    self.flippedCards.append(flippedCard)
                } else {
                    if let cardIndex = self.flippedCards.firstIndex(of: flippedCard) {
                        self.flippedCards.remove(at: cardIndex)
                    }
                }
                
                if self.flippedCards.count == 2 {
                    // получаем карточки из данных модели
                    let firstCard = self.game.cards[self.flippedCards.first!.tag]
                    let secondCard = self.game.cards[self.flippedCards.last!.tag]
                    // если карточки одинаковые
                    if self.game.checkCards(firstCard, secondCard) {
                        // сперва анимировано скрываем их
                        UIView.animate(
                            withDuration: 0.3,
                            animations: {
                                self.flippedCards.first!.layer.opacity = 0
                                self.flippedCards.last!.layer.opacity = 0
                                // после чего удаляем из иерархии
                            },
                            completion: {_ in
                                self.flippedCards.first!.removeFromSuperview()
                                self.flippedCards.last!.removeFromSuperview()
                                self.flippedCards = []
                            })
                    } else {
                        // переворачиваем карточки рубашкой вверх
                        for card in self.flippedCards {
                            (card as! FlippableView).flip()
                        }
                    }
                }
                 
            }
        }
        
        return cardViews
    }
    // MARK: - Cards placing
    private func placeCardsOnBoard(_ cards: [UIView]) {
        // удаляем все имеющиеся на игровом поле карточки
        for card in cardViews {
            card.removeFromSuperview()
        }
        cardViews = cards
        // перебираем карточки
        for card in cardViews {
            // для каждой карточки генерируем случайные координаты
            let randomXCoordinate = Int.random(in: 0...cardMaxXCoordinate)
            let randomYCoordinate = Int.random(in: 0...cardMaxYCoordinate)
            card.frame.origin = CGPoint(x: randomXCoordinate, y: randomYCoordinate)
            // размещаем карточку на игровом поле
            boardGameView.addSubview(card)
        }
    }
}
