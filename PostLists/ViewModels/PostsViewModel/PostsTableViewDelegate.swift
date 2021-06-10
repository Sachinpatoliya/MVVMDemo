//
//  PostsTableViewDelegate.swift
//  PostLists
//
//  Created by Sachin Patoliya on 10/06/21.
//

import UIKit

class PostsTableViewDelegate<CELL : UITableViewCell,T> : NSObject, UITableViewDelegate {
    
    private var cellIdentifier : String!
    private var items : [T]!
    var configureCell : (CELL, T) -> () = {_,_ in }
    
    
    init(cellIdentifier : String, items : [T], configureCell : @escaping (CELL, T) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objDetail = topViewController()?.storyboard?.instantiateViewController(withIdentifier: "PostDetailViewController") as? PostDetailViewController
        objDetail?.postDetail = items[indexPath.row] as? Posts
        topViewController()?.navigationController?.pushViewController(objDetail!, animated: true)
    }
}
