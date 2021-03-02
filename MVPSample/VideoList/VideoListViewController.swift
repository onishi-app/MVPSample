//
//  VideoListViewController.swift
//  MVPSample
//
//  Created by ryosuke on 2021/02/27.
//
// VideoListでやること
// 検索内容をもとにAPIを取得しtableViewに表示

import UIKit

class VideoListViewController: UIViewController {

    @IBOutlet weak var videoListTableView: UITableView!
    
    // youtubeのAPI取得のためのURLとKEY
    private let url = "https://www.googleapis.com/youtube/v3/search"
    private let key = "AIzaSyDqWqDc0lL633AinIHA9JkeVEvLR1kz1KU&part=snippet"
    var inputText: String = ""
    
    private var presenter: VideoListPresenterInput!
    func inject(presenter: VideoListPresenter) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let model = VideoListModel()
        let presenter = VideoListPresenter(view: self, model: model)
        inject(presenter: presenter)

        videoListTableView.delegate = self
        videoListTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 画面読み込みと同時にAPIデータ取得
        presenter.reloadData(url: url, key: key, text: inputText)

    }
}

extension VideoListViewController: VideoListPresenterOutput {
    func reloadTableView() {
        videoListTableView.reloadData()
    }
    
    
}

extension VideoListViewController: UITableViewDelegate {
    
}

extension VideoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = presenter.data else {
            return 0
        }
        return data.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        videoListTableView.register(UINib(nibName: "VideoDetailCell", bundle: nil), forCellReuseIdentifier: "VideoDetailCell")
        let cell = videoListTableView.dequeueReusableCell(withIdentifier: "VideoDetailCell") as! VideoDetailCell
        
        
        if let data = presenter.data {
            cell.configre(data: data.items[indexPath.row].snippet)
        }
        
        return cell
    }
    
    
}
