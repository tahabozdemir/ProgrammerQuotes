//
//  APICallerQuotes.swift
//  ProgrammerQuotes
//
//  Created by Taha Bozdemir on 22.10.2022.
//

import Foundation

struct ConstantsQuotes{
    static let randomQuotesURL = "https://programming-quotes-api.herokuapp.com/quotes/random"
}

enum APIErrorQuotes: Error {
    case failedToGetData
}

final class APICallerQuotes {
    static let shared = APICallerQuotes()
    
    func getRandomQuotes(completion: @escaping (Result<Quote, Error>) -> Void) {
        guard let url = URL(string: ConstantsQuotes.randomQuotesURL) else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(Quote.self, from: data)
                completion(.success(results))
            }
            catch {
                completion(.failure(APIErrorQuotes.failedToGetData))
            }
        }
        task.resume()
    }
}
