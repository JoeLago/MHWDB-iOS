//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import UIKit

extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis = .vertical, spacing: Int = 8, distribution: UIStackView.Distribution = .fill) {
        self.init()
        self.axis = axis
        self.spacing = CGFloat(spacing)
        self.distribution = .fill
    }

    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
