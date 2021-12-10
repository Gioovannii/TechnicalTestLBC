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
    var result = [Response]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constant.annoucementTitle
        requestService.fetchData(onCompletion: fetchData())
        configureTableView()
        setTableViewDelegates()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 100
        tableView.register(AnnouncmentCell.self, forCellReuseIdentifier: Constant.AnnouncementCell)
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
}

extension AnnouncementsListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.AnnouncementCell, for: indexPath)
        let item = result[indexPath.row]

        guard let itemCell = cell as? AnnouncmentCell else { return cell }

        if let imageSmall = item.imagesURL.small { itemCell.thumbImageView.downloaded(from: imageSmall)
        } else { itemCell.thumbImageView = UIImageView(image: UIImage(named: Constant.imageName)) }
        itemCell.titleLabel.text = item.title
        itemCell.priceLabel.text = "\(item.price.stringWithoutZeroFraction) €"
        itemCell.isUrgentLabel.text = item.isUrgent == true ? "Urgent" : ""
        itemCell.categoryLabel.text = AnnouncementsListVC.getCategoryDescription(id: item.categoryID)
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

