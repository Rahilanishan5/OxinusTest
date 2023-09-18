//
//  DogAPI.swift
//  DogBreeds
//
//  Created by Rahila P on 16/09/23.
//

import Foundation

class DogAPI {
    private static let baseUrl = "https://dog.ceo/api"

    static func fetchDogBreeds(completion: @escaping ([String]?) -> Void) {
        guard let url = URL(string: "\(baseUrl)/breeds/list/all") else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(DogBreedsResponse.self, from: data)
                    completion(response.allBreedNames())
                } catch {
                    print("Error decoding dog breeds: \(error)")
                    completion(nil)
                }
            } else if let error = error {
                print("Error fetching dog breeds: \(error)")
                completion(nil)
            }
        }.resume()
    }

    static func fetchDogImages(for breed: String, completion: @escaping ([URL]?) -> Void) {
        guard let url = URL(string: "\(baseUrl)/breed/\(breed)/images") else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(DogImagesResponse.self, from: data)
                    completion(response.message?.compactMap { URL(string: $0) })
                } catch {
                    print("Error decoding dog images: \(error)")
                    completion(nil)
                }
            } else if let error = error {
                print("Error fetching dog images: \(error)")
                completion(nil)
            }
        }.resume()
    }
}

private struct DogBreedsResponse: Codable {
    let message: [String: [String]]?

    func allBreedNames() -> [String] {
        return message?.keys.sorted() ?? []
    }
}

private struct DogImagesResponse: Codable {
    let message: [String]?
}
