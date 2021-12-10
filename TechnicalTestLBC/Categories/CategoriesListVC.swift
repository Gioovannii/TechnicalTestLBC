//
//  CategoriesListVC.swift
//  TechnicalTestLBC
//
//  Created by Giovanni Gaffé on 2021/12/10.
//

import UIKit

class CategoriesListVC: UIViewController {
    
    private let tableView = UITableView()
    private var category = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setTableViewDelegates()
        view.backgroundColor = .white
    }
    
    func setTableViewDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.rowHeight = 50
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellCategory")
        tableView.pin(to: view)
    }
}

extension CategoriesListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        AnnouncementsListVC.categorySearchBar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellCategory", for: indexPath)
        
        cell.textLabel?.text = AnnouncementsListVC.categorySearchBar[indexPath.row]
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 50
        }
}

extension CategoriesListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
              
              let label = PaddingLabel()
              label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
              label.text = "Categories"
              label.font = .systemFont(ofSize: 25)
              label.textColor = .black
            label.paddingLeft = 15
              
              headerView.addSubview(label)
              
              return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.category = AnnouncementsListVC.categorySearchBar[indexPath.row]
        print(self.category)
        dismiss(animated: true) {
            let announcementVC = AnnouncementsListVC()
            
//            AnnouncementVC.filteredAnnouncement =
            
        }
    }
}
