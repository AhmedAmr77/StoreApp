//
//  EditProductContract.swift
//  StoreApp
//
//  Created by Ahmd Amr on 29/09/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import Foundation

protocol IEditProductView: BaseAddEditViewProtocol {
    func performActionWhenEditProductClick()
}

protocol IEditProductPresenter: BaseAddEditPresenterProtocol{
    func onEditClick(product: Product)
}

protocol IEditProductManager {
    func editProduct(product: Product, completion: @escaping (Bool) -> Void)
}
