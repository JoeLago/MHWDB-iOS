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
    var armor: [Armor]
}

class ArmorSetCell: CustomCell<ArmorSetCellModel> {
    let label = UILabel()
    let mainStack = UIStackView(axis: .horizontal, spacing: 3, distribution: .fillProportionally)
    let leftStack = UIStackView(axis: .vertical, spacing: 3)
    let rightStack = UIStackView(axis: .vertical, spacing: 3)
    let iconStack = UIStackView(axis: .horizontal, spacing: -12)
    let slotStack = UIStackView(axis: .horizontal, spacing: 3)
    var icons = [UIView]()
    let defenseLabel = SvgLabel()
    let levelOneSlotLabel = SvgLabel()
    let levelTwoSlotLabel = SvgLabel()
    let levelThreeSlotLabel = SvgLabel()

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
        defenseLabel.label.font = Font.subTitle
        defenseLabel.label.textColor = Color.Text.secondary

        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        addSubview(mainStack)
        mainStack.matchParent(top: 10, left: 15, bottom: 10, right: 15)

        leftStack.addArrangedSubview(label)
        leftStack.addArrangedSubview(slotStack)

        rightStack.addArrangedSubview(Wrapper(iconStack))
        rightStack.addArrangedSubview(defenseLabel)

        defenseLabel.label.setContentHuggingPriority(.required, for: .horizontal)

        slotStack.addArrangedSubview(levelOneSlotLabel)
        slotStack.addArrangedSubview(levelTwoSlotLabel)
        slotStack.addArrangedSubview(levelThreeSlotLabel)
        slotStack.addArrangedSubview(UIView())

        mainStack.addArrangedSubview(leftStack)
        mainStack.addArrangedSubview(rightStack)
    }

    func populate(model: ArmorSetCellModel) {
        icons.forEach { $0.removeFromSuperview() }

        label.text = model.label

        let armor = model.armor[0]
        defenseLabel.configure(svgModel: SVGImageModel(name: "ui_defense.svg"), text: "\(armor.defense) - \(armor.defenseMax) (\(armor.defenseAugment)) x\(model.armor.count)", size: 18)

        configureSlotLabel(model: model, socketLevel: .one, slotLabel: levelOneSlotLabel, imageName: "ui_slot_1_empty.svg")
        configureSlotLabel(model: model, socketLevel: .two, slotLabel: levelTwoSlotLabel, imageName: "ui_slot_2_empty.svg")
        configureSlotLabel(model: model, socketLevel: .three, slotLabel: levelThreeSlotLabel, imageName: "ui_slot_3_empty.svg")

        // inefficient, lets keep reference to each image
        icons = [UIView]()
        for svgModel in model.armor.compactMap({ $0.svgModel }) {
            guard let imageView = SvgModelView(model: svgModel) else { continue }
            imageView.heightAnchor.constraint(equalToConstant: 26).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 26).isActive = true
            icons.append(imageView)
        }
        iconStack.addArrangedSubviews(icons)
    }

    func configureSlotLabel(model: ArmorSetCellModel, socketLevel: Armor.SocketLevel, slotLabel: SvgLabel, imageName: String) {
        var count = 0
        model.armor.forEach {
            count += ($0.socketOne == socketLevel) ? 1 : 0
            count += ($0.socketTwo == socketLevel) ? 1 : 0
            count += ($0.socketThree == socketLevel) ? 1 : 0
        }

        if count > 0 {
            slotLabel.isHidden = false
            slotLabel.label.font = Font.subTitle
            slotLabel.label.textColor = Color.Text.secondary
            slotLabel.configure(svgModel: SVGImageModel(name: imageName), text: "x\(count)", size: 22)
        } else {
            slotLabel.isHidden = true
        }
    }
}

class Wrapper: UIView {
    init(_ subView: UIView) {
        super.init(frame: .zero)
        addSubview(subView)
        subView.matchParent(relatedBy: .greaterThanOrEqual)
        subView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
