//
//  VideoListPresenter.swift
//  MVPSample
//
//  Created by ryosuke on 2021/02/27.
//

import Foundation
import Alamofire

protocol VideoListPresenterInput {
    // Viewが表示されるたびに呼ばれるメソッド
    func reloadData(url: String, key: String, text: String)
    var data: VideoModel? {get set}
}

protocol VideoListPresenterOutput {
    func reloadTableView()
}



final class VideoListPresenter: VideoListPresenterInput {
    var data: VideoModel?
    
    private var view: VideoListPresenterOutput!
    private var model: VideoListModelInput!
    
    init(view: VideoListViewController, model: VideoListModel) {
        self.view = view
        self.model = model
    }
    
    func reloadData(url: String, key: String, text: String) {
        model.getYoutubeData(url: url, key: key, text: text) { (data) in
            self.data = data
            self.view.reloadTableView()
        }
    }
}

