//
//  PostsDetailTableViewDatasource.swift
//  PostLists
//
//  Created by Sachin Patoliya on 10/06/21.
//

import UIKit

class PostsDetailTableViewDatasource<CELL : UITableViewCell,T> : NSObject, UITableViewDataSource {
    
    private var cellIdentifier : String!
    private var items : [T]!
    var configureCell : (CELL, T?, CellType) -> () = {_,_,_  in }
    
    
    init(cellIdentifier : String, items : [T], configureCell : @escaping (CELL, T?, CellType) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4 + items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CELL
        
        if indexPath.row == 0{//Post Title cell
            self.configureCell(cell, nil, .Title)
        }else if indexPath.row == 1{ //Post Description Cell
            self.configureCell(cell, nil, .Description)
        }else if indexPath.row == 2{//Post User cell
            self.configureCell(cell, nil, .UserDetail)
        }else if indexPath.row == 3{
            self.configureCell(cell, nil, .CommentTitle)
        }else{
            let item = self.items[indexPath.row - 4]
            self.configureCell(cell, item, .CommentDetail)
        }
        return cell
    }
}
