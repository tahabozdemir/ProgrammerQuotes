//
//  FavoritesViewController.swift
//  ProgrammerQuotes
//
//  Created by Taha Bozdemir on 17.10.2022.
//
import UIKit
import Kingfisher

final class FavoritesViewController: UIViewController {
    private var viewModel:FavoritesViewModel?
    
    init(favoritesVM: FavoritesViewModel){
        super.init(nibName: nil, bundle: nil)
        viewModel = favoritesVM
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let favoritesTable: UITableView = {
        let table = UITableView()
        table.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        favoritesTable.delegate = self
        favoritesTable.dataSource = self
        favoritesTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        view.addSubview(favoritesTable)
        navigationController?.navigationBar.tintColor = .mainColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.favoritesTable.reloadData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        favoritesTable.frame = view.bounds
    }
}

extension FavoritesViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getFavorites.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.identifier) as? FavoritesTableViewCell else {return UITableViewCell()}
        cell.labelName.text = viewModel?.getFavorites[indexPath.row].quote?.author
        let imageURL = URL(string: viewModel?.getFavorites[indexPath.row].imageURLString ?? "")
        cell.profileUIImageView.kf.setImage(with:imageURL)
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .medium
        cell.labelDate.text = formatter.string(from: (viewModel?.getFavorites[indexPath.row].date)!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle{
        case .delete :
            let totalRows = tableView.numberOfRows(inSection: indexPath.section)
            viewModel?.deleteRow(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            if(indexPath.row == totalRows - 1){
                viewModel?.deleteLastRowConfigure()
            }
            
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = FavoriteDetailViewController(quote: viewModel?.getFavorites[indexPath.row].quote)
        navigationController?.pushViewController(vc, animated: true)
    }
}


