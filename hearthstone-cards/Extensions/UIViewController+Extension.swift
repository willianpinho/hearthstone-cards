//
//  UIViewController+Extension.swift
//  hearthstone-cards
//
//  Created by Willian Junior Peres de Pinho on 19/12/22.
//

import UIKit

public enum FlowType {
    case navigation
    case push
    case modal
    case overContent
    case formSheet
}

public extension UIViewController {
    @objc class func instantiate() -> Self {
        func instantiateFromNib<T: UIViewController>(_ viewType: T.Type) -> T {
            let t = T.init(nibName: String(describing: T.self), bundle: Bundle.init(for: T.self))
            t.modalPresentationStyle = .fullScreen
            return t
        }
        
        return instantiateFromNib(self)
    }
    
    func go(to viewController: UIViewController, flowType: FlowType, animated: Bool =  true, completion: (() -> Void)? = nil) {
        switch flowType {
        case .push:
            self.show(viewController, sender: self)
        case .modal:
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: animated, completion: completion)
        case .navigation:
            let navigation = UINavigationController(rootViewController: viewController)
            navigation.modalPresentationStyle = .fullScreen
            self.present(navigation, animated: animated, completion: completion)
        case .overContent:
            viewController.modalPresentationStyle = .overCurrentContext
            self.present(viewController, animated: animated, completion: completion)
        case .formSheet:
            viewController.modalPresentationStyle = .formSheet
            self.present(viewController, animated: animated, completion: completion)
        }
    }
    
    var top: UIViewController? {
        if let controller = presentedViewController {
            return controller.top
        }
        if let controller = self as? UINavigationController {
            return controller.topViewController?.top
        }
        if let controller = self as? UISplitViewController {
            return controller.viewControllers.last?.top
        }
        if let controller = self as? UITabBarController {
            return controller.selectedViewController?.top
        }
        return self
    }
}
