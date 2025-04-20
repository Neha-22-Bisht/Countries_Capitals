//
//  ViewController.swift
//  CountriesApp
//
//   Created by  Neha Bisht on 04/02/25.
//

import UIKit

final class ViewController: UIViewController {
    var searchController: UISearchController!
    
    @IBOutlet weak var myTableView: UITableView!
    private var viewModel = CountriesViewModel(networkManager: NetworkManager())
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
          self.searchController.searchBar.becomeFirstResponder()
    }
    
    private func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by country or capital"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func setupTableView() {
        myTableView.dataSource = self
    }
    
    private func fetchCountries() {
        viewModel.fetchCountries { [weak self] in
            DispatchQueue.main.async {
                self?.myTableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCountries()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        let country = viewModel.country(at: indexPath.row)
        
        cell.countryNameLabelCell.text = country.name
        cell.regionNameLabelCell.text = country.region
        cell.codeLabelCell.text = country.code
        cell.capitalNameLabelCell.text = country.capital
        return cell
    }
    }

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        viewModel.filterCountries(for: searchText)
        myTableView.reloadData()
    }
}


extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List of Countries"
        setupSearchController()
        setupTableView()
        fetchCountries()
    }
}
