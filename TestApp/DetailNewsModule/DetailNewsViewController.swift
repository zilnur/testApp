//
//  DetailNewsViewController.swift
//  TestApp
//
//  Created by Ильнур Закиров on 20.02.2023.
//

import UIKit

class DetailNewsViewController: UIViewController {
    
    let newsImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .lightGray
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.layer.cornerRadius = 20
        return view
    }()
    
    let dateLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 13)
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        view.numberOfLines = 0
        return view
    }()
    
    let newsTextLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 13)
        view.numberOfLines = 0
        return view
    }()
    
    lazy var likeButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage(systemName: "heart"), for: .normal)
        view.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        view.tintColor = .gray
        return view
    }()
    
    
    var saveNewsClosure: ((UIButton) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        [newsImageView, dateLabel, titleLabel, newsTextLabel, likeButton].forEach(view.addSubview(_:))
        
        [newsImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
         newsImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         newsImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
         newsImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: setImageViewHeight()),
         
         dateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
         dateLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 15),
         
         titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
         titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 15),
         titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
         
         newsTextLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
         newsTextLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
         newsTextLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
         
         likeButton.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 14),
         likeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -23)
        ].forEach({$0.isActive = true})
    }
    
    //расчитывает высоту изображения
    func setImageViewHeight() -> CGFloat {
        guard let image = newsImageView.image else { return 132 }
        let ratio = image.size.width / image.size.height
        let newHeight = view.frame.width / ratio
        return newHeight
    }
    
    //наполняет элементы данными
    func configProperties(model: NewsModel, saveNewsClosure: @escaping (UIButton) -> Void) {
        newsImageView.image = UIImage(named: model.image)
        dateLabel.text = model.date
        titleLabel.text = model.title
        newsTextLabel.text = model.description
        likeButton.setImage(model.isLiked ? UIImage(named: "favorite.fill") : UIImage(named: "favorite"), for: .normal)
        self.saveNewsClosure = saveNewsClosure
    }
    
    @objc func likeButtonTapped() {
        guard let closure = saveNewsClosure else { return }
        closure(likeButton)
    }
}
