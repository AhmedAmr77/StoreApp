//
//  EditProductPresenter.swift
//  StoreApp
//
//  Created by Ahmd Amr on 29/09/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import Foundation

class EditProductPresenter: IEditProductPresenter {
    
    weak var delegate: IEditProductView?
    var localManager: IEditProductManager?
    
    init(delegate: BaseAddEditViewProtocol) {
        self.delegate = delegate as? IEditProductView
        localManager = LocalManager.sharedInstance
    }
    
    func onEditClick(product: Product) {
        localManager?.editProduct(product: product, completion: { (res) in
            if res {
                self.delegate?.performActionWhenEditProductClick()
            } else {
                self.delegate?.showErrorMessage(errorMessage: Constants.editProductErrorMsg)
            }
        })
    }
}
