//
//  ArticlesViewController.swift
//  Articles
//
//  Created by Tauqeer Ahmed Khan on 25/11/21.
//

import UIKit
/**
 'ArticlesViewController' is a view class, which is responsible to hold to view objects and perform view related operations.
  It holds a reference to ViewModel, where business logic is present. As and when the data is processed in the ViewModel, the View is updated.
 */
class ArticlesViewController: UIViewController {
    
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var articleTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var viewModel: ArticleViewModel = {
        return ArticleViewModel()
    }()
    
    // Pull to Refresh Controller
    var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.initView()
        self.initViewModel()
    }
    
    func initView() {
        self.navigationItem.title = Constants.navigationBarTitle
        self.daysLabel.text = "\(Constants.daysText) \(String(viewModel.selectedDay.rawValue))"
        
        //Register Cell
        self.articleTableView.register(UINib(nibName: Constants.articleTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.articleTableViewCellIdentifier)
        self.articleTableView.rowHeight = UITableView.automaticDimension
        self.articleTableView.estimatedRowHeight = 1000
        
        // Set up Pull to refresh
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: Constants.refreshText)
        refreshControl.addTarget(self, action: #selector(refreshViewController), for: .valueChanged)
        self.articleTableView.addSubview(refreshControl)
    }
    
    func initViewModel() {
        
        // Handle spinner activity/
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.articleTableView.alpha = 0.0
                    })
                }else {
                    self?.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.articleTableView.alpha = 1.0
                    })
                }
            }
        }
        
        // Reload tableview when data is fetched from network call.
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.articleTableView.reloadData()
            }
        }
        // Fetch Data from Network Call.
        viewModel.initFetch()
    }
    
    // Push data to detail View.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueIdentifier {
            if let destinationVC = segue.destination as? ArticleDetailViewController {
                destinationVC.abstract = viewModel.abstract
                destinationVC.source   = viewModel.source
            }
        }
    }
    
    @objc private func refreshViewController() {
        
        if(self.refreshControl.isRefreshing) {
            self.refreshControl.endRefreshing()
        }
        
        self.daysLabel.text = "\(Constants.daysText) \(String(viewModel.selectedDay.rawValue))"
        viewModel.refreshDays(days: viewModel.selectedDay);
    }
    
    
    
    /// Toggle Action to handle day/Period selection
    @IBAction func toggleDays(_ sender: Any) {
        switch Int((sender as! UIStepper).value) {
        case 1:
            viewModel.selectedDay = .one
            viewModel.refreshDays(days: .one)
            self.daysLabel.text = Constants.dayOne
            break
        case 2:
            viewModel.selectedDay = .seven
            viewModel.refreshDays(days: .seven)
            self.daysLabel.text = Constants.daySeven
            break
        case 3:
            viewModel.selectedDay = .thirty
            viewModel.refreshDays(days: .thirty)
            self.daysLabel.text = Constants.dayThirty
            break
        default:
            break
            // Do nothing
        }
    
    }
    
    
}

// MARK: - TableView Data Source Methods.

extension ArticlesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  Constants.articleTableViewCellIdentifier, for: indexPath) as? ArticleTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        let cellVM = viewModel.getCellViewModel( at: indexPath )
        cell.titleLabel.text = cellVM.title
        cell.byLineLabel.text = cellVM.byline
        cell.dateLabel.text   = cellVM.publishedDate
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.viewModel.articleSelected(indexPath: indexPath)
        return indexPath
    }
    
}

// MARK: - TableView Delegate Methods.
extension ArticlesViewController : UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Constants.segueIdentifier, sender: indexPath)
    }
}
