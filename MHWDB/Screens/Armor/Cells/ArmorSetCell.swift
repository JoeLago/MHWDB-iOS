//
//  ArmorSetCell.swift
//  MHWDB
//
//  Created by Joe on 6/30/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import UIKit

struct ArmorSetCellModel {
    var id: Int
    var label: String
    var svgModels: [SVGImageModel]
}

class ArmorSetCell: CustomCell<ArmorSetCellModel> {
    let label = UILabel()
    let stack = UIStackView(axis: .horizontal, spacing: 5, distribution: .fillProportionally)
    let iconStack = UIStackView(axis: .horizontal, spacing: -8)
    var icons = [UIView]()

    override var model: ArmorSetCellModel? {
        didSet {
            guard let model = model else { return }
            populate(model: model)
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        addSubview(stack)
        stack.matchParent(top: 10, left: 15, bottom: 10, right: 15)
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(iconStack)
    }

    func populate(model: ArmorSetCellModel) {
        icons.forEach { $0.removeFromSuperview() }

        label.text = model.label

        // inefficient, lets keep reference to each image
        icons = [UIView]()
        for svgModel in model.svgModels {
            guard let imageView = SvgModelView(model: svgModel) else { continue }
            imageView.heightAnchor.constraint(equalToConstant: 22).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 22).isActive = true
            icons.append(imageView)
        }
        iconStack.addArrangedSubviews(icons)
    }
}
