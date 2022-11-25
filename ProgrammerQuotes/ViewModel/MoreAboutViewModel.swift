//
//  MoreAboutViewModel.swift
//  ProgrammerQuotes
//
//  Created by Taha Bozdemir on 27.10.2022.
//
import Foundation

protocol MoreAboutViewModelProtocol{
    func getInfoAboutPerson()
}

final class MoreAboutViewModel{
    weak var view: MoreAboutViewProtocol?
    var textAbout: String?
    var quote: Quote?
}

extension MoreAboutViewModel: MoreAboutViewModelProtocol{
    func getInfoAboutPerson(){
        guard let quoteAuthor = quote?.author else {return}
        APICallerWiki.shared.getInfo(with: quoteAuthor) { [weak self] result in
            switch result{
            case .success(let result):
                let key = Array(result.pages.keys)[0]
                guard let textAbout = result.pages[key]?.extract else {return}
                self?.textAbout = textAbout
                self?.view?.prepareGetMoreAboutText()
                self?.view?.prepareGetAuthorName()
                
            case.failure(let error):
                print(error.localizedDescription)
                self?.view?.prepareFailedToGetMoreAboutText()
            }
        }
    }
}
