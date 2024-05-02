//
//  UniversityCell.swift
//  UniversitiesApp
//
//  Created by AmrFawaz on 02/05/2024.
//

import UIKit
import CoreInterface

class UniversityCell: UITableViewCell {

    @IBOutlet weak var labelUniversityName: UILabel!
    @IBOutlet weak var labelUniversityState: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(name: String, state: String) {
        labelUniversityName.text = name
        labelUniversityState.text = state
    }
}
