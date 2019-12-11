//
//  ImageSearchTableViewController.swift
//  PhotoClientView
//
//  Created by Đinh Văn Nhật on 2019/12/11.
//  Copyright © 2019 Dinh, Nhat. All rights reserved.
//

import UIKit
import PhotoClientViewModel

public final class ImageSearchTableViewController: UITableViewController {

    public var viewModel: ImageSearchTableViewModeling?

    public override func viewDidLoad() {
        self.title = "Pixabay Images"
    }
}

// MARK: - ImageSearchTableViewController datasource

extension ImageSearchTableViewController {
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return ImageSearchTableViewCell()
    }
}
