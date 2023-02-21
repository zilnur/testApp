//
//  NewsTableViewCell.swift
//  TestApp
//
//  Created by Ильнур Закиров on 19.02.2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsTextLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    var saveNewsClosure: ((UIButton) -> Void)?
    
    //заполняет элементы данными
    func configProperties(news: NewsModel, index: Int, saveNewsClosure: @escaping (UIButton) -> Void) {
        likeButton.setTitle("", for: .normal)
        newsImageView.image = UIImage(named: news.image)
        newsTextLabel.text = news.description
        titleLabel.text = news.title
        likeButton.setImage(news.isLiked ? UIImage(named: "favorite.fill") : UIImage(named: "favorite"), for: .normal)
        dateLabel.text = news.date
        self.saveNewsClosure = saveNewsClosure
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    @objc func likeButtonTapped() {
        guard let closure = saveNewsClosure else { return }
        closure(likeButton)
    }
    
}
