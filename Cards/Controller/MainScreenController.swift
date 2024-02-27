//
//  MainScreenController.swift
//  Cards
//
//  Created by Andrei Shpartou on 26/02/2024.
//

import UIKit

protocol MainScreenViewDelegate {
    func startNewGame(_ sender: UIButton)
    func goToSettings(_ sender: UIButton)
}

class MainScreenController: UIViewController {

    private var mainScreenView: MainScreenView!
    var delegate: MainScreenControllerDelegate?
    
    override func loadView() {
        mainScreenView = MainScreenView()
        mainScreenView.delegate = self
        self.view = mainScreenView
        self.delegate = mainScreenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        self.delegate?.setViewsSizes()
    }

}

extension MainScreenController: MainScreenViewDelegate {
    
    func startNewGame(_ sender: UIButton) {
        navigationController?.pushViewController(BoardGameController(), animated: true)
    }
    
    func goToSettings(_ sender: UIButton) {
        navigationController?.pushViewController(SettingsController(), animated: true)
    }
    
    
}
