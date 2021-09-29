//
//  FilterProductPresenter.swift
//  StoreApp
//
//  Created by Ahmd Amr on 29/09/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import Foundation

class FilterProductPresenter: IFilterProductsPresenter {
    
    weak var delegate: IFilterProductsView?
    
    init(delegate: IFilterProductsView) {
        self.delegate = delegate
    }
    
    func onFilterClick(product: Product) {
        delegate?.performActionWhenFilterClick(product: product)
    }
    
    func onResetClick() {
        delegate?.performActionWhenResetClick()
    }
    
    func onDismiss() {
        delegate?.performActionWhenResetClick()
    }
}
