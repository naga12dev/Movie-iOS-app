//
//  ApiManager.swift
//  MovieBrowser
//
//  Created by mounika on 5/27/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation
enum AppErrors: Error {
    case badURL
    case serverError
    case parsingError
    case emptyMovieName
    
    //Error Messages
    
    var detail: String {
        switch self {
        case .badURL:
             return "The URl that we are trying to fetch is improper"
        case .serverError:
             return "Failed to fetch data from server"
        case .parsingError:
            return "Error in parsing the json data"
        case .emptyMovieName:
            return "The movie name cant be empty"
        }
    }
}

class ApiManager {
    static let manager = ApiManager()
    let session = URLSession.shared
    private init() {}
    //Network Call
    func getData(movieName: String, completion:@escaping (Result<Page, AppErrors>) -> Void) {
        if movieName.count == 0 {
            completion(.failure(.emptyMovieName))
            return
        }
        
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(Constants.apikey)&language=en-US&query=\(movieName.replacingOccurrences(of: " ", with: "+" ))&page=1&include_adult=false") else {
            completion(.failure(.badURL))
            return
        }
        
        session.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.parsingError))
                return
            }
            
            if let receivedData = data {
                do  {
                    let movieDetails = try JSONDecoder().decode(Page.self, from: receivedData)
                    completion(.success(movieDetails))
                } catch  {
                    completion(.failure(.serverError))
                }
            }
        }.resume()
    }
    
    // Downloading the image
     func downloadImage(url: String, completionHandler: @escaping (Result<(Data, String), AppErrors>) -> Void) {
         guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(url)") else {
             completionHandler(.failure(.badURL))
             return
         }
         
         session.dataTask(with: imageUrl) { (receivedData, receivedResponse, receivedError) in
             if let data = receivedData {
                 completionHandler(.success((data, url)))
             } else {
                 completionHandler(.failure(.serverError))
             }
         }.resume()
     }
}
