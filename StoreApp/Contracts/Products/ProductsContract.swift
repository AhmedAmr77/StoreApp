//
//  ProductsContract.swift
//  StoreApp
//
//  Created by Ahmd Amr on 28/09/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import Foundation

protocol IProductsView : class, BaseViewProtocol {
    func renderViewWithProducts(with productsArray: [Product])
    func performActionWhenItemClick(row: Int)
    func performActionWhenAddClick()
    func performActionWhenFilterClick()
    func getData()
    
    func navigateToEditVC(with product: Product)
    
    func filterProducts(with product: Product)
    func resetFilter()
}

protocol IProductsPresenter{
    func getProducts()
    func onItemClick(row: Int)
    func onAddClick()
    func onFilterClick()
}

protocol IProductsManager {
    func getProducts(completion: @escaping ([Product]) -> Void)
}
