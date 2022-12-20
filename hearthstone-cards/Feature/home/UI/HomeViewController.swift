//
//  HomeViewController.swift
//  hearthstone-cards
//
//  Created by Willian Junior Peres de Pinho on 19/12/22.
//

import Foundation
import UIKit
import Combine
import Swinject

class HomeViewController: UIViewController {
    private var screen = HomeView()
    
    @Injected var viewModel: HomeViewModelProtocol?

    private let input: PassthroughSubject<HomeViewModelProtocolInput, Never> = .init()
    private var subscriptions = Set<AnyCancellable>()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTable()
        setupSubscriptions()
        input.send(.fetchCards)
    }
    
    fileprivate func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor(red: 0.294, green: 0.294, blue: 0.294, alpha: 1)
        titleLabel.text = "Cards"
        titleLabel.sizeToFit()
        
        self.navigationItem.titleView = titleLabel
    }
    
    private func setupView() {
        setupNavigationBar()
    }
    
    private func setupSubscriptions() {
        viewModel?.transform(input: input.eraseToAnyPublisher()).sink { result in
            switch result {
            case .success:
                self.screen.table.reloadData()
                self.screen.table.layoutIfNeeded()
            case .error:
                //TODO: Apresentar erro
                print("Erro")
            }
        }.store(in: &subscriptions)
    }
    
    private func setupTable() {
        screen.table.delegate = self
        screen.table.dataSource = self
        screen.table.separatorStyle = .none
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cards.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell") else {
                return UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "UITableViewCell")
            }
            return cell
        }()
        let currentCard = viewModel?.cards[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = currentCard?.name
        cell.detailTextLabel?.text = currentCard?.cardID
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currentCard = viewModel?.cards[indexPath.row] else {
            return 
        }
        self.go(to: CardViewController(card: currentCard), flowType: .push)
    }
}


