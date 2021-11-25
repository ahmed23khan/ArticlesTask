//
//  ArticleViewModel.swift
//  Articles
//
//  Created by Tauqeer Ahmed Khan on 25/11/21.
//

import Foundation

/**
 The ArticleViewModel is a canonical representation of the View. That is, the ArticleViewModel provides a set of interfaces, each of which represents a UI component in the View. We use a technique called “binding” to connect UI components to ViewModel interfaces. So, in MVVM, we don’t touch the View directly, we deal with business logic in the ViewModel and thus the View changes itself accordingly.
 */

class ArticleViewModel {
    
    let sessionProvider : URLSessionProvider

    // Detail screen data.
    var abstract : String?
    var source : String?
    
    
    // Variable holds to period value.
    var selectedDay: Period = .one;
    
    
    /// Variable observes when the change when the network call is made and when the reponse from the network is received.
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    /// This variable is used to reload the tableview, when the data is stored in this variable.
    private var cellViewModels: [Article] = [Article]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    // Holds to count of number table view cells.
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    // Call back closures to View.
    var reloadTableViewClosure: (()->())?
    var updateLoadingStatus: (()->())?

    
    /// Custom Initiailzer.
    /// - Parameter sessionProvider: 'URLSessionProvider' object to make network calls.
    init(sessionProvider:URLSessionProvider = URLSessionProvider()) {
        self.sessionProvider = sessionProvider
    }
    
    /// Fetchs the Artilces by making network calls.
    func initFetch() {
        self.isLoading = true
        self.sessionProvider.request(type: Artilces.self, service: self.selectedDay) { [weak self] response in
            self?.isLoading = false
            switch response {
            case let .success(posts):
                let articles : Artilces = posts
                self?.processArticles(modelData:articles)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    /// Process the data received from the network into the model.
    /// - Parameter modelData: data from Network.
    func processArticles(modelData: Artilces)  {
        let welcome : Artilces = modelData
        self.cellViewModels = welcome.results // Update UI
    }
    
    /// Method to get the data set based on the cell selection.
    /// - Parameter indexPath: Indexpath of the tableview.
    /// - Returns: <#description#>
    func getCellViewModel( at indexPath: IndexPath ) -> Article {
        return cellViewModels[indexPath.row]
    }
    
    /// Method to extract details of the selectec Article.
    /// - Parameter indexPath: Indexpath of the tableview.
    func articleSelected(indexPath: IndexPath) {
        let result : Article = self.cellViewModels[indexPath.row]
        self.source   = result.source
        self.abstract = result.abstract
    }
    
    
    /// Method to referesh the list, when pull to refresh is called and when period/days is updated.
    /// - Parameter days: days/period.
    func refreshDays(days:Period) {
        self.isLoading = true
        self.selectedDay = days
        self.sessionProvider.request(type: Artilces.self, service: days) { [weak self] response in
            self?.isLoading = false
            switch response {
            case let .success(posts):
                let articles : Artilces = posts
                self?.processArticles(modelData:articles)
            case let .failure(error):
                print(error)
            }
        }
    }
}
