//
//  AddProductViewController.swift
//  StoreApp
//
//  Created by Ahmd Amr on 29/09/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import UIKit

class AddProductViewController: AddEditProductViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add New Product"
        presenter = AddProductPresenter(delegate: self)
    }
    
    override func saveButtonPressed(_ sender: UIButton) {
        if let name = nameTextField.text {
            if let description = descriptionTextField.text {
                if let price = priceTextField.text {
                    if let image = productImageView.image {
                        if let data = image.pngData() {
                            if name.isEmpty || description.isEmpty || price.isEmpty {
                                showErrorMessage(errorMessage: "Please fill all fields")
                            } else {
                                (presenter as! IAddProductPresenter).onAddClick(product: Product(name: name, description: description, price: price, image: data))
                            }
                        } else {
                            showErrorMessage(errorMessage: "Failed to save image")
                        }
                    }}}}
    }
}

extension AddProductViewController: IAddProductView {
    func performActionWhenAddProductClick() {
        showToast(message: "New Product Added")
        navigationController?.popViewController(animated: true)
    }
}
