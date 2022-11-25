//
//  FavoritesTableViewCell.swift
//  ProgrammerQuotes
//
//  Created by Taha Bozdemir on 5.11.2022.
//

import UIKit

final class FavoritesTableViewCell: UITableViewCell {
    static let identifier = "FavoritesTableViewCell"
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileUIImageView.image = UIImage(named: "placeholderImage")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(profileUIImageView)
        contentView.addSubview(labelName)
        contentView.addSubview(labelDate)
        contentView.addSubview(rightArrowImageView)
        contentView.addSubview(dateAndLabelNameStackView)
        makeResponsiveCircle()
        applyConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dateAndLabelNameStackView.frame = contentView.bounds
        dateAndLabelNameStackView.axis = .vertical
        dateAndLabelNameStackView.distribution = .fillEqually
        dateAndLabelNameStackView.alignment = .center
        dateAndLabelNameStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var profileUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "placeholderImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var labelName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var labelDate: UILabel = {
        let label = UILabel()
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        label.text = formatter.string(from: currentDateTime)
        label.font = UIFont.systemFont(ofSize: 14, weight: .thin)
        label.textColor = .gray
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateAndLabelNameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelName, labelDate])
        stackView.frame = contentView.bounds
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var rightArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.right.circle.fill" ,withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
        imageView.tintColor = .mainColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private func applyConstraints(){
        
        let profileUIImageViewConstraints = [
            profileUIImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileUIImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            profileUIImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width / 4),
            profileUIImageView.heightAnchor.constraint(equalToConstant: contentView.frame.width / 4)
        ]
        
        let rightArrowImageViewConstraints = [
            rightArrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rightArrowImageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -50)
        ]
        
        let labelDateConstraints = [
            labelDate.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            labelDate.heightAnchor.constraint(equalToConstant: contentView.frame.height / 2)
        ]
        
        let labelNameConstraints = [
            labelName.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            labelName.heightAnchor.constraint(equalToConstant: contentView.frame.height / 2)
        ]
        
        let dateAndLabelNameStackViewConstraints = [
            dateAndLabelNameStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dateAndLabelNameStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(profileUIImageViewConstraints)
        NSLayoutConstraint.activate(rightArrowImageViewConstraints)
        NSLayoutConstraint.activate(labelDateConstraints)
        NSLayoutConstraint.activate(labelNameConstraints)
        NSLayoutConstraint.activate(dateAndLabelNameStackViewConstraints)
    }
    
    private func makeResponsiveCircle(){
        profileUIImageView.layer.cornerRadius = contentView.frame.width / 8
    }
}
