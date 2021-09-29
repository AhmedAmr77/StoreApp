//
//  ProductsCollectionViewCell.swift
//  StoreApp
//
//  Created by Ahmd Amr on 28/09/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import UIKit

class ProductsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
