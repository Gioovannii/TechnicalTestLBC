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
        fetchData()
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
}

extension AnnouncementsListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.AnnouncementCell, for: indexPath) as! AnnouncmentCell

        let announcement = self.result[indexPath.row]
        print("*** dequeue \(announcement)")
        cell.set(response: announcement)
        return cell
        
    }
    
}

extension AnnouncementsListVC {
    
    func fetchData() {
        guard let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }
            
            // We have data
            do {
                self.result = try JSONDecoder().decode([Response].self, from: data)
            } catch {
                print("Failed to convert \(error.localizedDescription)")
                print(String(describing: error))
            }
            
            print(self.result)
        }
        task.resume()
    }
}
