//
//  ArmorSetCell.swift
//  MHWDB
//
//  Created by Joe on 6/30/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import SVGKit
import UIKit

struct ArmorSetCellModel {
    var id: Int
    var label: String
    var svgModels: [SVGImageModel]
}

class ArmorSetCell: CustomCell<ArmorSetCellModel> {
    let label = UILabel()
    let stack = UIStackView(axis: .horizontal, spacing: 5, distribution: .fillProportionally)
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
    }

    func populate(model: ArmorSetCellModel) {
        label.removeFromSuperview()
        icons.forEach { $0.removeFromSuperview() }

        label.text = model.label
        stack.addArrangedSubview(label)

        if model.svgModels.count == 5 {
            let label = UILabel()
            label.text = "Set"
            label.textColor = Color.Text.subHeader
            stack.addArrangedSubview(label)
            return
        }

        // inefficient, lets keep reference to each image
        icons = [UIView]()
        for svgModel in model.svgModels {
            guard let imageView = SvgModelView(model: svgModel) else { continue }
            imageView.heightAnchor.constraint(equalToConstant: 22).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 22).isActive = true
            icons.append(imageView)
        }
        stack.addArrangedSubviews(icons)
    }
}

class SvgModelView: SVGKFastImageView {
    var imageName: String // cache name so we don't reload same image

    init?(model: SVGImageModel) {
        imageName = model.name
        guard let image = SVGKImage(named: model.name) else { return nil }
        let layer = image.layer(withIdentifier: "base") as? CAShapeLayer
        layer?.fillColor = model.color.cgColor
        super.init(svgkImage: image)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(model: SVGImageModel) {
        guard let image = (imageName == model.name ? image : SVGKImage(named: model.name)) else { return }
        imageName = model.name
        let layer = image.layer(withIdentifier: "base") as? CAShapeLayer
        layer?.fillColor = model.color.cgColor
        self.image = image
    }
}
