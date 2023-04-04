//
//  BookTableViewController.swift
//  SkeletonViewSample
//
//  Created by jiwon Yoon on 2023/04/04.
//

import UIKit
import SnapKit
import SkeletonView

final class BookTableViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        
        tableView.register(
            TableBookCell.self,
            forCellReuseIdentifier: TableBookCell.identifier
        )
        
        tableView.isSkeletonable = true
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.showAnimatedGradientSkeleton()
    }
}

extension BookTableViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return TableBookCell.identifier
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
}

extension BookTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableBookCell.identifier, for: indexPath) as? TableBookCell else { return UITableViewCell() }
        
        return cell
    }
}

private extension BookTableViewController {
    func setupViews() {
        [
            tableView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
