//
//  OverViewTableViewCell.swift
//  PhonePe
//
//  Created by Shubham JAIn on 25/06/22.
//

import UIKit

class OverViewTableViewCell: UITableViewCell {

    @IBOutlet private weak var movieOverView: UILabel!
 
    func configureCell(text: String) {
        self.movieOverView.text = text
    }

}
