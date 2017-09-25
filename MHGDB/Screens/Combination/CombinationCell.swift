//
// MIT License
// Copyright (c) Gathering Hall Studios
//


import UIKit

struct CombinationCellModel {
    var combination: Combination
    var itemSelected: ((Int) -> Void)
}

class IconImage: StackView {
    var id: Int?
    let label = UILabel()
    let icon = UIImageView()
    var selected: ((Int) -> Void)?
    
    init() {
        super.init(axis: .horizontal, spacing: 5)
        label.textColor = Color.Text.primary
        label.font = Font.title
        
        addArrangedSubview(icon)
        addArrangedSubview(label)
        icon.widthConstraint(30)
        icon.heightConstraint(30)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(id: Int?, iconImage: String?, name: String, selected: ((Int) -> Void)? = nil) {
        self.id = id
        icon.image = UIImage(named: iconImage ?? "")
        label.text = name
        self.selected = selected
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if let id = id {
            selected?(id)
        }
    }
}

class CombinationCell: CustomCell<CombinationCellModel> {
    let primaryView = IconImage()
    let item1View = IconImage()
    let item2View = IconImage()
    
    override var model: CombinationCellModel? {
        didSet {
            if let model = model {
                populate(combo: model)
            }
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
        let stack = StackView(axis: .horizontal, spacing: 5)
        let requiredItems = StackView(axis: .vertical, spacing: 5, distribution: .fill)
        let primaryViewWrapper = UIView()
        
        contentView.addSubview(stack)
        primaryViewWrapper.addSubview(primaryView)
        stack.addArrangedSubview(primaryViewWrapper)
        stack.addArrangedSubview(requiredItems)
        requiredItems.addArrangedSubview(item1View)
        requiredItems.addArrangedSubview(item2View)
        
        primaryView.centerVertical()
        primaryView.matchWidth(view: item1View)
        
        primaryView.matchParent(top: 0, left: 0, bottom: 0, right: 0, relatedBy: .greaterThanOrEqual)
        stack.matchParent(top: 5, left: 15, bottom: 5, right: 15)
    }
    
    func getIconView(iconName: String, label: UILabel, action: Selector?) -> UIView {
        let stack = StackView(axis: .horizontal, spacing: 5)
        let tapGesture = UITapGestureRecognizer(target: self, action: action)
        stack.addGestureRecognizer(tapGesture)
        stack.addArrangedSubview(UIImageView(image: UIImage(named: iconName)))
        stack.addArrangedSubview(label)
        return stack
    }
    
    func populate(combo: CombinationCellModel) {
        primaryView.set(id: combo.combination.createdId,
                        iconImage: combo.combination.createdIcon,
                        name: combo.combination.createdName,
                        selected: combo.itemSelected)
        
        item1View.set(id: combo.combination.firstId,
                      iconImage: combo.combination.firstIcon,
                      name: combo.combination.firstName,
                      selected: combo.itemSelected)
        
        item2View.set(id: combo.combination.secondId,
                      iconImage: combo.combination.secondIcon,
                      name: combo.combination.secondName,
                      selected: combo.itemSelected)
    }
}
