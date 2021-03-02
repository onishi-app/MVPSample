//
//  VideoListModel.swift
//  MVPSample
//
//  Created by ryosuke on 2021/02/27.
//

import Foundation
import Alamofire

protocol VideoListModelInput {
    func getYoutubeData(url: String, key: String, text: String, completion: @escaping (_ data: VideoModel) -> Void)
}

protocol VideoListModelOutput {
    func resultAPIData(data: VideoModel)
}

// Youtubeのデータを格納するモデル
final class VideoModel: Decodable {
    let kind: String
    let items: [Item]
}


final class Item: Decodable {
    let snippet: Snippet
}

final class Snippet: Decodable {
    let publishedAt: String
    let channelId: String
    let title: String
    let description: String
    let thumbnails: Thumbnail
}

final class Thumbnail: Decodable {
    let medium: ThumbnailsInfo
    let high: ThumbnailsInfo
}

final class ThumbnailsInfo: Decodable {
    let url: String
    let width: Int?
    let height: Int?
}




final class VideoListModel: VideoListModelInput {
    
    // youtubeのデータを取得する
    func getYoutubeData(url: String, key: String, text: String, completion: @escaping (VideoModel) -> Void) {
        let urlString = "\(url)?q=\(text)&key=\(key)"
        AF.request(urlString).responseJSON { (response) in
            do {
                guard let data = response.data else { return }
                let decode = JSONDecoder()
                let video = try decode.decode(VideoModel.self, from: data)
                completion(video)
            } catch {
                print("変換に失敗しました。\n【エラー内容】", error)
            }
        }
    }
}
