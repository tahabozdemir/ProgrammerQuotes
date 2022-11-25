//
//  MoreAboutViewController.swift
//  ProgrammerQuotes
//
//  Created by Taha Bozdemir on 24.10.2022.
//
import UIKit
import SwiftUI

protocol MoreAboutViewProtocol: AnyObject{
    func prepareGetMoreAboutText()
    func prepareFailedToGetMoreAboutText()
    func prepareGetAuthorName()
}

final class MoreAboutViewController: UIViewController {
    public lazy var viewModel = MoreAboutViewModel()
    
    init(quote: Quote?){
        super.init(nibName: nil, bundle: nil)
        viewModel.quote = quote
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let greenBackgroundView:UIView = {
        let view = UIView()
        view.backgroundColor = .mainColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let bodyAbout:UIScrollView = {
        let view = UIScrollView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    private let labelAbout:UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"AvenirNext-Medium", size: 12.0)
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
        viewModel.view = self
        view.addSubview(bodyAbout)
        view.addSubview(greenBackgroundView)
        view.addSubview(labelName)
        bodyAbout.addSubview(labelAbout)
        applyResponsive()
        applyConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getInfoAboutPerson()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        labelAbout.text = ""
        bodyAbout.setContentOffset(.zero, animated: true)
    }
    
    private func applyConstraints(){
        let greenBackgroundViewConstraints = [
            greenBackgroundView.widthAnchor.constraint(equalTo: view.widthAnchor),
            greenBackgroundView.heightAnchor.constraint(equalToConstant: view.frame.height * (1/3))
        ]
        
        let bodyAboutConstraints = [
            bodyAbout.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bodyAbout.widthAnchor.constraint(equalTo: view.widthAnchor),
            bodyAbout.heightAnchor.constraint(equalToConstant: view.frame.height * (2/3))
        ]
        
        let labelAboutConstraints = [
            labelAbout.topAnchor.constraint(equalTo: bodyAbout.topAnchor, constant: 100),
            labelAbout.widthAnchor.constraint(equalTo: bodyAbout.widthAnchor, constant: -20),
            labelAbout.centerXAnchor.constraint(equalTo: bodyAbout.centerXAnchor)
        ]
        
        let labelNameConstraints = [
            labelName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelName.centerYAnchor.constraint(equalTo: greenBackgroundView.centerYAnchor, constant: 50),
            labelName.widthAnchor.constraint(equalToConstant: view.frame.width / 1.5),
            labelName.heightAnchor.constraint(equalToConstant: view.frame.width / 6)
        ]
        
        NSLayoutConstraint.activate(greenBackgroundViewConstraints)
        NSLayoutConstraint.activate(bodyAboutConstraints)
        NSLayoutConstraint.activate(labelAboutConstraints)
        NSLayoutConstraint.activate(labelNameConstraints)
    }
    
    private func applyResponsive(){
        bodyAbout.contentSize.height = view.frame.height + 120
    }
}

extension MoreAboutViewController: MoreAboutViewProtocol{
    func prepareGetAuthorName() {
        DispatchQueue.main.async { [weak self] in
            guard let authorName = self?.viewModel.quote?.author else {return}
            self?.labelName.text = authorName
        }
    }
    
    func prepareGetMoreAboutText() {
        DispatchQueue.main.async { [weak self] in
            guard let aboutText = self?.viewModel.textAbout else {return}
            self?.labelAbout.text = String(htmlEncodedString: aboutText)
        }
    }
    func prepareFailedToGetMoreAboutText() {
        DispatchQueue.main.async { [weak self] in
            self?.labelName.text = self?.viewModel.quote?.author
            self?.labelAbout.text = String("No information about this person.")
        }
    }
}


