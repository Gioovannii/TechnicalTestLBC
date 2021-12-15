//
//  AnnouncementsListVC.swift
//  TechnicalTestLBC
//
//  Created by Giovanni Gaffé on 2021/12/7.
//

import UIKit

final class AnnouncementsListVC: UIViewController {
    private let requestService = RequestService()
    
    private var tableView = UITableView()
    private var searchController = UISearchController(searchResultsController: nil)

    private var result = [Response]()
    private var filteredAnnouncement = [Response]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationView()
        setTableViewDelegates()
        configureTableView()
        
        requestService.categories = requestService.getCategories()
        requestService.fetchData(onCompletion: fetchData())
    }
    
    private func configureNavigationView() {
        title = Constant.annoucementTitle
        navigationItem.searchController = searchController
        setupSearchBar()
    }
    
    private func setTableViewDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    private func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 100
        tableView.register(AnnouncementCell.self, forCellReuseIdentifier: Constant.AnnouncementCell)
        tableView.pin(to: view)
    }
    
   
    
    private func fetchData() -> (Result<[Response], NetworkError>) -> () {
        let anonymousFunction = { (result: Result<[Response], NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedResults):
                    self.result = fetchedResults.sorted { $0.creationDate > $1.creationDate }
                    self.result.sort { $0.isUrgent && !$1.isUrgent }
                    self.tableView.reloadData()
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }
        return anonymousFunction
    }
    
    private func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Choisissez une categorie... "
        searchController.searchBar.sizeToFit()
        searchController.searchBar.searchBarStyle = .default
        searchController.searchBar.scopeButtonTitles = AnnouncementsListVC.categorySearchBar
        searchController.searchBar.delegate = self
    }
    
    private func filterContentForSearchText(searchText: String, scope: String = "🔄") {
        filteredAnnouncement = result.filter ({ (category: Response) -> Bool in
            let categoryByID = AnnouncementsListVC.getCategoryImage(id: category.categoryID)
            let doesCategoryMatch = (scope == "🔄") || (categoryByID == scope)
            
            if isSearchBarEmpty() {
                return doesCategoryMatch
            } else {
                return doesCategoryMatch && category.title.lowercased().contains(searchText.lowercased())
            }
        })
        tableView.reloadData()
    }
    
    private func isSearchBarEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!isSearchBarEmpty() || searchBarScopeIsFiltering)
    }
}

// MARK: - Search bar

extension AnnouncementsListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        guard let searchText = searchController.searchBar.text else { return }
        guard let scopeButtonTitles = searchBar.scopeButtonTitles else { return }
        filterContentForSearchText(searchText: searchText, scope: scopeButtonTitles[selectedScope])
    }
}

extension AnnouncementsListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        guard let searchText = searchController.searchBar.text else { return }
        filterContentForSearchText(searchText: searchText, scope: scope)
    }
}



// MARK: - TableView DataSource

extension AnnouncementsListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() { return filteredAnnouncement.count
        } else { return result.count }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.AnnouncementCell, for: indexPath) as? AnnouncementCell
        else { return UITableViewCell() }
        
        let response: Response
            
        if isFiltering() {
            response = filteredAnnouncement[indexPath.row]
        } else {
            response = result[indexPath.row]
        }
        
        if let imageSmall = response.imagesURL.small { cell.thumbImageView.downloaded(from: imageSmall)
        } else { cell.thumbImageView = UIImageView(image: UIImage(named: Constant.imageName)) }
        
        cell.titleLabel.text = response.title
        cell.priceLabel.text = "\(response.price.stringWithoutZeroFraction) €"
        cell.isUrgentLabel.text = response.isUrgent == true ? "Urgent" : ""
        cell.categoryLabel.text = AnnouncementsListVC.getCategoryImage(id: response.categoryID)
        cell.categoryNameLabel.text = requestService.categories[response.categoryID - 1].name
        return cell
    }
}

// MARK: - Delegate

extension AnnouncementsListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var response: Response
        
        if isFiltering() {
            response = filteredAnnouncement[indexPath.row]
        } else {
            response = result[indexPath.row]
        }
        
        let announcement = response
        let announcementDetailVC = AnnouncementDetailVC()
        announcementDetailVC.announcement = announcement
        self.present(announcementDetailVC, animated: true)
    }
}

