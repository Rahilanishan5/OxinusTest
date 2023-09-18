//
//  DogBreedsView.swift
//  DogBreeds
//
//  Created by Rahila P on 16/09/23.
//

import SwiftUI

struct DogBreedsView: View {
    @ObservedObject var viewModel: DogViewModel

    var body: some View {
        NavigationView {
            List(viewModel.breeds) { breed in
                NavigationLink(destination: DogImagesView(viewModel: viewModel, breedName: breed.name)) {
                    Text(breed.name)
                }
            }
            .navigationTitle("Dog Breeds")
        }
        .onAppear {
            viewModel.fetchDogBreeds()
        }
    }
}

struct DogImagesView: View {
    @ObservedObject var viewModel: DogViewModel
    let breedName: String

    var body: some View {
        VStack {
            List(viewModel.images) { image in
                DogImageView(imageURL: image.url)
            }
            .listStyle(PlainListStyle())

            Button(action: {
                viewModel.fetchDogImages()
            }) {
                Text("Refresh Images")
            }
            .padding()
        }
        .navigationTitle(breedName.capitalized)
        .onAppear {
            viewModel.selectedBreed = breedName
            viewModel.fetchDogImages()
        }
    }
}

struct DogImageView: View {
    let imageURL: URL

    var body: some View {
        AsyncImage(url: imageURL) { image in
            image.resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .cornerRadius(10)
        } placeholder: {
            ProgressView()
        }
    }
}

struct ContentView: View {
    @StateObject private var viewModel = DogViewModel()

    var body: some View {
        DogBreedsView(viewModel: viewModel)
    }
}
