//
//  AnnouncementsListVC.swift
//  TechnicalTestLBC
//
//  Created by Giovanni Gaffé on 2021/12/7.
//

import UIKit

class AnnouncementsListVC: UIViewController {

    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func configureTableView() {
        view.addSubview(tableView)
            // set delegates
            //set row and height
            // Register cells
            // set contraints
    }
    
    func setTableViewDelegaates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension AnnouncementsListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

extension AnnouncementsListVC: UITableViewDelegate {
    
}
