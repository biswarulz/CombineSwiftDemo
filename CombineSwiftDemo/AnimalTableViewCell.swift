//
//  AnimalTableViewCell.swift
//  CombineSwiftDemo
//
//  Created by Biswajyoti Sahu on 29/01/21.
//

import UIKit
import Combine

protocol FoodTapDelegate: AnyObject {
    func foodButtonClicked()
}

enum Action {
    
    case showFood(Animal)
    case makeSound(Animal)
}

class AnimalTableViewCell: UITableViewCell {

    var animalLabel: UILabel
    var eatButton: UIButton
    var makeSoundButton: UIButton
    var animalStackView: UIStackView
    weak var delegate: FoodTapDelegate?
    var soundClickExecuted: (Animal) -> () = {_ in }
    private var animal: Animal!
    var actionPublisher = PassthroughSubject<Action, Never>()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        animalLabel = UILabel()
        animalLabel.textColor = .black
        animalLabel.textAlignment = .center
        
        eatButton = UIButton()
        eatButton.setTitleColor(.blue, for: .normal)
        eatButton.setTitle("Food", for: .normal)
        
        makeSoundButton = UIButton()
        makeSoundButton.setTitleColor(.blue, for: .normal)
        makeSoundButton.setTitle("Sound", for: .normal)
        
        animalStackView = UIStackView()
        animalStackView.axis = .horizontal
        animalStackView.distribution = .fillEqually
        animalStackView.addArrangedSubview(animalLabel)
        animalStackView.addArrangedSubview(eatButton)
        animalStackView.addArrangedSubview(makeSoundButton)
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        eatButton.addTarget(self, action: #selector(foodButtonTapped), for: .touchUpInside)
        makeSoundButton.addTarget(self, action: #selector(soundButtonTapped), for: .touchUpInside)

        contentView.addSubViewForAutoLayout([animalStackView])
        
        addCustomConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fillData(_ data: Animal) {
        animal = data
        animalLabel.text = data.rawValue
    }
    
    @objc private func foodButtonTapped() {
        
//        delegate?.foodButtonClicked()
        actionPublisher.send(.showFood(animal))
    }
    
    @objc private func soundButtonTapped() {
        
//        soundClickExecuted(animal)
        actionPublisher.send(.makeSound(animal))
    }
    
    private func addCustomConstraints() {
        
        NSLayoutConstraint.activate([

            animalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            animalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            animalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            animalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}
