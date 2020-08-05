//
//  UserInfoTableViewCell.swift
//  TechMahindra Demo
//
//  Created by Subba Reddy on 8/4/20.
//  Copyright © 2020 Subba Reddy. All rights reserved.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {
    private var task: URLSessionDataTask?
    
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    let profileImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        
        img.layer.cornerRadius = 5
        img.clipsToBounds = true
        return img
    }()
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor =  .white
        label.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
        task = nil
        self.titleLabel.text = ""
        self.descriptionLabel.text = ""
        self.profileImageView.image = nil
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(profileImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        self.contentView.addSubview(containerView)
        
        //profileImageView
        profileImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant:100).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant:100).isActive = true
        
        //containerView
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.profileImageView.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant:  140).isActive = true
        
        //titleLabel
        titleLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
        //descriptionLabel
        descriptionLabel.topAnchor.constraint(equalTo:self.titleLabel.bottomAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func updateCellData(userInfo:UserModel) {
        self.titleLabel.text = userInfo.title ?? ""
        self.descriptionLabel.text = userInfo.description ?? ""
        
        if userInfo.imageHref != nil {
            ImageService.getImage(withURl: URL(string: userInfo.imageHref ?? "")!) { (image) in
                DispatchQueue.main.async { [weak  self] in
                    self?.profileImageView.image = image
                }
            }
        }
    }
}
