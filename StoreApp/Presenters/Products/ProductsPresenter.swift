//
//  ProductsPresenter.swift
//  StoreApp
//
//  Created by Ahmd Amr on 28/09/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import Foundation

class ProductsPresenter: IProductsPresenter {
    
    weak var delegate: IProductsView?
    var localManager: IProductsManager?
    
    init(delegate: IProductsView) {
        self.delegate = delegate
        localManager = LocalManager.sharedInstance
    }
    
    func getProducts() {
        delegate?.showLoading()
        localManager?.getProducts(completion: { (products) in
            self.delegate?.hideLoading()
            self.delegate?.renderViewWithProducts(with: products)
        })
    }
    
    func onItemClick(row: Int) {
        delegate?.performActionWhenItemClick(row: row)
    }
    
    func onAddClick() {
        delegate?.performActionWhenAddClick()
    }
    
    func onFilterClick() {
        delegate?.performActionWhenFilterClick()
    }
}
