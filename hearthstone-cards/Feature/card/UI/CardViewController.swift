//
//  CardViewController.swift
//  hearthstone-cards
//
//  Created by Willian Junior Peres de Pinho on 19/12/22.
//

import Foundation
import UIKit
import Combine

struct DataTableView {
    var title: String
    var value: String
}

class CardViewController: UIViewController {
    private var screen = CardView()
    @Injected var viewModel: CardViewModelProtocol?
    var card: Card? = nil
    private let input: PassthroughSubject<CardViewModelProtocolInput, Never> = .init()
    private var subscriptions = Set<AnyCancellable>()
    var cardData: [DataTableView] = []
    public init(card: Card) {
        self.card = card
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
        if let cardID = self.card?.cardID {
            input.send(.fetchCard(cardID))
        }
    }
    
    fileprivate func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor(red: 0.294, green: 0.294, blue: 0.294, alpha: 1)
        titleLabel.text = "Card"
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
                self.card = self.viewModel?.card
                self.cardData.append(DataTableView(title: "Name", value: self.card?.name ?? ""))
                self.cardData.append(DataTableView(title: "Flavor", value: self.card?.flavor ?? ""))
                self.cardData.append(DataTableView(title: "Description", value: self.card?.text ?? ""))
                self.cardData.append(DataTableView(title: "Set", value: self.card?.cardSet ?? ""))
                self.cardData.append(DataTableView(title: "Type", value: self.card?.type ?? ""))
                self.cardData.append(DataTableView(title: "Faction", value: self.card?.faction ?? ""))
                self.cardData.append(DataTableView(title: "Rarity", value: self.card?.rarity ?? ""))
                self.cardData.append(DataTableView(title: "Attack", value: String(self.card?.attack ?? 0)))
                self.cardData.append(DataTableView(title: "Cost", value: String(self.card?.cost ?? 0)))
                self.cardData.append(DataTableView(title: "Health", value: String(self.card?.health ?? 0)))
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
        screen.table.register(viewType: CardImageTableViewCell.self)
    }
}

extension CardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell") else {
                return UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "UITableViewCell")
            }
            return cell
        }()
        let data = cardData[indexPath.row]
        cell.textLabel?.text = data.title
        cell.detailTextLabel?.text = data.value
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell: CardImageTableViewCell = tableView.dequeueReusableHeaderFooterView()
        cell.setup(card: card ?? Card())
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
}
