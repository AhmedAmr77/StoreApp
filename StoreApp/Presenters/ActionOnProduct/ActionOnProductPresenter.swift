//
//  ActionOnProductPresenter.swift
//  StoreApp
//
//  Created by Ahmd Amr on 29/09/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import Foundation

class ActionOnProductPreseneter: IActionOnProductPresenter {
    
    weak var delegate: IActionOnProductView?
    var localManager: IActionOnProductManager?
    
    init(delegate: IActionOnProductView) {
        self.delegate = delegate
        localManager = LocalManager.sharedInstance
    }
    
    func onDeleteClick(productName: String) {
        localManager?.deleteProduct(productName: productName, completion: { (res) in
            if res {
                self.delegate?.performActionWhenDeleteClick()
            } else {
                self.delegate?.showErrorMessage(errorMessage: Constants.deleteProductErrorMsg)
            }
        })
    }
    
    func onEditClick() {
        delegate?.performActionWhenEditClick()
    }
    
    func onDismiss() {
        self.delegate?.performActionWhenDeleteClick()
    }
}
