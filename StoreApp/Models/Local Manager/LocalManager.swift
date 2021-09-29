//
//  LocalManager.swift
//  StoreApp
//
//  Created by Ahmd Amr on 28/09/2021.
//  Copyright © 2021 ahmdamr. All rights reserved.
//

import UIKit
import CoreData

class LocalManager {
    ///   SINGLETON
    static let sharedInstance = LocalManager()
    private init(){}
}

extension LocalManager: IProductsManager {
    func getProducts(completion: @escaping ([Product]) -> Void) {
        var productsArr = [Product]()
        let appDelegte = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegte!.persistentContainer.viewContext
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: Constants.productsCoreDataEntityName)
        do{
            let productsMngObj = try context.fetch(fetchReq)
            for item in productsMngObj {
                if let name = item.value(forKey: Constants.productsCoreDataNameKey){
                    if let description = item.value(forKey: Constants.productsCoreDataDescriprionKey){
                        if let price = item.value(forKey: Constants.productsCoreDataPriceKey){
                            if let image = item.value(forKey: Constants.productsCoreDataImageKey){
                                productsArr.append(Product(name: name as! String, description: description as! String, price: price as! String, image: image as! Data))
                            }
                        }
                    }
                }
            }
        } catch {
            print("Catch  GET")
        }
        completion(productsArr)
    }
}

extension LocalManager: IAddProductManager {
    func addProduct(product: Product, completion: @escaping (Bool) -> Void) {
        let appDelegte = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegte!.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: Constants.productsCoreDataEntityName, in: context) else {return}
        let productsMngObj = NSManagedObject(entity: entity, insertInto: context)
        productsMngObj.setValue(product.name, forKey: Constants.productsCoreDataNameKey)
        productsMngObj.setValue(product.description, forKey: Constants.productsCoreDataDescriprionKey)
        productsMngObj.setValue(product.price, forKey: Constants.productsCoreDataPriceKey)
        productsMngObj.setValue(product.image, forKey: Constants.productsCoreDataImageKey)
        do{
            try context.save()
            completion(true)
        } catch {
            completion(false)
        }
    }
}

extension LocalManager: IEditProductManager {
    func editProduct(product: Product, completion: @escaping (Bool) -> Void) {
        let appDelegte = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegte!.persistentContainer.viewContext
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: Constants.productsCoreDataEntityName)
        do{
            let productsMngObj = try context.fetch(fetchReq)
            for item in productsMngObj {
                if let name = item.value(forKey: Constants.productsCoreDataNameKey){
                    if product.name == name as! String {
                        item.setValue(product.name, forKey: Constants.productsCoreDataNameKey)
                        item.setValue(product.description, forKey: Constants.productsCoreDataDescriprionKey)
                        item.setValue(product.price, forKey: Constants.productsCoreDataPriceKey)
                        item.setValue(product.image, forKey: Constants.productsCoreDataImageKey)
                        do{
                            try context.save()
                            completion(true)
                            return
                        } catch {
                            completion(false)
                            return
                        }
                    }
                }
            }
        } catch {
            print("Catch  Edit")
        }
        completion(false)
    }
}

extension LocalManager: IActionOnProductManager {
    func deleteProduct(productName: String, completion: @escaping (Bool) -> Void) {
        let appDelegte = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegte!.persistentContainer.viewContext
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: Constants.productsCoreDataEntityName)
        do{
            let productsMngObj = try context.fetch(fetchReq)
            for item in productsMngObj {
                if let name = item.value(forKey: Constants.productsCoreDataNameKey){
                    if productName == name as! String {
                        context.delete(item)
                        try context.save()
                        completion(true)
                        return
                    }
                }
            }
        } catch {
            print("Catch  DLT")
        }
        completion(false)
    }
}
