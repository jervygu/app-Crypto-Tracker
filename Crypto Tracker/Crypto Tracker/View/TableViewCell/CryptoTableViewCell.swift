//
//  CryptoTableViewCell.swift
//  Crypto Tracker
//
//  Created by Jervy Umandap on 8/20/21.
//

import UIKit

//struct CryptoTableViewCellViewModel {
//    let name: String
//    let symbol: String
//    let price: String
//    let iconUrl: URL?
//}


class CryptoTableViewCellViewModel {
    let name: String
    let symbol: String
    let price: String
    let iconUrl: URL?
    var iconData: Data?
    
    init(name: String, symbol: String, price: String, iconUrl: URL?) {
        self.name = name
        self.symbol = symbol
        self.price = price
        self.iconUrl = iconUrl
    }
}

class CryptoTableViewCell: UITableViewCell {
    static let identifier = "CryptoTableViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor  = .systemGreen
        label.textAlignment = .right
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
//        imageView.backgroundColor = .red
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(iconImageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.sizeToFit()
        symbolLabel.sizeToFit()
        priceLabel.sizeToFit()
        
        let size: CGFloat = contentView.height/1.1
        
        nameLabel.frame = CGRect(x: iconImageView.right + 5,
                                 y: 0,
                                 width: contentView.width * 0.33,
                                 height: contentView.height/2)
//        nameLabel.backgroundColor = .purple
        
        symbolLabel.frame = CGRect(x: iconImageView.right + 5,
                                   y: contentView.height/2,
                                   width: contentView.width * 0.33,
                                   height: contentView.height/2)
//        symbolLabel.backgroundColor = .systemTeal
        
        priceLabel.frame = CGRect(x: contentView.width * 0.33,
                                  y: 0,
                                  width: (contentView.width * 0.66) - 16,
                                  height: contentView.height)
//        priceLabel.backgroundColor = .green
        
        iconImageView.frame = CGRect(x: 16,
                                     y: (contentView.height-size)/2,
                                     width: size,
                                     height: size)
    }
    
    // name
    
    // symbol
    
    // price
    
    // config
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        symbolLabel.text = nil
        priceLabel.text = nil
        iconImageView.image = nil
    }
    
    func configure(with viewModel: CryptoTableViewCellViewModel) {
        nameLabel.text = viewModel.name
        symbolLabel.text = viewModel.symbol
        priceLabel.text = viewModel.price
        
        if let data = viewModel.iconData {
            iconImageView.image = UIImage(data: data)
        } else {
            if let url = viewModel.iconUrl {
                let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                    if let data = data {
                        viewModel.iconData = data
                        DispatchQueue.main.async {
                            self?.iconImageView.image = UIImage(data: data)
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
    
    
}
