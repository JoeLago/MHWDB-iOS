//
//  SvgLabel.swift
//  MHWDB
//
//  Created by Joe on 7/29/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import UIKit

class SvgLabel: UIStackView {
    let label = UILabel()
    let icon = SvgModelView(frame: .zero)
    var selected: (() -> Void)?

    lazy var iconWidthConstraint = { icon.widthAnchor.constraint(equalToConstant: 30) }()
    lazy var iconHeightConstraint = { icon.heightAnchor.constraint(equalToConstant: 30) }()

    init() {
        super.init(frame: .zero)
        axis = .horizontal
        spacing = 3
        label.textColor = Color.Text.primary
        label.font = Font.title

        let iconWrapper = UIView()
        iconWrapper.addSubview(icon)
        addArrangedSubview(iconWrapper)
        addArrangedSubview(label)

        icon.centerYAnchor.constraint(equalTo: iconWrapper.centerYAnchor).isActive = true
        icon.matchParent(top: nil, left: 0, bottom: nil, right: 0)
        icon.matchParent(top: 0, left: nil, bottom: 0, right: nil, relatedBy: .greaterThanOrEqual)
        iconWidthConstraint.isActive = true
        iconHeightConstraint.isActive = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        addGestureRecognizer(tapGesture)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(svgModel: SVGImageModel?, text: String, size: CGFloat? = nil, selected: (() -> Void)? = nil) {
        svgModel.map { icon.configure(model: $0) }
        label.text = text
        self.selected = selected

        if let size = size {
            iconWidthConstraint.constant = size
            iconHeightConstraint.constant = size
        }
    }

    @objc func handleTap(sender: UITapGestureRecognizer) {
        selected?()
    }
}
