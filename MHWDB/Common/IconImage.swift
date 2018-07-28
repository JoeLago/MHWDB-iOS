//
//  IconImage.swift
//  MHWDB
//
//  Created by Joe on 6/30/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import UIKit

class IconImage: UIStackView {
    var id: Int?
    let label = UILabel()
    let icon = UIImageView()
    var selected: ((Int) -> Void)?

    init() {
        super.init(frame: .zero)
        axis = .horizontal
        spacing = 5
        label.textColor = Color.Text.primary
        label.font = Font.title

        let iconWrapper = UIView()
        iconWrapper.addSubview(icon)
        addArrangedSubview(iconWrapper)
        addArrangedSubview(label)

        icon.centerYAnchor.constraint(equalTo: iconWrapper.centerYAnchor).isActive = true
        icon.matchParent(top: nil, left: 0, bottom: nil, right: 0)
        icon.matchParent(top: 0, left: nil, bottom: 0, right: nil, relatedBy: .greaterThanOrEqual)
        icon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 30).isActive = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        addGestureRecognizer(tapGesture)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(id: Int?, iconImage: String?, name: String, selected: ((Int) -> Void)? = nil) {
        self.id = id
        icon.image = iconImage.map { UIImage(named: $0) } ?? nil
        label.text = name
        self.selected = selected
    }

    @objc func handleTap(sender: UITapGestureRecognizer) {
        if let id = id {
            selected?(id)
        }
    }
}
