import UIKit

class NewsTableViewController: UITableViewController {
    
    var model = [NewsModel]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setModel()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsTableViewCell
        cell?.configProperties(news: model[indexPath.section], index: indexPath.section) { [weak self] button in
            guard let self = self else { return }
            if self.model[indexPath.section].isLiked {
                self.removeButton(button: button, index: indexPath.section)
            } else {
                self.saveNews(button: button, index: indexPath.section)
            }
        }
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = DetailNewsViewController()
        view.configProperties(model: model[indexPath.section]) { [weak self] button in
            guard let self = self else { return }
            if self.model[indexPath.section].isLiked {
                self.removeButton(button: button, index: indexPath.section)
            } else {
                self.saveNews(button: button, index: indexPath.section)
            }
            
        }
        navigationController?.pushViewController(view, animated: true)
    }
    
    //Наполняет модель данными и сверяет их с избранными
    func setModel() {
        let model = MetaData.news.map { news in
            var _news = news
            DatabaseService.shared.setNews().forEach { savedNews in
                if _news.id == savedNews.id {
                    _news.isLiked = true
                }
            }
            return _news
        }
        
        self.model = model
    }
    
    //сохраняет новость в БД при нажатии кнопки лайка
    func saveNews(button: UIButton, index: Int) {
        self.model[index].isLiked.toggle()
        DatabaseService.shared.addFavorite(savedNews: self.model[index])
        button.setImage(UIImage(named: "favorite.fill"), for: .normal)
        button.tintColor = .systemPink
    }
    
    //удаляет новость из бд при нажатии кнопки лайка
    func removeButton(button: UIButton, index: Int) {
        self.model[index].isLiked.toggle()
        DatabaseService.shared.removeFavorite(index: self.model[index].id)
        button.setImage(UIImage(named: "favorite"), for: .normal)
        button.tintColor = .gray
    }
    
}
