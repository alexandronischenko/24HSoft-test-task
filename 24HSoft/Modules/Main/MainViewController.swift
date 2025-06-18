//
//  MainViewController.swift
//  24HSoft
//
//  Created by Alexandr Onischenko on 17.06.2025.
//

import UIKit

class MainViewController: UIViewController {

    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .white
        return cv
    }()

    var viewModel: MainViewModelProtocol

    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupNavigationBar()
        setupCollectionView()
        setupConstraints()
        setupBindings()
        viewModel.viewDidLoad()
    }

    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(collectionView)

        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .black
        refreshControl.addTarget(self, action: #selector(refreshControlTriggered), for: .valueChanged)

        collectionView.addSubview(refreshControl)
        collectionView.refreshControl = refreshControl
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
        title = "Photos"
    }

    private func setupCollectionView() {
        let nibName = String(describing: CollectionViewCell.self)
        collectionView.register(
            UINib(nibName: nibName, bundle: nil),
            forCellWithReuseIdentifier: CollectionViewCellViewModel.reuseIdentifer
        )

        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: collectionView.superview!.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: collectionView.superview!.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: collectionView.superview!.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: collectionView.superview!.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }

    private func setupBindings() {
        viewModel.onShowAlert = { [weak self] model in
            let alert = UIAlertController(
                title: model.title,
                message: model.description,
                preferredStyle: .alert
            )
            let action = UIAlertAction(
                title: model.items.first?.title,
                style: .default
            )
            alert.addAction(action)
            self?.present(alert, animated: true)
        }
        viewModel.didLoadData = { [weak self] in
            guard let self else {  return  }
            self.collectionView.reloadData()
            if self.collectionView.refreshControl?.isRefreshing == true {
                self.collectionView.refreshControl?.endRefreshing()
            }
        }
    }

    @objc
    private func refreshControlTriggered() {
        viewModel.loadData(isRefresh: true)
    }
}

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sectionViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        viewModel.sectionViewModels[section].cellViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellViewModel = viewModel.sectionViewModels[indexPath.section].cellViewModels[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellViewModel.reuseIdentifier,
                                                      for: indexPath)
        if let configurableCell = cell as? ConfigurableCollectionViewCell {
            configurableCell.configure(viewModel: cellViewModel)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        viewModel.sectionViewModels[indexPath.section].cellViewModels[indexPath.item].actionBlock?()
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width
        return CGSize(width: size, height: 100 + 32)
    }
}

