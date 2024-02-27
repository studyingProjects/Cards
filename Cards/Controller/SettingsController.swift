//
//  SettingsController.swift
//  Cards
//
//  Created by Andrei Shpartou on 27/02/2024.
//

import UIKit

class SettingsController: UIViewController {

    private var settings: SettingsView!
    var delegate: SettingsControllerDelegate?
    
    override func loadView() {
        settings = SettingsView()
        self.view = settings
        self.delegate = settings
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillLayoutSubviews() {
        self.delegate?.setViewsSizes()
    }
    

}
