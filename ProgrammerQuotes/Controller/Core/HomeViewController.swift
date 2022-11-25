//
//  HomeViewController.swift
//  ProgrammerQuotes
//
//  Created by Taha Bozdemir on 17.10.2022.
//
import UIKit
import Kingfisher

protocol HomeViewProtocol: AnyObject{
    func prepareProfileImage()
    func prepareFailedToGetProfileImage()
    func prepareNameAndQuote()
    func prepareAddFavorites()
}

final class HomeViewController: UIViewController {
    init(homeVM: HomeViewModel?){
        super.init(nibName: nil, bundle: nil)
        viewModel = homeVM
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var viewModel:HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.view = self
        viewModel?.viewDidLoad()
        view.addSubview(greenBackgroundView)
        view.addSubview(profileUIImageView)
        view.addSubview(labelName)
        view.addSubview(bodyQuote)
        view.addSubview(bodyBottom)
        bodyQuote.addSubview(labelQuote)
        bodyQuote.addSubview(buttonMoreAbout)
        bodyBottom.addSubview(buttonAddFavorite)
        bodyBottom.addSubview(buttonNextQuote)
        applyConstraints()
        makeResponsiveCircle()
        applyNavigationBarSettings()
    }
    
    //MARK: Sections
    //Header Section
    private let greenBackgroundView:UIView = {
        let view = UIView()
        view.backgroundColor = .mainColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var profileUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "placeholderImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let labelName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"AvenirNext-DemiBold", size: 14.0)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        label.textAlignment = .center
        label.numberOfLines = 1
        label.backgroundColor = .white
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //Body Section
    private let bodyQuote:UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .softWhiteColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let labelQuote:UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"AvenirNext-Medium", size: 14.0)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        label.numberOfLines = 5
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let buttonMoreAbout:UIButton = {
        let button = UIButton()
        button.setTitle("More about", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name:"AvenirNext-Bold", size: 14.0)
        button.backgroundColor = .mainColor
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(didTapMoreAbout), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //Bottom Section
    private let bodyBottom:UIView = {
        let view = UIView()
        view.backgroundColor = .softWhiteColor
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let buttonAddFavorite:UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50))
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addFavoritesToggle), for: .touchUpInside)
        return button
    }()
    
    private let buttonNextQuote:UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "arrow.backward.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.semanticContentAttribute = .forceRightToLeft
        button.backgroundColor = .mainColor
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(getQuote), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: Apply Constraints
    private func applyConstraints(){
        
        //Header Constraints
        let greenBackgroundViewConstraints = [
            greenBackgroundView.widthAnchor.constraint(equalTo: view.widthAnchor),
            greenBackgroundView.heightAnchor.constraint(equalToConstant: view.frame.height / 4)
        ]
        
        let profileUIImageViewConstraints = [
            profileUIImageView.leadingAnchor.constraint(equalTo: greenBackgroundView.leadingAnchor, constant: 10),
            profileUIImageView.bottomAnchor.constraint(equalTo: greenBackgroundView.bottomAnchor, constant: view.frame.width / 6),
            profileUIImageView.widthAnchor.constraint(equalToConstant: view.frame.width / 3),
            profileUIImageView.heightAnchor.constraint(equalToConstant: view.frame.width / 3)
        ]
        
        let labelNameConstraints = [
            labelName.trailingAnchor.constraint(equalTo: greenBackgroundView.trailingAnchor, constant: -10),
            labelName.bottomAnchor.constraint(equalTo: greenBackgroundView.bottomAnchor,constant: view.frame.width / 12),
            labelName.widthAnchor.constraint(equalToConstant: view.frame.width / 2.1),
            labelName.heightAnchor.constraint(equalToConstant: view.frame.width / 6)
        ]
        
        //Body Constraints
        let bodyQuoteConstraints = [
            bodyQuote.topAnchor.constraint(equalTo: profileUIImageView.bottomAnchor, constant: 10),
            bodyQuote.widthAnchor.constraint(equalToConstant: view.frame.width - 20),
            bodyQuote.heightAnchor.constraint(equalToConstant: view.frame.height / 3),
            bodyQuote.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let labelQuoteConstraints = [
            labelQuote.centerXAnchor.constraint(equalTo: bodyQuote.centerXAnchor),
            labelQuote.centerYAnchor.constraint(equalTo: bodyQuote.centerYAnchor),
            labelQuote.widthAnchor.constraint(equalTo: bodyQuote.widthAnchor, constant: -20)
        ]
        
        let buttonMoreAboutConstraints = [
            buttonMoreAbout.trailingAnchor.constraint(equalTo: bodyQuote.trailingAnchor),
            buttonMoreAbout.bottomAnchor.constraint(equalTo: bodyQuote.bottomAnchor),
            buttonMoreAbout.widthAnchor.constraint(equalToConstant: 140),
            buttonMoreAbout.heightAnchor.constraint(equalToConstant: 30)
        ]
        
        //Bottom Constraints
        let bodyBottomConstraints = [
            bodyBottom.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            bodyBottom.topAnchor.constraint(equalTo: bodyQuote.bottomAnchor, constant: 30),
            bodyBottom.widthAnchor.constraint(equalToConstant: view.frame.width - 20),
            bodyBottom.heightAnchor.constraint(equalToConstant: view.frame.height / 8),
            bodyBottom.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let buttonAddFavoriteConstraints = [
            buttonAddFavorite.leadingAnchor.constraint(equalTo: bodyBottom.leadingAnchor, constant: 20),
            buttonAddFavorite.centerYAnchor.constraint(equalTo: bodyBottom.centerYAnchor),
            buttonAddFavorite.widthAnchor.constraint(equalToConstant: 60),
            buttonAddFavorite.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        let buttonNextQuoteConstraints = [
            buttonNextQuote.trailingAnchor.constraint(equalTo: bodyBottom.trailingAnchor, constant: -20),
            buttonNextQuote.centerYAnchor.constraint(equalTo: bodyBottom.centerYAnchor),
            buttonNextQuote.widthAnchor.constraint(equalToConstant: 120),
            buttonNextQuote.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        NSLayoutConstraint.activate(greenBackgroundViewConstraints)
        NSLayoutConstraint.activate(profileUIImageViewConstraints)
        NSLayoutConstraint.activate(labelNameConstraints)
        NSLayoutConstraint.activate(bodyQuoteConstraints)
        NSLayoutConstraint.activate(labelQuoteConstraints)
        NSLayoutConstraint.activate(buttonMoreAboutConstraints)
        NSLayoutConstraint.activate(bodyBottomConstraints)
        NSLayoutConstraint.activate(buttonAddFavoriteConstraints)
        NSLayoutConstraint.activate(buttonNextQuoteConstraints)
    }
    
    private func makeResponsiveCircle(){
        //print(RealmService.shared.getDatabasePath())
        profileUIImageView.layer.cornerRadius = view.frame.width / 6
    }
    
    private func applyNavigationBarSettings(){
        //Removing Navigation Bar Background
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
    }
    
    //Buttons Functions
    @objc private func addFavoritesToggle(){
        viewModel?.addFavoritesToggle()
    }
    
    @objc private func getQuote(){
        viewModel?.getQuote()
    }
    
    @objc private func didTapMoreAbout(){
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.pushViewController(MoreAboutViewController(quote: self?.viewModel?.quote) , animated: true)
        }
    }
}

//MARK: Preparing HomeViewProtocol
extension HomeViewController: HomeViewProtocol{
    func prepareNameAndQuote() {
        DispatchQueue.main.async { [weak self] in
            guard let safeSelf = self else {return}
            safeSelf.labelName.text = safeSelf.viewModel?.quote?.author
            safeSelf.labelQuote.text = safeSelf.viewModel?.quote?.en
            safeSelf.viewModel?.getProfileImage()
        }
    }
    
    func prepareProfileImage() {
        DispatchQueue.main.async { [weak self] in
            let imageURL = URL(string: self?.viewModel?.imageURLString ?? "")
            self?.profileUIImageView.kf.setImage(with: imageURL, placeholder: UIImage(named: "placeholderImage"),   options: [
                .transition(.fade(0.25))
            ])
        }
    }
    
    func prepareFailedToGetProfileImage() {
        DispatchQueue.main.async { [weak self] in
            self?.profileUIImageView.image = UIImage(named: "placeholderImage")
        }
    }
    
    func prepareAddFavorites() {
        let image = UIImage(systemName: viewModel!.isAddFavorite ? "heart.fill": "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50))
        buttonAddFavorite.setImage(image, for: .normal)
        buttonAddFavorite.tintColor = viewModel!.isAddFavorite ? .red : .black
    }
}

