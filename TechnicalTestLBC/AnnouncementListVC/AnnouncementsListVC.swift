//
//  AnnouncementsListVC.swift
//  TechnicalTestLBC
//
//  Created by Giovanni Gaffé on 2021/12/7.
//

import UIKit

final class AnnouncementsListVC: UIViewController {
    private let requestService = RequestService()
    
    var tableView = UITableView()
    var searchController = UISearchController(searchResultsController: nil)

    var result = [Response]()
    var filteredAnnouncement = [Response]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationView()
        configureTableView()
        
        requestService.fetchData(onCompletion: fetchData())
        configureTableView()
        setTableViewDelegates()
    }
    
    func configureNavigationView() {
        title = Constant.annoucementTitle
        navigationItem.searchController = searchController
        setupSearchBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Catégories", style: .plain, target: self, action: #selector(filterResult))
        
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 100
        tableView.register(AnnouncementCell.self, forCellReuseIdentifier: Constant.AnnouncementCell)
        tableView.pin(to: view)
    }
    
    func setTableViewDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func fetchData() -> ([Response]) -> () {
        let anonymousFunction = { (fetchedResults: [Response]) in
            DispatchQueue.main.async {
                self.result = fetchedResults.sorted { $0.creationDate > $1.creationDate }
                self.result.sort { $0.isUrgent && !$1.isUrgent }
                self.tableView.reloadData()
            }
        }
        return anonymousFunction
    }
    
    func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Choisissez une categorie... "
        searchController.searchBar.sizeToFit()
        searchController.searchBar.searchBarStyle = .default
        searchController.searchBar.scopeButtonTitles = AnnouncementsListVC.categorySearchBar
        searchController.searchBar.delegate = self
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "Tout") {
        filteredAnnouncement = result.filter ({ (category: Response) -> Bool in
            let categoryByID = AnnouncementsListVC.getCategoryDescription(id: category.categoryID)
            let doesCategoryMatch = (scope == "Tout") || (categoryByID == scope)
            
            if isSearchBarEmpty() {
                return doesCategoryMatch
            } else {
                return doesCategoryMatch && category.title.lowercased().contains(searchText.lowercased())
            }
        })
        tableView.reloadData()
    }
    
    func isSearchBarEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!isSearchBarEmpty() || searchBarScopeIsFiltering)
    }
    
    @objc func filterResult() {
        let categorieVC = CategoriesListVC()
        self.present(categorieVC, animated: true)
    }
}

// MARK: - Search bar

extension AnnouncementsListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchText: searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension AnnouncementsListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        
        filterContentForSearchText(searchText: searchController.searchBar.text!, scope: scope)
    }
}


// MARK: - Table view

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
        cell.categoryLabel.text = AnnouncementsListVC.getCategoryDescription(id: response.categoryID)
        return cell
    }
}

extension AnnouncementsListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let announcement = self.result[indexPath.row]
        let announcementDetailVC = AnnouncementDetailVC()
        announcementDetailVC.announcement = announcement
        self.present(announcementDetailVC, animated: true)
    }
}

