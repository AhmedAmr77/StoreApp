//
//  Constants.swift
//  StoreApp
//
//  Created by Ahmd Amr on 28/09/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import Foundation

struct Constants {
    static let productsCellIdentifier = "ProductsCollectionViewCell"
    
    static let productsCoreDataEntityName = "Products"
    static let productsCoreDataNameKey = "name"
    static let productsCoreDataDescriprionKey = "descriprion"
    static let productsCoreDataPriceKey = "price"
    static let productsCoreDataImageKey = "image"
    
    static let addProductErrorMsg = "Can't add product, try again!"
    static let editProductErrorMsg = "Can't edit product, try again!"
    static let deleteProductErrorMsg = "Can't delete product, try again!"
    static let filterProductErrorMsg = "There is no product with this name"
    
    static let addEditProductVC = "AddEditProductViewController"
    static let actionOnProductVC = "ActionOnProductViewController"
    static let filterProductsVC = "FilterProductsViewController"
    
}
