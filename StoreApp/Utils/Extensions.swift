//
//  Extensions.swift
//  StoreApp
//
//  Created by Ahmd Amr on 28/09/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import UIKit

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

extension UINavigationController {
    func showErrorMessage(errorMessage: String) {
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel)
        { action -> Void in
            // Put your code here
        })
        self.present(alertController, animated: true, completion: nil)
    }
}

extension UIViewController {
    func showToast(message : String) {
        print("inside toast")
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        imageView.image = UIImage(named: "Check")
        
        //Text Label
        let textLabel = UILabel()
        textLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        textLabel.text  = message
        textLabel.font = UIFont.boldSystemFont(ofSize: 14)
        textLabel.textAlignment = .center
        textLabel.textColor = .white
        
        //Stack View
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 8.0

        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(textLabel)
        
        
        let viewContainer = UIView(frame: CGRect(x: self.view.frame.size.width/2 - 125, y: self.view.frame.size.height-125, width: 250, height: 40))
        viewContainer.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        viewContainer.alpha = 1.0
        viewContainer.layer.cornerRadius = 18;
        viewContainer.clipsToBounds  =  true
        viewContainer.addSubview(stackView)
        
        self.view.window?.addSubview(viewContainer)
        
        UIView.animate(withDuration: 4.0, delay: 0.0, options: .curveEaseIn, animations: {
            viewContainer.alpha = 0.0
        }, completion: {(isCompleted) in
            viewContainer.removeFromSuperview()
        })
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        //Constraints
        stackView.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: viewContainer.frame.width).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: viewContainer.frame.height).isActive = true
    }
    
    func showSimpleToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 190, y: self.view.frame.size.height-100, width: 380, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 5.0, delay: 0.2, options: .curveEaseIn, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
