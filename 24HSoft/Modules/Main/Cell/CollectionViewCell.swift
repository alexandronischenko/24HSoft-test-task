//
//  CollectionViewCell.swift
//  24HSoft
//
//  Created by Alexandr Onischenko on 17.06.2025.
//

import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likesStackView: UIStackView!
    @IBOutlet weak var likesLabel: UILabel!

    private var actionBlock: (() -> Void)?

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(
                withDuration: 0.2,
                delay: 0,
                usingSpringWithDamping: 0.7,
                initialSpringVelocity: 0.5,
                options: [.allowUserInteraction]
            ) {
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.95, y: 0.95) : .identity
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configureTapGesture()
    }

    @objc private func handleTap() {
        actionBlock?()
    }

    private func configureDescription(description: String?, descriptionColorName: String?) {
        descriptionLabel.text = description
        descriptionLabel.numberOfLines = 2
        descriptionLabel.lineBreakMode = .byTruncatingTail
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        if let descriptionColorName = descriptionColorName {
            descriptionLabel.textColor = UIColor(hex: descriptionColorName)
        }
    }



    private func configurePhoto(photoPath: String?) {
        if let photoPath = photoPath,
           let url = URL(string: photoPath) {
            photoImageView.kf.indicatorType = .activity

            // Only in such a combination processors the desired behavior is achieved
            let size = CGSize(width: 100, height: 100)
            let resizeProcessor = ResizingImageProcessor(referenceSize: size, mode: .aspectFill)
            let cropProcessor = CroppingImageProcessor(size: size, anchor: CGPoint(x: 0.5, y: 0.5))
            let roundProcessor = RoundCornerImageProcessor(cornerRadius: 20, targetSize: size)

            photoImageView.kf.setImage(
                with: url,
                options: [
                    .processor(resizeProcessor |> cropProcessor |> roundProcessor),
                    .cacheSerializer(FormatIndicatedCacheSerializer.png),
                    .targetCache(ImageCache.default),
                    .waitForCache,
                    .cacheOriginalImage
                ]
            )
        }
    }

    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        photoImageView.isUserInteractionEnabled = true
        photoImageView.addGestureRecognizer(tapGesture)
    }
}

extension CollectionViewCell: ConfigurableCollectionViewCell {
    func configure(viewModel: any CellViewModel) {
        guard let viewModel = viewModel as? CollectionViewCellViewModel else { return }
        configureDescription(
            description: viewModel.description,
            descriptionColorName: viewModel.descriptionColorName
        )
        configurePhoto(photoPath: viewModel.photoName)
        likesLabel.text = String(viewModel.likes ?? 0)
        self.actionBlock = viewModel.actionBlock
    }
}
