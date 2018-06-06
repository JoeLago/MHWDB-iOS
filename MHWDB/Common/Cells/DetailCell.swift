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
}

// So that implementation is only required for non nil fields
extension DetailCellModel {
    var primary: String? { return nil }
    var subtitle: String? { return nil }
    var secondary: String? { return nil }
    var imageName: String? { return nil }
}

class DetailCell: UITableViewCell {
    static let identifier = "detailCell"

    let stack = UIStackView(axis: .horizontal, spacing: 6, distribution: .fill)
    let detailStack = UIStackView(axis: .vertical, spacing: 4)
    var primaryTextLabel = UILabel()
    var subtitleTextLabel = UILabel()
    var secondaryTextLabel = UILabel()
    var iconImageView = SVGKFastImageView(frame: .zero)
    var imageWidthConstraint: NSLayoutConstraint?
    var imageHeightConstraint: NSLayoutConstraint?

    var model: DetailCellModel? {
        didSet {
            populateCell()
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
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

        setIcon(named: model.imageName)
        primaryTextLabel.text = model.primary
        subtitleTextLabel.text = model.subtitle
        secondaryTextLabel.text = model.secondary
    }

    func setIcon(named: String?) {
        guard /*let named = named, */let image = SVGKImage(named: "ammo.svg") else {
            hideImage()
            return
        }

        let layer = image.layer(withIdentifier: "color") as? CAShapeLayer
        layer?.fillColor = UIColor.red.cgColor
        iconImageView.image = image
    }

    func hideImage() {
        // TODO: Fix margins
        imageWidthConstraint?.constant = 0
    }

    func addViews() {
        addSubview(stack)
        stack.addArrangedSubview(iconImageView)
        stack.addArrangedSubview(detailStack)
        stack.addArrangedSubview(subtitleTextLabel)
        detailStack.addArrangedSubview(primaryTextLabel)
        detailStack.addArrangedSubview(secondaryTextLabel)

        [iconImageView, detailStack, subtitleTextLabel, primaryTextLabel, secondaryTextLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        subtitleTextLabel.font = Font.subTitle
        subtitleTextLabel.textColor = Color.Text.primary
        subtitleTextLabel.numberOfLines = 0
        secondaryTextLabel.font = Font.title
        secondaryTextLabel.textColor = Color.Text.secondary
        iconImageView.contentMode = .scaleAspectFit

        addConstraints()
    }

    func addConstraints() {
        stack.matchParent(top: 8, left: 8, bottom: 8, right: 8)

        imageWidthConstraint = iconImageView.widthAnchor.constraint(equalToConstant: 50)
        imageHeightConstraint = iconImageView.heightAnchor.constraint(equalToConstant: 50)

        addConstraints([//iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                        imageWidthConstraint,
                        imageHeightConstraint
            ].compactMap({ $0 }))

        primaryTextLabel.setContentHuggingPriority(.required, for: .vertical)
        secondaryTextLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
}
