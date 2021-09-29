//
//  ActionOnProductViewController.swift
//  StoreApp
//
//  Created by Ahmd Amr on 29/09/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import UIKit

class ActionOnProductViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var editProductButtonOutlet: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var product: Product?
    var presenter: IActionOnProductPresenter?
    var activityView:UIActivityIndicatorView?
    var productsViewControllerDelegate: IProductsView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ActionOnProductPreseneter(delegate: self)
        customizeView()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    func customizeView() {
        containerView.layer.cornerRadius = 51
        editProductButtonOutlet.layer.cornerRadius = 28
    }
    
    func loadData() {
        if let product = product {
            nameLabel.text = product.name
            descriptionLabel.text = product.description
            priceLabel.text = product.price
            imageView.image = UIImage(data: product.image)
        }
    }
    
    @IBAction func dismissGesture(_ sender: UITapGestureRecognizer) {
        presenter?.onDismiss()
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        if let name = product?.name {
            presenter?.onDeleteClick(productName: name)
        }
    }
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        presenter?.onEditClick()
    }
}

extension ActionOnProductViewController: IActionOnProductView {
    func performActionWhenDeleteClick() {
        dismiss(animated: true) {
            self.productsViewControllerDelegate?.getData()
        }
    }
    
    func performActionWhenEditClick() {
        dismiss(animated: false) {
            guard let product = self.product else {return}
            self.productsViewControllerDelegate?.navigateToEditVC(with: product)
        }
    }
    
    func showLoading() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView!.center = self.view.center
        self.view.addSubview(activityView!)
        activityView!.startAnimating()
    }
    
    func hideLoading() {
        activityView!.stopAnimating()
    }
    
    func showErrorMessage(errorMessage: String) {
        print(errorMessage)
        navigationController?.showErrorMessage(errorMessage: errorMessage)
    }
}
