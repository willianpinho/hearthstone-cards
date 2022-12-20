//
//  CardImageTableViewCell.swift
//  hearthstone-cards
//
//  Created by Willian Junior Peres de Pinho on 19/12/22.
//

import UIKit
import Kingfisher

class CardImageTableViewCell: UITableViewHeaderFooterView, NibReusable {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(card: Card) {
        let url = URL(string: card.img ?? "")
        self.imageView.kf.setImage(with: url)
    }
}
