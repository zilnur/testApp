import Foundation
import CoreData

protocol DataBase {
    func addFavorite()
    func removeFavorite()
}

class DatabaseService {
    
    static let shared = DatabaseService()
    
    private let container: NSPersistentContainer
    
    private lazy var backgrounContext = container.newBackgroundContext()
    
    init() {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { description, error in
            if error != nil {
                fatalError()
            }
        }
        self.container = container
    }
    
    //Сохраняет новость в избранное(БД)
    func addFavorite(savedNews: NewsModel) {
        backgrounContext.perform { [weak self] in
            guard let self = self else { return }
            let news = NSEntityDescription.insertNewObject(forEntityName: "News", into: self.backgrounContext) as! News
            news.id = Int16(savedNews.id)
            news.image = savedNews.image
            news.date = savedNews.date
            news.title = savedNews.title
            news.text = savedNews.description
            news.isLiked = savedNews.isLiked
            do {
                try self.backgrounContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    //Удаляет новость из избранного(БД)
    func removeFavorite(index: Int) {
        container.viewContext.performAndWait {
            let request = News.fetchRequest()
            do {
                let events = try container.viewContext.fetch(request)
                guard let news = events.first(where: {$0.id == index}) else { return }
                container.viewContext.delete(news)
                try container.viewContext.save()
            } catch {
                
            }
        }
    }
    
    //Выгружает новости из БД
    func setNews() -> [NewsModel] {
        var displayedNews = [NewsModel]()
        let request = News.fetchRequest()
        do {
            let events = try backgrounContext.fetch(request)
            events.forEach { news in
                let model = NewsModel(id: Int(news.id),
                                      image: news.image ?? "",
                                      date: news.date ?? "",
                                      title: news.title ?? "",
                                      description: news.text ?? "",
                                      isLiked: news.isLiked)
                displayedNews.append(model)
            }
        } catch {
            
        }
        return displayedNews
    }
    
}
