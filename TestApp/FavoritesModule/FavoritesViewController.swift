//
//  FavoritesViewController.swift
//  TestApp
//
//  Created by Ильнур Закиров on 19.02.2023.
import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var favoritesCollectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritesCollectionView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesCollectionView.dataSource = self
        favoritesCollectionView.delegate = self
    }

}

extension FavoritesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        DatabaseService.shared.setNews().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as? FavoriteNewsCollectionViewCell
        cell?.configProperties(news: DatabaseService.shared.setNews()[indexPath.item]) { button in
            DatabaseService.shared.removeFavorite(index: DatabaseService.shared.setNews()[indexPath.item].id)
            collectionView.reloadData()
        }
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let view = DetailNewsViewController()
        view.configProperties(model: DatabaseService.shared.setNews()[indexPath.item]) { button in
            if DatabaseService.shared.setNews()[indexPath.item].isLiked {
                DatabaseService.shared.removeFavorite(index: DatabaseService.shared.setNews()[indexPath.item].id)
                button.setImage(UIImage(named: "favorite"), for: .normal)
                button.tintColor = .gray
            } else {
                DatabaseService.shared.addFavorite(savedNews: DatabaseService.shared.setNews()[indexPath.item])
                button.setImage(UIImage(named: "favorite.fill"), for: .normal)
                button.tintColor = .systemPink
            }
            
        }
        navigationController?.pushViewController(view, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
    
}
