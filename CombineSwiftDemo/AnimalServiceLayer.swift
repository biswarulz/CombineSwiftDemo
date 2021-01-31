//
//  AnimalServiceLayer.swift
//  CombineSwiftDemo
//
//  Created by Biswajyoti Sahu on 29/01/21.
//

import UIKit
import Combine

enum Animal: String {
    
    case tiger
    case lion
    case horse
    case cat
    case dog
}
class AnimalServiceLayer {
    
    func getAnimalData() -> Future<[Animal], Error> {
        
        return Future { promise in
            
            let animal: [Animal] = [.tiger, .lion, .horse, .cat, .dog]
            promise(.success(animal))
        }
    }
}
