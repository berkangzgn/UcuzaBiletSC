//
//  MainPageViewController.swift
//  UcuzaBiletSC
//
//  Created by Berkan Gezgin on 8.06.2022.
//

import UIKit
import Firebase

class MainPageViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterSegmentedControl: UISegmentedControl!
    
    var storeItemAPI = API()
    var items = [StoreItem?]()
    let queryOptions = ["movie", "music", "software", "ebook"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func cikisButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "logout", sender: nil)
        } catch {
            print("Error!")
        }
    }
    
    func fetchMatchingItems() {
        self.items = []
        self.tableView.reloadData()
        
        let searchTerm = searchBar.text ?? ""
        //let mediaType = queryOptions[filterSegmentedControl.selectedSegmentIndex]
        
        if !searchTerm.isEmpty {
            let query: [String: String] = [
                "term": searchTerm,
                //"media": mediaType,
                "lang": "en_us"
            ]
            
            storeItemAPI.fetchItems(matching: query) { (storeItems) in
                if let storeItems = storeItems {
                    self.items = storeItems
                    self.tableView.reloadData()
                } else {
                    print("No items availble!")
                }
            }
        }
    }
    
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        
        let item = items[indexPath.row]
        
        cell.textLabel?.text = item?.name
        cell.detailTextLabel?.text = item?.artist
        cell.imageView?.image = UIImage(named: "gray")
        
        let task = URLSession.shared.dataTask(with: item!.artworkURL, completionHandler: { (data, response, error) in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                cell.imageView?.image = image
            }
        })
        task.resume()
    }
    
    @IBAction func filterOptionUpdated(_ sender: UISegmentedControl) {
        fetchMatchingItems()
    }
}

extension MainPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        configure(cell: cell, forItemAt: indexPath)
        return cell
    }
}

extension MainPageViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchMatchingItems()
        searchBar.resignFirstResponder()
    }
}
