//
//  AddProductContract.swift
//  StoreApp
//
//  Created by Ahmd Amr on 28/09/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import Foundation

protocol IAddProductView: BaseAddEditViewProtocol {
    func performActionWhenAddProductClick()
}

protocol IAddProductPresenter: BaseAddEditPresenterProtocol{
    func onAddClick(product: Product)
}

protocol IAddProductManager {
    func addProduct(product: Product, completion: @escaping (Bool) -> Void)
}
