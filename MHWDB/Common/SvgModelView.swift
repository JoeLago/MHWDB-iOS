//
//  SvgModelView.swift
//  MHWDB
//
//  Created by Joe on 7/28/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import SVGKit

class SvgModelView: SVGKFastImageView {
    var imageName: String? // cache name so we don't reload same image

    init?(model: SVGImageModel) {
        imageName = model.name
        guard let image = SVGKImage(named: model.name) else { return nil }
        let layer = image.layer(withIdentifier: "base") as? CAShapeLayer
        layer?.fillColor = model.color.cgColor
        super.init(svgkImage: image)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
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
