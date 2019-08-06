//
//  SearchCityController.swift
//  KakaoWeather
//
//  Created by Susan Kim on 05/08/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import UIKit
import MapKit

private let cellId = "cellId"

class SearchCityController: UITableViewController {

    var matchingItems: [MKMapItem] = []
    
    let searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.showsCancelButton = true
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Enter city, zip code, or airport location"

        configureTableView()
        configureSearchController()
    }
    
    func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }

    func configureSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = matchingItems[indexPath.row].placemark.title
        return cell
    }

}

extension SearchCityController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let queryText = searchController.searchBar.text else { return }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = queryText

        let localSearch = MKLocalSearch(request: request)
        localSearch.start { (response, error) in
            guard let response = response else { return }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }
}

extension SearchCityController: UISearchBarDelegate, UISearchControllerDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
}
