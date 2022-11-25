//
//  APICallerWiki.swift
//  ProgrammerQuotes
//
//  Created by Taha Bozdemir on 22.10.2022.
//

import Foundation

struct ConstantsWiki{
    static let wikiBaseURL = "https://en.wikipedia.org/w/api.php?action=query&titles"
}

enum APIErrorWiki: Error{
    case failedToGetData
}

final class APICallerWiki{
    static let shared = APICallerWiki()
    
    func getImage(with query: String, completion: @escaping(Result<Query, Error>) -> Void ){
        guard let query  = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(ConstantsWiki.wikiBaseURL)=\(query)&prop=pageimages&format=json&pithumbsize=250") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            do{
                let results = try JSONDecoder().decode(Wiki.self,from: data)
                completion(.success(results.query))
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getInfo(with query: String, completion: @escaping(Result<Query, Error>) -> Void ){
        guard let query  = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(ConstantsWiki.wikiBaseURL)=\(query)&prop=extracts&format=json&exintro=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            do{
                let results = try JSONDecoder().decode(Wiki.self,from: data)
                completion(.success(results.query))
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}
