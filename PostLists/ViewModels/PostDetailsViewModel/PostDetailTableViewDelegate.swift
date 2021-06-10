//
//  PostDetailTableViewDelegate.swift
//  PostLists
//
//  Created by Sachin Patoliya on 10/06/21.
//

import UIKit

class PostDetailTableViewDelegate<CELL : UITableViewCell> : NSObject, UITableViewDelegate {
    
    private var cellIdentifier : String!
    
    
    init(cellIdentifier : String) {
        self.cellIdentifier = cellIdentifier
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
