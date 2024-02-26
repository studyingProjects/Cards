//
//  MainScreenController.swift
//  Cards
//
//  Created by Andrei Shpartou on 26/02/2024.
//

import UIKit

class MainScreenController: UIViewController {

    private var mainScreenView = MainScreenView()
    
    override func loadView() {
        self.view = mainScreenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainScreenView.startGameButton.addTarget(self, action: #selector(startNewGame(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        mainScreenView.setViewsSizes()
    }
    
    @objc func startNewGame(_ sender: UIButton) {
        navigationController?.pushViewController(BoardGameController(), animated: true)
    }
    


}
