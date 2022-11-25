//
//  FavoriteDetailViewController.swift
//  ProgrammerQuotes
//
//  Created by Taha Bozdemir on 11.11.2022.
//

import UIKit

final class FavoriteDetailViewController: UIViewController {
    private var quotePage: Quote?
    
    init(quote: Quote?){
        super.init(nibName: nil, bundle: nil)
        quotePage = quote
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let bodyQuote:UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .softWhiteColor
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var labelQuote:UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"AvenirNext-Medium", size: 14.0)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(bodyQuote)
        view.backgroundColor = .white
        bodyQuote.addSubview(labelQuote)
        applyConstraints()
        labelQuote.text = quotePage?.en
    }
    
    
    private func applyConstraints(){
        
        let bodyQuoteConstraints = [
            bodyQuote.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bodyQuote.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            bodyQuote.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -20),
            bodyQuote.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, constant: -20)
        ]
        
        let labelQuoteConstraints = [
            labelQuote.centerXAnchor.constraint(equalTo: bodyQuote.centerXAnchor),
            labelQuote.centerYAnchor.constraint(equalTo: bodyQuote.centerYAnchor),
            labelQuote.widthAnchor.constraint(equalTo: bodyQuote.safeAreaLayoutGuide.widthAnchor, constant: -20),
            labelQuote.heightAnchor.constraint(equalTo: bodyQuote.safeAreaLayoutGuide.heightAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(bodyQuoteConstraints)
        NSLayoutConstraint.activate(labelQuoteConstraints)
    }
}
