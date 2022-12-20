//
//  CodeView.swift
//  hearthstone-cards
//
//  Created by Willian Junior Peres de Pinho on 18/12/22.
//

import Foundation

public protocol CodeView {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

public extension CodeView {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}
