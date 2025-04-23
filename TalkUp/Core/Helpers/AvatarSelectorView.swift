//
//  AvatarSelectorView.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 22.04.25.
//

import UIKit

final class AvatarSelectorView: UIView {

    let imageView = UIImageView()
    private let placeholderImage = UIImage(systemName: "person.crop.circle.fill")?.withRenderingMode(.alwaysTemplate)

    var onImagePicked: ((UIImage) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        
        imageView.image = placeholderImage
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.systemGray4.cgColor
        imageView.isUserInteractionEnabled = true

        addSubview(imageView)

        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)

        let tap = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(tap)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = bounds.width / 2
    }

    @objc private func selectImage() {
        guard let vc = self.findViewController() else { return }
        let picker = UIImagePickerController()
        picker.delegate = vc as? (UIImagePickerControllerDelegate & UINavigationControllerDelegate)
        picker.sourceType = .photoLibrary
        vc.present(picker, animated: true)
    }

    func setImage(_ image: UIImage) {
        imageView.image = image
    }
    
}

