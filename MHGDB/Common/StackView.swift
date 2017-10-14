//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import UIKit

extension UIStackView {
    convenience init(axis: UILayoutConstraintAxis = .vertical, spacing: Int = 8, distribution: UIStackViewDistribution = .fill) {
        self.init()
        self.axis = axis
        self.spacing = CGFloat(spacing)
        self.distribution = .fill
    }
}

/* UIStackView imitation until we get rid of < iOS 9
 Implemented like: distribution = .fill
 */

class StackView: UIView {
    enum Axis {
        case vertical, horizontal
    }
    
    enum Distribution {
        case fill, horizontal
    }
    
    var axis = Axis.vertical {
        didSet {
            updateAxis()
        }
    }
    
    var spacing = 0 {
        didSet {
            updateSpacing()
        }
    }
    
    var spacers = [NSLayoutConstraint]()
    var trailingConstraint = NSLayoutConstraint()
    var views = [UIView]()
    var distribution: Distribution?
    
    init(axis: Axis = .vertical, spacing: Int = 8, distribution: Distribution? = nil) {
        super.init(frame: CGRect.zero)
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addArrangedSubview(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        let trailingRelation: NSLayoutRelation = distribution == .fill ? .equal : .greaterThanOrEqual
        
        if axis == .horizontal {
            view.matchParent(top: 0, left: nil, bottom: 0, right: nil)
            
            if views.count == 0 {
                let constraint = NSLayoutConstraint(item: view,
                                                    attribute: .left,
                                                    relatedBy: .equal,
                                                    toItem: self,
                                                    attribute: .left,
                                                    multiplier: 1,
                                                    constant: 0)
                addConstraint(constraint)
            } else {
                let constraint = NSLayoutConstraint(item: view,
                                                    attribute: .left,
                                                    relatedBy: .equal,
                                                    toItem: views[views.count - 1],
                                                    attribute: .right,
                                                    multiplier: 1,
                                                    constant: CGFloat(spacing))
                addConstraint(constraint)
                spacers.append(constraint)
                removeConstraint(trailingConstraint)
            }
            
            trailingConstraint = NSLayoutConstraint(item: self,
                                                    attribute: .right,
                                                    relatedBy: trailingRelation,
                                                    toItem: view,
                                                    attribute: .right,
                                                    multiplier: 1,
                                                    constant: 0)
            addConstraint(trailingConstraint)
            
        } else {
            view.matchParent(top: nil, left: 0, bottom: nil, right: 0)
            
            if views.count == 0 {
                let constraint = NSLayoutConstraint(item: view,
                                                    attribute: .top,
                                                    relatedBy: .equal,
                                                    toItem: self,
                                                    attribute: .top,
                                                    multiplier: 1,
                                                    constant: 0)
                addConstraint(constraint)
            } else {
                let constraint = NSLayoutConstraint(item: view,
                                                    attribute: .top,
                                                    relatedBy: .equal,
                                                    toItem: views[views.count - 1],
                                                    attribute: .bottom,
                                                    multiplier: 1,
                                                    constant: CGFloat(spacing))
                addConstraint(constraint)
                spacers.append(constraint)
                removeConstraint(trailingConstraint)
            }
            
            trailingConstraint = NSLayoutConstraint(item: self,
                                                    attribute: .bottom,
                                                    relatedBy: trailingRelation,
                                                    toItem: view,
                                                    attribute: .bottom,
                                                    multiplier: 1,
                                                    constant: 0)
            addConstraint(trailingConstraint)
        }
        
        views.append(view)
    }
    
    func updateSpacing() {
        for spacer in spacers {
            spacer.constant = CGFloat(spacing)
        }
    }
    
    func updateAxis() {
        for view in views {
            view.removeFromSuperview()
        }
        spacers.removeAll()
        
        let tempViews = [UIView](views)
        views.removeAll()
        for view in tempViews {
            addArrangedSubview(view)
        }
    }
}
