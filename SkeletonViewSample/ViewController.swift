//
//  ViewController.swift
//  SkeletonViewSample
//
//  Created by jiwon Yoon on 2023/04/03.
//

import UIKit
import SnapKit
import SkeletonView

enum BookSection: CaseIterable {
    case main
}

class ViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(BookCell.self, forCellWithReuseIdentifier: BookCell.identifier)
        
        return collectionView
    }()
    
    private var dataSource: UICollectionViewDiffableDataSource<BookSection, BookData>!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureDataSource()
    }
}

private extension ViewController {
    func setupViews() {
        view.addSubview(collectionView)
        
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let configure = UICollectionViewCompositionalLayoutConfiguration()
        configure.interSectionSpacing = 0
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, layoutEnvironment in
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300)))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        },configuration: configure)
        
        return layout
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCell.identifier, for: indexPath) as? BookCell else { return UICollectionViewCell() }
            
            return cell
        })
        
        applySnapshot()
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<BookSection, BookData>()
        snapshot.appendSections([.main])
        snapshot.appendItems(BookData.allItem)
        
        dataSource.apply(snapshot, animatingDifferences: true)
        
    }
}

