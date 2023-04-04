//
//  TableBookCell.swift
//  SkeletonViewSample
//
//  Created by jiwon Yoon on 2023/04/04.
//

import UIKit
import SnapKit
import SkeletonView

final class TableBookCell: UITableViewCell {
    static let identifier = "TableBookCell"
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        imageView.layer.cornerRadius = 40.0
        imageView.layer.masksToBounds = true
        
        imageView.isSkeletonable = true
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.text = "Title"
        
        label.isSkeletonable = true
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        label.text = "Since version 1.30.0, SkeletonView supports XCFrameworks, so if you want to install it as a XCFramework, please use this repo instead."
        label.numberOfLines = 0
        
        label.isSkeletonable = true
        
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.isSkeletonable = true
        [
            profileImageView,
            titleLabel,
            descriptionLabel
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 16.0
        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(80)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(offset)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(offset)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(titleLabel)
            $0.bottom.equalToSuperview().offset(-offset)
        }
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        self.isSkeletonable = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TableBookCell {
    func setupViews() {
        [
            containerView
        ]
            .forEach {
                contentView.addSubview($0)
            }
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
