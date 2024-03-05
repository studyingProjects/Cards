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
    // label количество переворотов
    private lazy var flipCountsLabel = getFlipCountsLabel()
    // игровое поле
    private lazy var boardGameView = getBoardGameView()
    
    // MARK: - Game settings
    // количество пар уникальных карточек
    private var cardsPairsCounts = Int(SettingsStorage.shared.countOfCardPairs)
    // Card colors to choice
    private var cardColors = SettingsStorage.shared.cardColors
    // Type of figures
    private var cardTypes = SettingsStorage.shared.cardTypes
    // Card back side covers
    private var cardBackCovers = SettingsStorage.shared.cardBackCovers
    private var saveCards = SettingsStorage.shared.cards
    
    // игральные карточки
    private var cardViews = [UIView]()
    private var flippedCards = [UIView]()
    // сущность "Игра"
    private lazy var game: Game = getNewGame()
    // размеры карточек
    private var cardSize: CGSize {
        CGSize(width: 70, height: 100)
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
        view.addSubview(flipCountsLabel)
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
        
        flipCountsLabel.frame.origin.x = startButtonView.frame.origin.x
        flipCountsLabel.frame.origin.y = topPadding + flipAllButtonView.frame.height + commonPadding / 2
        flipCountsLabel.frame.size.width = view.bounds.width - commonPadding * 2
        
        // указываем координаты
        // x
        boardGameView.frame.origin.x = commonPadding
        // y
        boardGameView.frame.origin.y = flipCountsLabel.frame.origin.y + flipCountsLabel.frame.height + commonPadding
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
    // MARK: - Flip counts label
    private func getFlipCountsLabel() -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 25))
        label.text = "Количество переворотов:"
        label.textAlignment = .right
        return label
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
        flipCountsLabel.text = "Количество переворотов: "
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
        game.cardBackCovers = self.cardBackCovers
        game.cardColors = self.cardColors
        game.cardTypes = self.cardTypes
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
            // old version with tuple
//            // добавляем первый экземпляр карты
//            let cardOne = cardViewFactory.get(modelCard.type, withSize: cardSize, andColor: modelCard.color, and: modelCard.covers.randomElement()!)
//            cardOne.tag = index
//            cardViews.append(cardOne)
//            // добавляем второй экземпляр карты
//            let cardTwo = cardViewFactory.get(modelCard.type, withSize: cardSize, andColor: modelCard.color, and: modelCard.covers.randomElement()!)
//            cardTwo.tag = index
//            cardViews.append(cardTwo)
            
            // new version with struct Card
            let cardOne = cardViewFactory.getCardView(from: modelCard, withSize: cardSize, withProperties: modelCard.viewProperties[0], 0)
            cardOne.tag = index
            cardViews.append(cardOne)
            
            let cardTwo = cardViewFactory.getCardView(from: modelCard, withSize: cardSize, withProperties: modelCard.viewProperties[1], 1)
            cardTwo.tag = index
            cardViews.append(cardTwo)
            
        }
        // добавляем всем картам обработчик переворота
        for card in cardViews {
            (card as! FlippableView).saveViewStageCompletionHandler = { card in
                let cardModel = self.game.cards[card.tag]
                cardModel.viewProperties[card.propertyIndex].isFlipped = card.isFlipped
                cardModel.viewProperties[card.propertyIndex].originX = card.frame.origin.x
                cardModel.viewProperties[card.propertyIndex].originY = card.frame.origin.y
                cardModel.viewProperties[card.propertyIndex].opacity = card.layer.opacity
                SettingsStorage.shared.cards = self.game.cards
            }
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
                    // считаем количество переворотов и выводим в label
                    self.game.flipCounts += 1
                    self.flipCountsLabel.text = String("Количество переворотов: \(self.game.flipCounts)")
                    if self.boardGameView.subviews.filter({ $0.layer.opacity != 0}).count == 0 {
                        let alert = UIAlertController(title: "Game end. Wanna try again?",
                                                      message: "Overall flips count: \(self.game.flipCounts)",
                                                      preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "Restart game", style: .default, handler: { _ in self.startGame(self.startButtonView)})
                        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                        alert.addAction(action)
                        alert.addAction(cancelAction)
                        self.present(alert, animated: true, completion: nil)
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
