//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import SVGKit
import UIKit

protocol DetailCellModel {
    var primary: String? { get }
    var subtitle: String? { get }
    var secondary: String? { get }
    var imageName: String? { get }
    var svgModel: SVGImageModel? { get }
    var iconSize: CGFloat { get }
    var spacing: CGFloat { get }
}

// So that implementation is only required for non nil fields
extension DetailCellModel {
    var primary: String? { return nil }
    var subtitle: String? { return nil }
    var secondary: String? { return nil }
    var imageName: String? { return nil }
    var svgModel: SVGImageModel? { return nil }
    var iconSize: CGFloat { return 30 }
    var spacing: CGFloat { return 6 }
}

class DetailCell: UITableViewCell {
    static let identifier = "detailCell"

    let stack = UIStackView(axis: .horizontal, spacing: 6, distribution: .fill)
    let detailStack = UIStackView(axis: .vertical, spacing: 4)
    var primaryTextLabel = UILabel()
    var subtitleTextLabel = UILabel()
    var secondaryTextLabel = UILabel()
    let imageWrapper = UIView()
    var iconImageView = UIImageView() // Should we separate cells with different image types somehow?
    var svgImageView = SVGKFastImageView(frame: .zero)
    var iconSizeConstraints = [NSLayoutConstraint]()

    var model: DetailCellModel? {
        didSet {
            populateCell()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: DetailCell.identifier)
        addViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("no")
    }

    private func populateCell() {
        guard let model = model else {
            Log(error: "DetailCell model not set")
            return
        }

        imageWrapper.isHidden = true
        svgImageView.isHidden = true
        iconImageView.isHidden = true

        if let image = model.imageName {
            populate(image: image)
        } else if let image = model.svgModel {
            populate(svg: image)
        }

        primaryTextLabel.text = model.primary
        subtitleTextLabel.text = model.subtitle
        secondaryTextLabel.text = model.secondary
        subtitleTextLabel.isHidden = model.subtitle == nil

        stack.spacing = model.spacing
        iconSizeConstraints.forEach { $0.constant = model.iconSize }
    }

    func populate(svg: SVGImageModel) {
        guard let image = SVGKImage(named: svg.name) else {
            return
        }

        imageWrapper.isHidden = false
        svgImageView.isHidden = false
        if let color = svg.color?.cgColor {
            let layer = image.layer(withIdentifier: "base") as? CAShapeLayer
            layer?.fillColor = color
        }
        svgImageView.image = image
    }

    func populate(image named: String) {
        guard let image = UIImage(named: named) else {
            return
        }

        imageWrapper.isHidden = false
        iconImageView.isHidden = false
        iconImageView.image = image
    }

    func hideImage() {
        imageWrapper.isHidden = true
    }

    func addViews() {
        addSubview(stack)
        imageWrapper.addSubview(svgImageView)
        imageWrapper.addSubview(iconImageView)
        stack.addArrangedSubview(imageWrapper)
        stack.addArrangedSubview(detailStack)
        stack.addArrangedSubview(secondaryTextLabel)
        detailStack.addArrangedSubview(primaryTextLabel)
        detailStack.addArrangedSubview(subtitleTextLabel)

        [imageWrapper, iconImageView, detailStack, subtitleTextLabel, primaryTextLabel, secondaryTextLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        subtitleTextLabel.font = Font.subTitle
        subtitleTextLabel.textColor = Color.Text.primary
        subtitleTextLabel.numberOfLines = 0
        secondaryTextLabel.font = Font.title
        secondaryTextLabel.textColor = Color.Text.secondary
        iconImageView.contentMode = .scaleAspectFit

        // Constraints

        stack.matchParent(top: 8, left: 12, bottom: 8, right: 16)
        svgImageView.matchParent(top: 0, left: 0, bottom: nil, right: 0)
        iconImageView.matchParent(top: 0, left: 0, bottom: nil, right: 0)

        addConstraints([
            svgImageView.bottomAnchor.constraint(lessThanOrEqualTo: imageWrapper.bottomAnchor),
            iconImageView.bottomAnchor.constraint(lessThanOrEqualTo: imageWrapper.bottomAnchor)
            ].compactMap({ $0 }))

        iconSizeConstraints = [
            svgImageView.widthAnchor.constraint(equalToConstant: 30),
            svgImageView.heightAnchor.constraint(equalToConstant: 30),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.heightAnchor.constraint(equalToConstant: 30)]
        addConstraints(iconSizeConstraints)

        svgImageView.setContentHuggingPriority(.required, for: .horizontal)
        iconImageView.setContentHuggingPriority(.required, for: .horizontal)
        primaryTextLabel.setContentHuggingPriority(.required, for: .vertical)
        primaryTextLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        secondaryTextLabel.setContentHuggingPriority(.required, for: .horizontal)
        secondaryTextLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
}
