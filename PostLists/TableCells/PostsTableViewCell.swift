//
//  PostsTableViewCell.swift
//  PostLists
//
//  Created by Sachin Patoliya on 10/06/21.
//

import UIKit

class PostsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var postsIdLabel: UILabel!
    @IBOutlet weak var postsTextLabel: UILabel!
    
    var posts : Posts? {
        didSet {
            postsIdLabel.text = posts?.title
            postsTextLabel.text = posts?.body
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
