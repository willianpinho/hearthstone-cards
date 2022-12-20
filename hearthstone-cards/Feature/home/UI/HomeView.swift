//
//  HomeView.swift
//  hearthstone-cards
//
//  Created by Willian Junior Peres de Pinho on 19/12/22.
//

import UIKit

final class HomeView: UIView {
    lazy var table: UITableView = {
        let view = UITableView(frame: .zero)
        return view
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeView: CodeView {
    func buildViewHierarchy() {
        addSubviews(
            table
        )
    }
    
    func setupConstraints() {
        table.fill()
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .systemBackground
    }
}
