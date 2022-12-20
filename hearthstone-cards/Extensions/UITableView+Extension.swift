//
//  UITableView+Extension.swift
//  hearthstone-cards
//
//  Created by Willian Junior Peres de Pinho on 19/12/22.
//

import Foundation
import UIKit

public protocol Reusable {
    static var reuseIdentifier: String { get }
}

public extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

public protocol NibReusable: Reusable {
    static var nib: UINib { get }
}

public extension NibReusable {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

public extension UITableView {

    final func register<T: UITableViewCell & NibReusable>(cellType: T.Type) {
        register(returnNib(cellType: cellType.self), forCellReuseIdentifier: cellType.reuseIdentifier)
    }

    final func register<T: UITableViewHeaderFooterView & NibReusable>(viewType: T.Type) {
        register(returnNib(viewType: viewType.self), forHeaderFooterViewReuseIdentifier: viewType.reuseIdentifier)
    }

    final func dequeueReusableCell<T: UITableViewCell & Reusable>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue reusable cell with identifier '\(T.reuseIdentifier)'. Did you forget to register the cell first?")
        }
        return cell
    }

    final func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView & Reusable>() -> T {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Failed to dequeue reusable headerFooterView with identifier '\(T.reuseIdentifier)'. Did you forget to register the headerFooterView first?")
        }
        return headerFooterView
    }
    
    final func returnNib<T: UITableViewCell & NibReusable>(cellType: T.Type) -> UINib{
        return UINib(nibName: String(describing: cellType.self), bundle: Bundle.init(for: cellType.self))
    }

    final func returnNib<T: UITableViewHeaderFooterView & NibReusable>(viewType: T.Type) -> UINib{
        return UINib(nibName: String(describing: viewType.self), bundle: Bundle.init(for: viewType.self))
    }
}
