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

class SettingsChoiceView: UIView, SettingsChoiceViewProtocol {
    
    var choiceCompletionHandler: ((SettingsChoiceViewProtocol) -> Void)?
    var isChosen: Bool = false
    
    var color: UIColor?
    
    init(frame: CGRect, color: UIColor?) {
        super.init(frame: frame)
        self.color = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func choose() {
        
    }
    

}
