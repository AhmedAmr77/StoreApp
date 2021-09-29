//
//  FilterProductsContract.swift
//  StoreApp
//
//  Created by Ahmd Amr on 29/09/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import Foundation

protocol IFilterProductsView : class, BaseViewProtocol {
    func performActionWhenFilterClick(product: Product)
    func performActionWhenResetClick()
}

protocol IFilterProductsPresenter{
    func onFilterClick(product: Product)
    func onResetClick()
    func onDismiss()
}
