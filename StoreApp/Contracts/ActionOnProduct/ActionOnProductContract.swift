//
//  ActionOnProductContract.swift
//  StoreApp
//
//  Created by Ahmd Amr on 29/09/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import Foundation

protocol IActionOnProductView : class, BaseViewProtocol {
    func performActionWhenDeleteClick()
    func performActionWhenEditClick()
}

protocol IActionOnProductPresenter{
    func onDeleteClick(productName: String)
    func onEditClick()
    func onDismiss()
}

protocol IActionOnProductManager {
    func deleteProduct(productName: String, completion: @escaping (Bool) -> Void)
}
