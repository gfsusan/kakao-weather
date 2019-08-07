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
    
    let searchCompleter = MKLocalSearchCompleter()
    var completionResults = [MKLocalSearchCompletion]()
    
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
        
        configureSearchCompleter()
        configureSearchController()
    }
    
    func configureTableView() {
        tableView.register(SearchResultCell
            .self, forCellReuseIdentifier: cellId)
    }

    func configureSearchCompleter() {
        searchCompleter.delegate = self
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
        return completionResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let completionResult = completionResults[indexPath.row]
        cell.textLabel?.text = completionResult.title
        cell.detailTextLabel?.text = completionResult.subtitle
        
        return cell
    }
    
    // MARK: - Navigtaion
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let completion = completionResults[indexPath.row]
        
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let localSearch = MKLocalSearch(request: searchRequest)
        localSearch.start { (response, error) in
            guard let response = response else { return }
            self.matchingItems = response.mapItems

            self.matchingItems.forEach({ (mapItem) in
                let placemark = mapItem.placemark
                guard let name = placemark.title else { return }
                let coordinate = placemark.coordinate
                ApplicationSettings.Status.locations.insert(Location(name: name, latitude: coordinate.latitude, longtitude: coordinate.longitude))
                self.dismiss(animated: true, completion: {
                    self.dismiss(animated: true, completion: nil)
                })
            })
        }
    }

}

extension SearchCityController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let queryText = searchController.searchBar.text ?? ""
//        let request = MKLocalSearch.Request()
//        request.naturalLanguageQuery = queryText
//
//        let localSearch = MKLocalSearch(request: request)
//        localSearch.start { (response, error) in
//            guard let response = response else { return }
//            self.matchingItems = response.mapItems
//            self.tableView.reloadData()
//        }
        
        searchCompleter.queryFragment = queryText
        searchCompleter.filterType = .locationsOnly
    }
}

extension SearchCityController: UISearchBarDelegate, UISearchControllerDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchCityController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        completionResults = completer.results.filter({ (completionCandidate) -> Bool in
            // search for only units larger than a city
            completionCandidate.subtitle == ""
        })
        tableView.reloadData()
    }
}
