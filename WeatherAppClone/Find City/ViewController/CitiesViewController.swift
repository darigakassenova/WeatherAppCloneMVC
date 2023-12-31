//
//  CitiesViewController.swift
//  WeatherAppClone
//
//  Created by Dariga on 28.05.2023.
//

import UIKit

protocol CitiesViewControllerDelegate: AnyObject {
    func didSelectCity(_ city: SearchCityModel)
}

class CitiesViewController: UIViewController {
    
    private var cities: [SearchCityModel] = [] {
            didSet {
                tableView.reloadData()
            }
        }
    private let dataSource = SearchCityDataSource()
    
    private var isSearchBarEmpty: Bool {
        searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        searchController.isActive && !isSearchBarEmpty
    }
    
    weak var delegate: CitiesViewControllerDelegate?
    
    private let searchController: UISearchController = {
        let viewController = UISearchController(searchResultsController: nil)
        return viewController
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        view.backgroundColor = .black
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupNavigationBar(){
        navigationItem.title = "Weather"
        navigationItem.searchController = searchController
        searchController.delegate = self
        searchController.searchBar.delegate = self
    }
    
    private func setupTableView(){
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension CitiesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            cities.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell else { fatalError() }
            cell.configure(model: cities[indexPath.row])
            
            return cell
        }
}

extension CitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        97
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectCity(cities[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
}

extension CitiesViewController: UISearchControllerDelegate {
    
}

extension CitiesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            guard searchText.count > 0 else {
                tableView.reloadData()
                return
            }
            dataSource.searchCity(query: searchText) { [weak self] result in
                switch result {
                case .success(let cities):
                    DispatchQueue.main.async {
                        self?.cities = cities
                    }
                case .failure(let error):
                    print("error \(error.localizedDescription)")
                }
                
            }
            tableView.reloadData()
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            tableView.reloadData()
        }
}
