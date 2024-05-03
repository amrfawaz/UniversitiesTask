//
//  UniversityDetailsViewController.swift
//  UniversitiesApp
//
//  Created by AmrFawaz on 03/05/2024.
//

import UIKit

class UniversityDetailsViewController: UIViewController {

    @IBOutlet weak var labelUniversityName: UILabel!
    @IBOutlet weak var labelUniversityState: UILabel!
    @IBOutlet weak var labelUniversityCountry: UILabel!
    @IBOutlet weak var labelUniversityWebpage: UILabel!
    
    private let presenter: UniversityDetailsPresenter

    // MARK: Object lifecycle
    init(presenter: UniversityDetailsPresenter) {
        self.presenter = presenter
        super.init(nibName: "UniversityDetailsViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "University Details"
        presenter.viewDidLoad(view: self)
    }

    @IBAction func didTapRefreshButton(_ sender: Any) {
        presenter.didTapRefresh()
    }
}

extension UniversityDetailsViewController: UniversityDetailsView {
    func show() {
        labelUniversityName.text = presenter.universityName
        labelUniversityState.text = presenter.universityState
        labelUniversityCountry.text = presenter.universityCountry
        labelUniversityWebpage.text = presenter.universityWebPage
    }
}
