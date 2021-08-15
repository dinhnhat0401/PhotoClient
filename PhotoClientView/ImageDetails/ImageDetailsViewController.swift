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
    var startedAt: Int = 0
    var timer: Timer?
    let screenSize = UIScreen.main.bounds.size

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        self.edgesForExtendedLayout = []

//        self.imageCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
//        self.imageCollectionView.isPagingEnabled = true
    }

    @objc func goNext() {
        let indexPaths = self.imageCollectionView.indexPathsForVisibleItems.sorted()
        guard let indexPath = indexPaths.last else {
            return
        }

        self.imageCollectionView.isPagingEnabled = false
        self.imageCollectionView.scrollToItem(at: IndexPath(row: indexPath.row + 1, section: indexPath.section), at: .left, animated: true)
        self.imageCollectionView.isPagingEnabled = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateItemSize()

        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(goNext), userInfo: nil, repeats: true)
        timer?.tolerance = 0.2
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateItemSize()
        scrollTo()
    }

    func scrollTo() {
        let indexPath = IndexPath(row: startedAt, section: 0)
        self.imageCollectionView.isPagingEnabled = false
        self.imageCollectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        self.imageCollectionView.isPagingEnabled = true
    }

    func updateItemSize() {
//        let window = UIApplication.shared.windows.first
//        let topPadding = window?.safeAreaInsets.top ?? 0.0
//        let bottomPadding = window?.safeAreaInsets.bottom ?? 0.0

//        let layout = self.imageCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.minimumLineSpacing = 0
//        layout.minimumInteritemSpacing = 0
//        layout.itemSize = CGSize(width: screenSize.width, height: screenSize.height - 100.0)
//        layout.scrollDirection = .horizontal
    }

    // MARK: - private variables

    @IBOutlet private var imageCollectionView: UICollectionView!
    private let sectionInsets = UIEdgeInsets(
      top: 0.0,
      left: 0.0,
      bottom: 0.0,
      right: 0.0)
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

extension ImageDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenSize.width, height: screenSize.height - 100.0)
    }

    func collectionView(
      _ collectionView: UICollectionView,
      layout collectionViewLayout: UICollectionViewLayout,
      insetForSectionAt section: Int
    ) -> UIEdgeInsets {
      return sectionInsets
    }

    // 4
    func collectionView(
      _ collectionView: UICollectionView,
      layout collectionViewLayout: UICollectionViewLayout,
      minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
