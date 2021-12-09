//
//  AnnouncementsListVC.swift
//  TechnicalTestLBC
//
//  Created by Giovanni Gaffé on 2021/12/7.
//

import UIKit

class AnnouncementsListVC: UIViewController {
    
    var tableView = UITableView()
    var result = [Response]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Liste d'annonce"
        fetchData(onCompletion: fetchData())
        configureTableView()
        setTableViewDelegates()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 100
        tableView.register(AnnouncmentCell.self, forCellReuseIdentifier: Cells.AnnouncementCell)
        tableView.pin(to: view)
    }
    
    func setTableViewDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func fetchData() -> ([Response]) -> () {
        let anonymousFunction = { (fetchedResults: [Response]) in
            DispatchQueue.main.async {
                
                self.result = fetchedResults
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.AnnouncementCell, for: indexPath)
        let item = result[indexPath.row]

        guard let itemCell = cell as? AnnouncmentCell else { return cell }

        if let imageSmall = item.imagesURL.small { itemCell.thumbImageView.downloaded(from: imageSmall)
        } else { itemCell.thumbImageView = UIImageView(image: UIImage(named: "no-pictures")) }
        itemCell.titleLabel.text = item.title
        itemCell.priceLabel.text = "\(item.price.stringWithoutZeroFraction) €"
        itemCell.isUrgentLabel.text = item.isUrgent == true ? "Urgent" : ""
        itemCell.categoryLabel.text = Helper.getCategoryDescription(id: item.categoryID)
        return cell
    }
}

extension AnnouncementsListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let announcement = self.result[indexPath.row]
        let announcementDetailVC = AnnouncementDetailVC()
        let dateFromString = DateFormatter.getDateFromString(date: announcement.creationDate)
        let dateFromDate = DateFormatter.getDateToString(from: dateFromString)

        announcementDetailVC.announcement = announcement
        announcementDetailVC.imageThumb.downloaded(from: announcement.imagesURL.thumb!)
        announcementDetailVC.titleLabel.text = announcement.title
        announcementDetailVC.descriptionTextView.text = announcement.annoncementDescription
        print(announcement.annoncementDescription)
        announcementDetailVC.priceLabel.text = "\(announcement.price.stringWithoutZeroFraction) €"
        announcementDetailVC.dateLabel.text = dateFromDate

        self.present(announcementDetailVC, animated: true)
    }
}

extension AnnouncementsListVC {
    
    func fetchData(onCompletion: @escaping ([Response]) -> ()) {
        guard let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("Data was nil")
                return
            }
                        
            guard var decodedResponse = try? JSONDecoder().decode([Response].self, from: data) else {
                print("Couldn't decode json")
                return
            }
            
            
            decodedResponse.sort { $0.isUrgent && !$1.isUrgent }
            
            var dataRepre = [ResponseRepresentable]()
            for data in decodedResponse {
                let responseRep = ResponseRepresentable(id: data.id, categoryID: data.categoryID, title: data.title, annoncementDescription: data.annoncementDescription, price: data.price, imagesURL: data.imagesURL, creationDate: DateFormatter.getDateFromString(date: data.creationDate), isUrgent: data.isUrgent, siret: data.siret)
                dataRepre.append(contentsOf: responseRep)
            }

            dataRepre.sort { $0.creationDate < $1.creationDate}
            
            
            onCompletion(decodedResponse)
        }
        task.resume()
    }
}

