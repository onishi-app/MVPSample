//
//  SearchVideoViewController.swift
//  MVPSample
//
//  Created by ryosuke on 2021/02/27.
//

import UIKit

class SearchVideoViewController: UIViewController {
    // 検索用のフィールド
    @IBOutlet weak var searchTextField: UITextField!
    
    private var presenter: SearchVideoPresenterInput!
    func inject(presenter: SearchVideoPresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let presenter = SearchVideoPresenter(view: self)
        inject(presenter: presenter)
        
        searchTextField.delegate = self
        
    }
    
    // 検索ボタンが押された時の処理
    @IBAction func pushSearchButton(_ sender: Any) {
        presenter.pushSearchButton()
    }
    
}

extension SearchVideoViewController: UITextFieldDelegate {
    
    // キーボードが閉じられたら実行される
    func textFieldDidEndEditing(_ textField: UITextField) {
        // PresenterのinputTextに値を代入
        presenter.setTextToInputText(text: textField.text)
    }
    
    // return を押したらキーボードを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // キーボード意外をタッチしたらキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchTextField.resignFirstResponder()
    }
}

extension SearchVideoViewController: SearchVideoPresenterOutput {
    
    // 画面遷移の処理
    func transitionToVideoList(searchText: String) {
        
        let videoListVC = UIStoryboard(
            name: "VideoList",
            bundle: nil)
            .instantiateViewController(withIdentifier: "VideoList") as! VideoListViewController
        
        videoListVC.inputText = presenter.inputText
        
        navigationController?.pushViewController(videoListVC, animated: true)
    }
    
}
