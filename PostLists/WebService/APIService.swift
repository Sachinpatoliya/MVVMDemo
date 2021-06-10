//
//  APIService.swift
//  MVVM_New
//
//  Created by Abhilash Mathur on 20/05/20.
//  Copyright © 2020 Abhilash Mathur. All rights reserved.
//

import Foundation

class APIService: NSObject {
    
    lazy var endPoint: String = {
        return "http://jsonplaceholder.typicode.com/"
    }()

    var activityIndicatorView: ActivityIndicatorView!

    func getPostsDataWith(apiName: String, completion: @escaping (Result<[[String: AnyObject]]>) -> Void) {
        
        let urlString = endPoint + apiName
        
        activityIndicatorView = ActivityIndicatorView(title: "Processing...", center: (topViewController()?.view.center)!)
        topViewController()?.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())
        self.activityIndicatorView.startAnimating()

        guard let url = URL(string: urlString) else { return completion(.Error("Invalid URL, we can't update your feed")) }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if self.activityIndicatorView != nil{
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                }
            }
            guard error == nil else { return completion(.Error(error!.localizedDescription)) }
            guard let data = data else { return completion(.Error(error?.localizedDescription ?? "There are no new Items to show"))
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [[String: AnyObject]] {
                    guard let itemsJsonArray = json as? [[String: AnyObject]] else {
                        return completion(.Error(error?.localizedDescription ?? "There are no new Items to show"))
                    }
                    DispatchQueue.main.async {
                        completion(.Success(itemsJsonArray))
                    }
                }
            } catch let error {
                return completion(.Error(error.localizedDescription))
            }
            }.resume()
    }
}

enum Result<T> {
    case Success(T)
    case Error(String)
}





