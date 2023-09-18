//
//  DogViewModel.swift
//  DogBreeds
//
//  Created by Rahila P on 16/09/23.
//

import SwiftUI

class DogViewModel: ObservableObject {
    @Published var breeds: [DogBreed] = []
    @Published var selectedBreed: String?
    @Published var images: [DogImage] = []

    func fetchDogBreeds() {
        DogAPI.fetchDogBreeds { breeds in
            DispatchQueue.main.async {
                if let breeds = breeds {
                    self.breeds = breeds.map { DogBreed(name: $0) }
                }
            }
        }
    }

    func fetchDogImages() {
        if let selectedBreed = selectedBreed {
            DogAPI.fetchDogImages(for: selectedBreed) { images in
                DispatchQueue.main.async {
                    if let images = images {
                        self.images = images.map { DogImage(url: $0) }
                    }
                }
            }
        }
    }
}

