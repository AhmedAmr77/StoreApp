//
//  AddProductPresenter.swift
//  StoreApp
//
//  Created by Ahmd Amr on 28/09/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import Foundation

class AddProductPresenter: IAddProductPresenter {
    
    weak var delegate: IAddProductView?
    var localManager: IAddProductManager?
    
    init(delegate: BaseAddEditViewProtocol) {
        self.delegate = delegate as? IAddProductView
        localManager = LocalManager.sharedInstance
    }
    
    func onAddClick(product: Product) {
        localManager?.addProduct(product: product, completion: { (res) in
            if res {
                self.delegate?.performActionWhenAddProductClick()
            } else {
                self.delegate?.showErrorMessage(errorMessage: Constants.addProductErrorMsg)
            }
        })
    }
}
