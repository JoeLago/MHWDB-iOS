//
// MIT License
// Copyright (c) Gathering Hall Studios
//


import UIKit

class WeaponView: TreeCellView<Weapon> {
    var primaryTextLabel = UILabel()
    var subtitleTextLabel = UILabel()
    var sharpnessesView = SharpnesesView()
    var slotsLabel = UILabel()
    var alternateLabel = UILabel()
    
    var weapon: Weapon! {
        didSet {
            populateCell()
        }
    }
    
    override var model: Weapon? {
        get { return weapon }
        set { weapon = newValue! }
    }
    
    override var isSelected: Bool {
        didSet {
            populateSelected()
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func populateCell() {
        primaryTextLabel.text = weapon.name
        sharpnessesView.sharpnesses = nil //weapon.sharpnesses
        populateAttack()
        populateSlots()
        populateAlternate()
    }
    
    private func populateSelected() {
        primaryTextLabel.font = isSelected ? Font.titleBold : Font.title
    }
    
    private func populateAlternate() {
//        if let notes = weapon.noteImageNames {
//            alternateLabel.attributedText = notes.map { $0.attributedImage }.joined(separator: " ")
//        }
//        
//        if let vials = weapon.coatingImageNames {
//            alternateLabel.attributedText = vials.map { $0.attributedImage }.joined(separator: " ")
//        }
    }
    
    private func populateSlots() {
        let slotsString = [weapon.slotOne, weapon.slotTwo, weapon.slotThree]
            .map({ ($0 ?? false) ? "O" : "-" }).joined()
        self.slotsLabel.text = slotsString
    }
    
    private func populateAttack() {
        let attack = NSMutableAttributedString()
        attack.append(string: "\(weapon.attack ?? 0) ")
        
        if weapon.elementAttack ?? 0 > 0 {
            attack.appendImage(named: weapon.element?.imageName ?? "")
            attack.append(string: " \(weapon.elementAttack ?? 0)")
        }
        
        if weapon.awakenAttack ?? 0 > 0 {
            attack.appendImage(named: (weapon.awakenElement?.rawValue ?? "") + ".png")
            attack.append(string: " \(weapon.awakenAttack ?? 0)")
        }
        
        if let defense = weapon.defense, defense > 0 {
            attack.append(string: " \(defense)def")
        }
        
        subtitleTextLabel.attributedText = attack;
    }
    
    func addViews() {
        addSubview(primaryTextLabel)
        addSubview(subtitleTextLabel)
        addSubview(sharpnessesView)
        addSubview(slotsLabel)
        //sharpnessesView.addSubview(alternateLabel)
        
        for view in subviews {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        subtitleTextLabel.font = Font.subTitle
        
        // The text needs to be set or auto-layout doesn't work for some reason
        primaryTextLabel.text = "FIX ME"
        subtitleTextLabel.text = "FIX ME"
        
        slotsLabel.font = UIFont(name: "Courier", size: 14)
        slotsLabel.text = "OOO"
        
        addConstraints(
            formatStrings: ["H:|-[primary]-(>=pad)-[sharpness(==sharpnessWidth)]-|",
                            "H:|-[subtitle(==primary)]-(>=pad)-[slots(==sharpness)]-|",
                            "V:|-(smallPad)-[primary]-(smallPad)-[subtitle]-(smallPad)-|",
                            "V:|-(smallPad)-[sharpness]-(slotsPad)-[slots]-(slotsPad)-|"],
            views: [
                "primary": primaryTextLabel,
                "subtitle": subtitleTextLabel,
                "sharpness": sharpnessesView,
                "slots": slotsLabel
            ],
            metrics: [
                "sharpnessWidth": 75,
                "slotsPad": 3,
                "smallPad": 3,
                "pad": 6
            ])
        
        //alternateLabel.matchParent()
    }
}