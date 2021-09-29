//
//  AddEditProductViewController.swift
//  StoreApp
//
//  Created by Ahmd Amr on 28/09/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import UIKit

class AddEditProductViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var imageViewBackground: UIImageView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var saveButtonOutlet: UIButton!
    
    var presenter: BaseAddEditPresenterProtocol?
    var activityView:UIActivityIndicatorView?
    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeView()
        imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    func customizeView() {
        nameTextField.setBottomBorder()
        descriptionTextField.setBottomBorder()
        priceTextField.setBottomBorder()
        saveButtonOutlet.layer.cornerRadius = 28
        productImageView.layer.cornerRadius = 28
        imageViewBackground.layer.cornerRadius = 28
        
        let attrs = [NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 0.03529411765, green: 0.05882352941, blue: 0.2156862745, alpha: 1),
                     NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22)]
        navigationController?.navigationBar.standardAppearance.titleTextAttributes = attrs
        
        let backBTN = UIBarButtonItem(image: UIImage(named: "Iconly-Light-Arrow-Left"),
                                      style: .plain,
                                      target: navigationController,
                                      action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backBTN
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func uploadPrductImageButtonPressed(_ sender: Any) {
        self.imagePicker.present(from: sender as! UIView)
    }
}

extension AddEditProductViewController: BaseAddEditViewProtocol {
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

extension AddEditProductViewController: ImagePickerDelegate{
    func didSelect(image: UIImage?) {
        self.productImageView.image = image
    }
}
