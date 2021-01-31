//
//  ViewController.swift
//  CombineSwiftDemo
//
//  Created by Biswajyoti Sahu on 29/01/21.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    var animalData: [Animal] = []
    var animalCancellable: AnyCancellable?
    var actionPublisherCancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableview.register(AnimalTableViewCell.self, forCellReuseIdentifier: "AnimalCell")
        getAnimal()
    }
    
    private func getAnimal() {
        
        let service = AnimalServiceLayer()
        animalCancellable = service.getAnimalData().sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("Publisher stopped observing")
            case .failure(let error):
                print("error passed to our future: \(error)")
            }
        }, receiveValue: { [weak self] animals in
            self?.animalData = animals
            self?.tableview.reloadData()
        })
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return animalData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalCell", for: indexPath) as? AnimalTableViewCell else {
            return UITableViewCell()
        }
        
        cell.fillData(animalData[indexPath.row])
//        cell.delegate = self
//        cell.soundClickExecuted = { [weak self] animal in
//
//            print("\(animal) Sound Clicked")
//        }
        cell.actionPublisher.sink { (action) in
            
            switch action {
            case .showFood(let animal):
                print("Food for \(animal)")
            case .makeSound(let animal):
                print("Sound for \(animal)")
            }
        }.store(in: &actionPublisherCancellable)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
}

extension ViewController: FoodTapDelegate {
    func foodButtonClicked() {
        
        print("Food tapped")
    }
    
}

