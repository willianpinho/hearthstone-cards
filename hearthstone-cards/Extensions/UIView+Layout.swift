//
//  UIView+Layout.swift
//  hearthstone-cards
//
//  Created by Willian Junior Peres de Pinho on 18/12/22.
//

import UIKit

extension UIView {
    
    @discardableResult
    public func addSubviews(_ subViews: UIView...) -> UIView {
        addSubviews(subViews)
    }
    
    @discardableResult
    @objc
    func addSubviews(_ subViews: [UIView]) -> UIView {
        for sv in subViews {
            addSubview(sv)
            sv.translatesAutoresizingMaskIntoConstraints = false
        }
        return self
    }

}

extension UIStackView {

    @discardableResult
    public func addArrangedSubviews(_ subViews: UIView...) -> UIView {
        addArrangedSubviews(subViews)
    }

    @discardableResult
    func addArrangedSubviews(_ subViews: [UIView]) -> UIView {
        subViews.forEach { addArrangedSubview($0) }
        return self
    }
}

func constraint(item view1: AnyObject,
                attribute attr1: NSLayoutConstraint.Attribute,
                relatedBy: NSLayoutConstraint.Relation = .equal,
                toItem view2: AnyObject? = nil,
                attribute attr2: NSLayoutConstraint.Attribute? = nil,
                multiplier: CGFloat = 1,
                constant: CGFloat = 0,
                priority: Float = UILayoutPriority.defaultHigh.rawValue + 1) -> NSLayoutConstraint {
    
    let constraint =  NSLayoutConstraint(item: view1, attribute: attr1,
                                relatedBy: relatedBy,
                                toItem: view2, attribute: ((attr2 == nil) ? attr1 : attr2!),
                                multiplier: multiplier, constant: constant)
    constraint.priority = UILayoutPriority(rawValue: priority)
    return constraint
}

extension UIView {
    
    @discardableResult
    public func height(_ constant: CGFloat = 0) -> Self {
        constraint(item: self, attribute: .height, constant: constant).isActive = true
        return self
    }

    public func width(_ constant: CGFloat = 0) -> Self {
        constraint(item: self, attribute: .width, constant: constant).isActive = true
        return self
    }

    @discardableResult
    public func fill(_ padding: CGFloat = 0) -> Self {
        fill(.vertical, padding: padding)
        fill(.horizontal, padding: padding)
        return self
    }

    @discardableResult
    public func fill(_ axis: NSLayoutConstraint.Axis, padding: CGFloat = 0) -> Self {
        if let superview = superview {
            fill(axis, alignWith: superview, padding: padding)
        }
        return self
    }
    
    @discardableResult
    public func fill(_ axis: NSLayoutConstraint.Axis, alignWith: AnyObject,
                     relatedBy: NSLayoutConstraint.Relation = .equal, padding: CGFloat = 0) -> Self {
        
        let attr1: NSLayoutConstraint.Attribute = axis == .vertical ? .top : .leading
        constraint(item: self, attribute: attr1, relatedBy: relatedBy, toItem: alignWith, constant: padding).isActive = true
        
        let attr2: NSLayoutConstraint.Attribute = axis == .vertical ? .bottom : .trailing
        constraint(item: self, attribute: attr2, relatedBy: relatedBy, toItem: alignWith, constant: -padding).isActive = true
        
        return self
    }

    @discardableResult
    public func center(offset: CGFloat = 0) -> Self {
        center(.horizontal, offset: offset)
        center(.vertical, offset: offset)
        return self
    }
    
    @discardableResult
    public func center(_ axis: NSLayoutConstraint.Axis, offset: CGFloat = 0) -> Self {
        if let superview = superview {
            constraint(item: self, attribute: axis == .horizontal ? .centerX : .centerY, toItem: superview, constant: offset).isActive = true
        }
        return self
    }

    @discardableResult
    public func leading(_ offset: CGFloat = 0) -> Self {
        if let superview = superview {
            constraint(item: self, attribute: .leading, toItem: superview, constant: offset).isActive = true
        }
        return self
    }
    
    @discardableResult
    public func leading(alignWith: AnyObject, attr: NSLayoutConstraint.Attribute? = nil, offset: CGFloat = 0) -> Self {
        constraint(item: self, attribute: .leading, toItem: alignWith, attribute: attr ?? .leading, constant: offset).isActive = true
        return self
    }

    @discardableResult
    public func trailing(_ offset: CGFloat = 0) -> Self {
        if let superview = superview {
            constraint(item: self, attribute: .trailing, toItem: superview, constant: offset).isActive = true
        }
        return self
    }
    
    @discardableResult
    public func trailing(alignWith: AnyObject, attr: NSLayoutConstraint.Attribute? = nil, offset: CGFloat = 0) -> Self {
        constraint(item: self, attribute: .trailing, toItem: alignWith, attribute: attr ?? .trailing, constant: offset).isActive = true
        return self
    }
    
    @discardableResult
    public func top(_ offset: CGFloat = 0) -> Self {
        if let superview = superview {
            constraint(item: self, attribute: .top, toItem: superview, constant: offset).isActive = true
        }
        return self
    }
    
    @discardableResult
    public func top(alignWith: AnyObject, attr: NSLayoutConstraint.Attribute? = nil, offset: CGFloat = 0) -> Self  {
        constraint(item: self, attribute: .top, toItem: alignWith, attribute: attr ?? .top, constant: offset).isActive = true
        return self
    }
    
    @discardableResult
    public func bottom(_ offset: CGFloat = 0) -> Self {
        if let superview = superview {
            constraint(item: self, attribute: .bottom, toItem: superview, constant: offset).isActive = true
        }
        return self
    }
    
    @discardableResult
    public func bottom(alignWith: AnyObject, attr: NSLayoutConstraint.Attribute? = nil, offset: CGFloat = 0) -> Self {
        constraint(item: self, attribute: .bottom, toItem: alignWith, attribute: attr ?? .bottom, constant: offset).isActive = true
        return self
    }

}
