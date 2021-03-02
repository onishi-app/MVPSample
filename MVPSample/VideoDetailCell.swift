//
//  VideoDetailCell.swift
//  MVPSample
//
//  Created by ryosuke on 2021/02/27.
//

import UIKit
import SDWebImage

class VideoDetailCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var channelIcon: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // セルにデータを入れていく
    func configre(data: Snippet) {
        thumbnail.sd_setImage(with: URL(string: data.thumbnails.medium.url), completed: nil)
        title.text = data.title
        date.text = data.publishedAt
    }
}
