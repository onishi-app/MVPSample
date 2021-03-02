//
//  SearchVideoPresenter.swift
//  MVPSample
//
//  Created by ryosuke on 2021/02/27.
//

import Foundation

// SearchVideoViewControllerからのInputに必要な処理を記述
protocol SearchVideoPresenterInput {
    // 入力された文字を格納するための変数
    var inputText: String {get set}
    // inputTextに文字を代入するメソッド
    func setTextToInputText(text: String?)
    // 検索ボタンを押した時の処理
    func pushSearchButton()
}

// SearchVideoViewControllerへのOutputに必要な処理を記述
protocol SearchVideoPresenterOutput {
    // 画面遷移をさせるメソッド
    func transitionToVideoList(searchText: String)
}


final class SearchVideoPresenter: SearchVideoPresenterInput {
    
    private var view: SearchVideoPresenterOutput!
    var inputText: String = ""
    
    init(view: SearchVideoViewController) {
        self.view = view
    }
    
    func pushSearchButton() {
        view.transitionToVideoList(searchText: inputText)
    }

    func setTextToInputText(text: String?) {
        guard let inputText = text else {
            self.inputText = ""
            return
        }
        
        self.inputText = inputText
    }
    
}
