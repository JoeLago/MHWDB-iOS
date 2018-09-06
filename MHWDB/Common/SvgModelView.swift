//
//  SvgModelView.swift
//  MHWDB
//
//  Created by Joe on 7/28/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import SVGKit

struct SVGImageModel {
    let name: String
    let color: UIColor?

    init(name: String, color: UIColor? = nil) {
        self.name = name
        self.color = color
    }
}

class SvgModelView: SVGKFastImageView {
    // cache these so we don't reload if they don't change
    var currentImageName: String?
    var currentColor: UIColor?

    var colorLayer: CAShapeLayer?

    init?(model: SVGImageModel) {
        guard let image = SVGKImage(named: model.name) else { return nil }
        currentImageName = model.name
        if let color = model.color?.cgColor {
            let layer = image.layer(withIdentifier: "base") as? CAShapeLayer
            layer?.fillColor = color
        }
        super.init(svgkImage: image)
    }

    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(model: SVGImageModel?) {
        guard let model = model else {
            isHidden = true
            return
        }

        isHidden = false

        if currentImageName == nil || currentImageName != model.name {
            currentImageName = model.name
            image = SVGKImage(named: currentImageName)
            colorLayer = image.layer(withIdentifier: "base") as? CAShapeLayer
            currentColor = nil
        }

        if let color = model.color, currentColor != color {
            currentColor = color
            colorLayer?.fillColor = color.cgColor
            setNeedsDisplay()
        }
    }
}
