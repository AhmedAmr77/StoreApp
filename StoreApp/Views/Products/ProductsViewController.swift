//
//  ProductsViewController.swift
//  StoreApp
//
//  Created by Ahmd Amr on 27/09/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {

    @IBOutlet weak var emptyListContainerView: UIView!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    var productsArr = [Product]()
    var presenter: IProductsPresenter?
    var activityView:UIActivityIndicatorView?
    var isFiltered = false
    var filteredArray = [Product]()
    var productFilter: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        presenter = ProductsPresenter(delegate: self)
        setupNavigationBar()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    
    func setupNavigationBar() {
        title = "Store Products"
        let attrs = [NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 0.03529411765, green: 0.05882352941, blue: 0.2156862745, alpha: 1),
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22)]
        navigationController?.navigationBar.standardAppearance.titleTextAttributes = attrs
        
        let addBtn = UIBarButtonItem(image: UIImage(named: "Add-Icon"), style: .plain, target: self, action: #selector(addButtonPressed))
        addBtn.tintColor = .black
        navigationItem.rightBarButtonItem = addBtn
        let filterBtn = UIBarButtonItem(image: UIImage(named: "Iconly-Light-Filter"), style: .plain, target: self, action: #selector(filterButtonPressed))
        filterBtn.tintColor = .black
        navigationItem.leftBarButtonItem = filterBtn
        
    }
    @objc private func addButtonPressed() {
        presenter?.onAddClick()
    }
    @objc private func filterButtonPressed() {
        presenter?.onFilterClick()
    }
        
    func registerCell() {
        let nibCell = UINib(nibName: Constants.productsCellIdentifier, bundle: nil)
        productsCollectionView.register(nibCell, forCellWithReuseIdentifier: Constants.productsCellIdentifier)
    }
    
    func getData() {
        presenter?.getProducts()
    }
}

extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltered{
            return filteredArray.count
        }
        return productsArr.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.productsCellIdentifier, for: indexPath) as! ProductsCollectionViewCell
        if isFiltered {
            cell.nameLabel.text = filteredArray[indexPath.row].name
            cell.descriptionLabel.text = filteredArray[indexPath.row].description
            cell.priceLabel.text = filteredArray[indexPath.row].price
            cell.imageView.image = UIImage(data: filteredArray[indexPath.row].image)
        } else {
            cell.nameLabel.text = productsArr[indexPath.row].name
            cell.descriptionLabel.text = productsArr[indexPath.row].description
            cell.priceLabel.text = productsArr[indexPath.row].price
            cell.imageView.image = UIImage(data: productsArr[indexPath.row].image)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.layer.bounds.width/2 - 20, height: collectionView.layer.bounds.width/2 - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset:CGFloat = 10
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.onItemClick(row: indexPath.row)
    }
}

extension ProductsViewController: IProductsView {
    func navigateToEditVC(with product: Product) {
        let vc = EditProductViewController(nibName: Constants.addEditProductVC, bundle: nil)
        vc.product = product
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func filterProducts(with product: Product) {
        productFilter = product
        filteredArray = productsArr.filter({ (productItem) -> Bool in
            productItem.name.lowercased() == product.name.lowercased() && productItem.price == product.price
        })
        if filteredArray.isEmpty {
            resetFilter()
            showErrorMessage(errorMessage: Constants.filterProductErrorMsg)
        } else {
            isFiltered = true
            productsCollectionView.reloadData()
        }
    }
    
    func resetFilter() {
        isFiltered = false
        filteredArray = []
        productsCollectionView.reloadData()
    }
    
    func renderViewWithProducts(with productsArray: [Product]) {
        productsArr = productsArray
        if isFiltered {
            guard let prodFilter = productFilter else {return}
            filterProducts(with: prodFilter)
        }
        if productsArr.count == 0 {
            emptyListContainerView.isHidden = false
            productsCollectionView.isHidden = true
        } else {
            emptyListContainerView.isHidden = true
            productsCollectionView.isHidden = false
            productsCollectionView.reloadData()
        }
    }
    
    func performActionWhenItemClick(row: Int) {
        let vc = ActionOnProductViewController(nibName: Constants.actionOnProductVC, bundle: nil)
        if isFiltered {
            vc.product = filteredArray[row]
        } else {
            vc.product = productsArr[row]
        }
        vc.productsViewControllerDelegate = self
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    func performActionWhenAddClick() {
        let vc = AddProductViewController(nibName: Constants.addEditProductVC, bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func performActionWhenFilterClick() {
        let vc = FilterProductsViewController(nibName: Constants.filterProductsVC, bundle: nil)
        vc.productsViewControllerDelegate = self
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
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

