//
//  BaseContract.swift
//  StoreApp
//
//  Created by Ahmd Amr on 28/09/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import Foundation

protocol BaseViewProtocol {
    func showLoading()
    func hideLoading()
    func showErrorMessage(errorMessage: String)
}

protocol BaseAddEditViewProtocol: class, BaseViewProtocol {}
protocol BaseAddEditPresenterProtocol {}
