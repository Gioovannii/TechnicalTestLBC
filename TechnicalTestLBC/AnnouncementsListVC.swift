//
//  AnnouncementsListVC.swift
//  TechnicalTestLBC
//
//  Created by Giovanni Gaffé on 2021/12/7.
//

import UIKit

struct Cells {
    static let AnnouncementCell = "AnnouncementCell"
}

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
    
    func getCategoryDescription(id: Int) -> String {
        switch id {
        case 1:
            return "Vehicule"
        case 2:
            return "Mode"
        case 3:
            return "Bricolage"
        case 4:
            return "Maison"
        case 5:
            return "Loisirs"
        case 6:
            return "Immobilier"
        case 7:
            return "Livres/CD/DVD"
        case 8:
            return "Multimédia"
        case 9:
            return "Service"
        case 10:
            return "Animaux"
        case 11:
            return "Enfants"
        default:
            return "Catégorie introuvable"
        }
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
        
        itemCell.titleLabel.text = item.title
        itemCell.priceLabel.text = "\(item.price.stringWithoutZeroFraction) €"
        itemCell.isUrgentLabel.text = item.isUrgent == true ? "Urgent" : ""
        itemCell.categoryLabel.text = getCategoryDescription(id: item.categoryID)
        return cell
        
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
            
            // We have data
            
            guard let decodedResponse = try? JSONDecoder().decode([Response].self, from: data) else {
                print("Couldn't decode json")
                return
            }
            
            onCompletion(decodedResponse)
        }
        
        task.resume()
    }
}
