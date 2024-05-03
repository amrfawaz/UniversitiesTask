//
//  UniversitiesListViewController.swift
//  UniversitiesApp
//
//  Created by AmrFawaz on 02/05/2024.
//

import UIKit
import CoreInterface

class UniversitiesListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            UniversityCell.register(on: tableView)
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let presenter: UniversitiesListPresenter

    // MARK: Object lifecycle
    init(presenter: UniversitiesListPresenter) {
        self.presenter = presenter
        super.init(nibName: "UniversitiesListViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Universities List"
        presenter.viewDidLoad(view: self)
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startLoadingAnimation()
        presenter.viewWillAppear()
    }
}

// MARK: - Extenstions - TableView DataSource

extension UniversitiesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.universitiesList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UniversityCell", for: indexPath) as? UniversityCell
        else {
            return UITableViewCell()
        }

        let university = presenter.universitiesList[indexPath.row]
        cell.configure(
            name: university.name,
            state: university.state ?? ""
        )
        return cell
    }
}

// MARK: - Extenstions - TableView Delegate

extension UniversitiesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didTapUniversity(at: indexPath.row)
    }
}

// MARK: - Extenstions - PresenterToViewProtocol

extension UniversitiesListViewController: UniversitiesListView {
    func show() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func showError(errorMessage: String?) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Alert", message: errorMessage, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }

    func startLoadingAnimation() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.startAnimating()
        }
    }
    
    func stopLoadingAnimation() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
    }
    

}
