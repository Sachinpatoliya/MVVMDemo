//
//  PostsViewModel.swift
//  PostLists
//
//  Created by Sachin Patoliya on 10/06/21.
//

import UIKit

class PostsViewModel: NSObject {
    
    private var apiService : APIService!
    private(set) var postData : [Posts]! {
        didSet {
            self.bindPostsViewModelToController()
        }
    }
    
    var bindPostsViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService =  APIService()
        callFuncToGetPostData()
    }
    
    func callFuncToGetPostData() {
        self.apiService.getPostsDataWith(apiName: ApiNames.posts_lists, completion: { (result) in
            switch result {
            case .Success(let data):
                clearCoredata(entityName: CoredataEntityNames.Posts)
                saveInCoreDataWith(array: data, completion: { (posts) in
                    if posts.count > 0{
                        self.postData = posts
                    }
                })
            case .Error(let message):
                DispatchQueue.main.async {
                    showAlertWith(title: "Error", message: message)
                }
            }
            self.getUsersList()
        })
    }
    
    func getUsersList() {
        self.apiService.getPostsDataWith(apiName: ApiNames.posts_users) { (result) in
            switch result {
            case .Success(let data):
                clearUserData()
                saveUsersInCoreDataWith(array: data, completion: { (users) in

                })
            case .Error(let message):
                DispatchQueue.main.async {
                    showAlertWith(title: "Error", message: message)
                }
            }
        }
    }
}
