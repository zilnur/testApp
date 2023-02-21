//
//  FavoriteNewsCollectionViewCell.swift
//  TestApp
//
//  Created by Ильнур Закиров on 19.02.2023.
//

import UIKit

class FavoriteNewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    var removeNews: ((UIButton) -> Void)?
    
    func configProperties(news: NewsModel, removeNews: @escaping (UIButton) -> Void) {
        newsImageView.image = UIImage(named: news.image)
        titleLabel.text = news.title
        likeButton.setImage(news.isLiked ? UIImage(named: "favorite.fill") : UIImage(named: "favorite"), for: .normal)
        dateLabel.text = news.date
        self.removeNews = removeNews
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    @objc func likeButtonTapped() {
        guard let closure = removeNews else { return }
        closure(likeButton)
    }
}
