//
//  FilterProductsViewController.swift
//  StoreApp
//
//  Created by Ahmd Amr on 29/09/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import UIKit

class FilterProductsViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var selectedPriceLabel: UILabel!
    @IBOutlet weak var filterButtonOutlet: UIButton!
    
    var presenter: IFilterProductsPresenter?
    var activityView:UIActivityIndicatorView?
    var productsViewControllerDelegate: IProductsView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FilterProductPresenter(delegate: self)
        customizeView()
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
        filterButtonOutlet.layer.cornerRadius = 28
        nameTextField.setBottomBorder()
    }
    
    @IBAction func dismissGesture(_ sender: UITapGestureRecognizer) {
        presenter?.onDismiss()
    }
    
    @IBAction func priceSlider(_ sender: UISlider) {
        selectedPriceLabel.text = String(Int(sender.value))
    }
    
    @IBAction func filterButtonPreesed(_ sender: UIButton) {
        if let name = nameTextField.text {
            if let price = selectedPriceLabel.text {
                if name.isEmpty {
                    showErrorMessage(errorMessage: "Please enter product name!")
                } else {
                    presenter?.onFilterClick(product: Product(name: name, description: "", price: price, image: Data()))
                }
            }}
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        presenter?.onResetClick()
    }
}

extension FilterProductsViewController: IFilterProductsView {
    func performActionWhenFilterClick(product: Product) {
        dismiss(animated: true) {
            self.productsViewControllerDelegate?.filterProducts(with: product)
        }
    }
    
    func performActionWhenResetClick() {
        dismiss(animated: true) {
            self.productsViewControllerDelegate?.resetFilter()
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
        showSimpleToast(message: errorMessage)
    }
}
