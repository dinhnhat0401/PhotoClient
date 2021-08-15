//
//  ImageDetailsViewController.swift
//  PhotoClientView
//
//  Created by Đinh Văn Nhật on 2021/08/13.
//  Copyright © 2021 Dinh, Nhat. All rights reserved.
//

import Foundation
import PhotoClientViewModel
import UIKit

class ImageDetailsViewController: UIViewController, Storyboarded {
    var itemsPerRow: Int = 1
    var viewModel: ImageDetailsViewModeling?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        self.imageCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateItemSize()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateItemSize()
    }

    func updateItemSize() {
        let window = UIApplication.shared.windows.first
        let topPadding = window?.safeAreaInsets.top ?? 0.0
        let bottomPadding = window?.safeAreaInsets.bottom ?? 0.0

        let layout = self.imageCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        layout.itemSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height - topPadding - bottomPadding)
    }

    // MARK: - private variables

    @IBOutlet private var imageCollectionView: UICollectionView!
}

extension ImageDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.viewCellModels?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageDetailsCollectionViewCell.identifier, for: indexPath) as? ImageDetailsCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.viewModel = viewModel?.viewCellModels?[indexPath.row]
        cell.getImage()
        return cell
    }
}

extension ImageDetailsViewController: UICollectionViewDelegate {

}
