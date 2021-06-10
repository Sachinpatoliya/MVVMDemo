
//
//  Constsnts.swift
//  PracticalTask
//
//  Created by Nikunj on 18/03/21.
//  Copyright © 2021 Nikunj. All rights reserved.
//

import Foundation


struct ApiNames {
    static let posts_lists = "posts"
    static let posts_comments = "comments"
    static let posts_users = "users"
}


struct CoredataEntityNames {
    static let Posts = "Posts"
    static let UserAddress = "UserAddress"
    static let Comments = "Comments"
    static let UserGeo = "UserGeo"
    static let Users = "Users"
    static let UserCompany = "UserCompany"
}

enum CellType{
    case Title
    case Description
    case UserDetail
    case CommentTitle
    case CommentDetail
}
