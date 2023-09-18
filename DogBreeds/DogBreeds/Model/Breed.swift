//
//  Breed.swift
//  DogBreeds
//
//  Created by Rahila P on 15/09/23.
//

import Foundation


struct DogBreed: Identifiable {
    let id = UUID()
    let name: String
}

struct DogImage: Identifiable {
    let id = UUID()
    let url: URL
}
