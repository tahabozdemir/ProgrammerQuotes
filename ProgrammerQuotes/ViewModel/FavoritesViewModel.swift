//
//  FavoritesViewModel.swift
//  ProgrammerQuotes
//
//  Created by Taha Bozdemir on 5.11.2022.
//
import Foundation
import RealmSwift

protocol FavoritesViewModelProtocol{
    var getFavorites: Results<Favorite> {get}
    func deleteRow(indexPath: IndexPath)
    func deleteLastRowConfigure()
}

final class FavoritesViewModel{
    var condition = false
    private var homeViewModel: HomeViewModel
    
    init(homeVM: HomeViewModel){
        homeViewModel = homeVM
    }
}

extension FavoritesViewModel: FavoritesViewModelProtocol{
    var getFavorites: Results<Favorite> {
        return homeViewModel.favoriteQuotes
    }
    
    func deleteRow(indexPath: IndexPath) {
        homeViewModel.deleteFavorite(favorite: getFavorites[indexPath.row])
    }
    
    func deleteLastRowConfigure() {
        homeViewModel.isAddFavorite = false
        homeViewModel.view?.prepareAddFavorites()
    }
}
