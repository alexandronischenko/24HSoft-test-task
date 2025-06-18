//
//  PhotoViewController.swift
//  24HSoft
//
//  Created by Alexandr Onischenko on 17.06.2025.
//

import UIKit
import Kingfisher

class PhotoViewController: UIViewController {

    private var titleLabel: UILabel = {
        var view = UILabel()
        view.font = .systemFont(ofSize: 16, weight: .semibold)
        view.textColor = .black
        return view
    }()

    private var photoView: UIImageView = {
        var view = UIImageView()
        return view
    }()

    var viewModel: PhotoViewModelProtocol

    init(viewModel: PhotoViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        setupConstraints()
    }

    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(photoView)

        photoView.kf.indicatorType = .activity

        title = viewModel.username ?? "Somebody That I Used to Know"

        photoView.kf.setImage(
            with: URL(string: viewModel.photoUrl),
            options: [
                .cacheSerializer(DefaultCacheSerializer.default),
                .targetCache(ImageCache.default),
                .waitForCache,
                .cacheOriginalImage
            ],
            completionHandler: { [weak self] result in
                switch result {
                case .success(let value):
                    break
                case .failure(let error):
                    let alertModel = AlertControllerModel.createErrorAlertModel()
                    let alertController = UIAlertController.createAlertContoller(with: alertModel)
                    self?.present(alertController, animated: true)
                }
            }
        )
    }

    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = .clear
        appearance.backgroundColor = .white

        // Title
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
    }

    private func setupConstraints() {
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.contentMode = .scaleAspectFit
        photoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        photoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        photoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        photoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}
