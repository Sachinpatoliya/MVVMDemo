//
//  PostDetailViewModel.swift
//  PostLists
//
//  Created by Sachin Patoliya on 10/06/21.
//

import UIKit

class PostDetailViewModel: NSObject {
    
    private var apiService : APIService!
    private var postDetailId : Int16!
    var postDetails : Posts!
    var users : Users!

    private(set) var postDetailData : [Comments]! {
        didSet {
            self.bindPostsDetailViewModelToController()
        }
    }
    
    var bindPostsDetailViewModelToController : (() -> ()) = {}
    
    init(postId: Int16, postDetail: Posts) {
        super.init()
        postDetailId = postId
        postDetails = postDetail
        self.apiService =  APIService()
        callFuncToGetPostDetailData()
        fetchUserFromCoredata()
    }
    
    func callFuncToGetPostDetailData() {
        self.apiService.getPostsDataWith(apiName: ApiNames.posts_comments, completion: { (result) in
            switch result {
            case .Success(let data):
                clearCoredata(entityName: CoredataEntityNames.Comments)
                saveCommentsInCoreDataWith(array: data, completion: { (comments) in
                    fetchComments(postId: self.postDetailId) { (commentsList) in
                        self.postDetailData = commentsList
                    }
                })
            case .Error(let message):
                DispatchQueue.main.async {
                    showAlertWith(title: "Error", message: message)
                }
            }
        })
    }
    
    func fetchUserFromCoredata() {
        fetchUser(userID: postDetails.userId) { (user) in
            self.users = user
        }
    }

}
