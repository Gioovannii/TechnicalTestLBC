//
//  CategoriesListVC.swift
//  TechnicalTestLBC
//
//  Created by Giovanni Gaffé on 2021/12/10.
//

import UIKit

class CategoriesListVC: UIViewController {

    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewDelegates()
    }
    
    func setTableViewDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension CategoriesListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        AnnouncementsListVC.categorySearchBar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

extension CategoriesListVC: UITableViewDelegate {
    
}
