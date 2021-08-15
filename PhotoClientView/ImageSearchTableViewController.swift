//
//  ImageSearchTableViewController.swift
//  PhotoClientView
//
//  Created by Đinh Văn Nhật on 2019/12/11.
//  Copyright © 2019 Dinh, Nhat. All rights reserved.
//

import UIKit
import PhotoClientViewModel
import RxSwift

public final class ImageSearchTableViewController: UITableViewController {
    public var viewModel: ImageSearchTableViewModeling?

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    public override func viewDidLoad() {
        tableView.register(ImageSearchTableViewCell.self, forCellReuseIdentifier: ImageSearchTableViewCell.identifier)
        self.tableView.prefetchDataSource = self
        self.title = "Pixabay Images"
        viewModel?.startSearch().subscribe(onNext: { models in
            DispatchQueue.main.async {
                self.viewCellModels = models
                self.tableView.reloadData()
            }
        }).disposed(by: disposeBag)
    }

    // MARK: - private variables

    private var disposeBag = DisposeBag()
    private var viewCellModels: [ImageSearchTableViewCellModeling] = []

    private func goImageDetails(_ startedAt: Int) {
        guard
            let imageDetailsViewController = ImageDetailsViewController.instantiate("ImageDetails"),
            let viewModel = self.viewModel else {
            return
        }
        imageDetailsViewController.viewModel = ImageDetailsViewModel(viewModel)
        imageDetailsViewController.startedAt = startedAt
        self.navigationController?.pushViewController(imageDetailsViewController, animated: true)
    }
}

// MARK: - ImageSearchTableViewController datasource

extension ImageSearchTableViewController {
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewCellModels.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ImageSearchTableViewCell.identifier,
            for: indexPath) as! ImageSearchTableViewCell
        cell.viewModel = viewCellModels[indexPath.row]
        cell.getPreviewImage()
        return cell
    }
}

extension ImageSearchTableViewController: UITableViewDataSourcePrefetching {
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print("Prefetch: \(indexPaths)")
        for indexPath in indexPaths {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ImageSearchTableViewCell.identifier,
                for: indexPath) as! ImageSearchTableViewCell
            cell.viewModel = viewCellModels[indexPath.row]
            cell.getPreviewImage()
        }
    }

    public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("Canceling prefetch: \(indexPaths)")
    }
}

// MARK: - ImageSearchTableViewController delegate

extension ImageSearchTableViewController {
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }

    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goImageDetails(indexPath.row)
    }
}
