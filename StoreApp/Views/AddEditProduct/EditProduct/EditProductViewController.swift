//
//  EditProductViewController.swift
//  StoreApp
//
//  Created by Ahmd Amr on 29/09/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import UIKit

class EditProductViewController: AddEditProductViewController {
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit Product"
        saveButtonOutlet.setTitle("Save", for: .normal)
        presenter = EditProductPresenter(delegate: self)
        loadData()
    }
    
    func loadData() {
        if let product = product {
            nameTextField.text = product.name
            descriptionTextField.text = product.description
            priceTextField.text = product.price
            productImageView.image = UIImage(data: product.image)
        }
    }
    
    override func saveButtonPressed(_ sender: UIButton) {
        if let name = nameTextField.text {
            if let description = descriptionTextField.text {
                if let price = priceTextField.text {
                    if let image = productImageView.image {
                        if let data = image.pngData() {
                        (presenter as! IEditProductPresenter).onEditClick(product: Product(name: name, description: description, price: price, image: data))
                        } else {
                            showErrorMessage(errorMessage: "Failed to save image")
                        }
                    } else {
                        showErrorMessage(errorMessage: "Please upload product image")
                    }
                } else {
                    showErrorMessage(errorMessage: "Please fill the price field")
                }
            } else {
                showErrorMessage(errorMessage: "Please fill the description field")
            }
        } else {
            showErrorMessage(errorMessage: "Please fill the name field")
        }
    }
}

extension EditProductViewController: IEditProductView {
    func performActionWhenEditProductClick() {
        showToast(message: "Product Edited")
        
        navigationController?.popToRootViewController(animated: true)
    }
}
