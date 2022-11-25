//
//  HomeViewModel.swift
//  ProgrammerQuotes
//
//  Created by Taha Bozdemir on 27.10.2022.
//
import Foundation
import Kingfisher
import RealmSwift

protocol QuoteShowable{
    func viewDidLoad()
    func getQuote()
    func getProfileImage()
}

protocol QuoteEditable{
    func addFavorite(favorite: Favorite)
    func deleteFavorite(favorite: Favorite)
    func addFavoritesToggle()
}

final class HomeViewModel{
    let realm = RealmService.shared.realm
    lazy var favoriteQuotes: Results<Favorite> = realm.objects(Favorite.self)
    weak var view: HomeViewProtocol?
    var imageURLString: String?
    var isAddFavorite: Bool = false
    var quote: Quote?{
        didSet{
            view?.prepareNameAndQuote()
        }
    }
}

extension HomeViewModel: QuoteShowable{
    func viewDidLoad() {
        getQuote()
        getProfileImage()
    }
    
    func getQuote() {
        APICallerQuotes.shared.getRandomQuotes { result in
            switch result{
            case .success(let result):
                self.quote = result
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        isAddFavorite = false
        view?.prepareAddFavorites()
    }
    
    func getProfileImage(){
        guard let author = quote?.author else {return}
        APICallerWiki.shared.getImage(with: author) { [weak self] result in
            switch result {
            case .success(let result):
                let key = Array(result.pages.keys)[0]
                
                if let urlString = result.pages[key]?.thumbnail?.source{
                    self?.imageURLString = urlString
                    self?.view?.prepareProfileImage()
                }
                
                else{
                    self?.imageURLString = ""
                    self?.view?.prepareFailedToGetProfileImage()
                }
                
            case .failure(let error):
                self?.imageURLString = ""
                self?.view?.prepareFailedToGetProfileImage()
                print(error.localizedDescription)
            }
        }
    }
}

extension HomeViewModel: QuoteEditable{
    func addFavorite(favorite: Favorite){
        RealmService.shared.create(favorite)
    }
    
    func deleteFavorite(favorite: Favorite){
        RealmService.shared.delete(favorite)
    }
    
    func addFavoritesToggle() {
        let favorite = Favorite(quote: quote, imageURLString: imageURLString, date: Date())
        
        if isAddFavorite == false{
            isAddFavorite = true
            addFavorite(favorite: favorite)
            view?.prepareAddFavorites()
        }
        
        else{
            isAddFavorite = false
            deleteFavorite(favorite: favoriteQuotes.last!)
            view?.prepareAddFavorites()
        }
    }
}
