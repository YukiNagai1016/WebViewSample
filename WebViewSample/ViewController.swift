//
//  ViewController.swift
//  WebViewSample
//
//  Created by 優樹永井 on 2019/02/25.
//  Copyright © 2019 com.nagai. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate {
    
    //記事タイトル
    var NewsItems = ["言葉の力", "年末年始タイ旅", "ミレニアル世代の声","幸せとは"]
    
    //記事URL
    var NewsURL = ["https://note.mu/yukinagai1016/n/n84b50ebd43a3","https://note.mu/yukinagai1016/n/nc08886de17e1","https://note.mu/yukinagai1016/n/ne26c8ba4cd87","https://note.mu/yukinagai1016/n/n234d4dc44142"]
    
    //変数宣言
    var tableView: UITableView = UITableView()
    var webView:UIWebView = UIWebView()
    var goButton:UIButton!
    var backButton:UIButton!
    var cancelButton:UIButton!
    var dotsView:DotsLoader! = DotsLoader()
    
    //画面起動時
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //背景画像をつくる
        let imageView = UIImageView()
        imageView.frame = self.view.bounds
        imageView.image = UIImage(named: "")
        imageView.alpha = 0.6
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        self.view.addSubview(imageView)
        
        //tableViewを作成する
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - 54.0)
        tableView.backgroundColor = UIColor.clear
        self.view.addSubview(tableView)
        
        //webView設定
        webView.frame = tableView.frame
        webView.delegate = self
        webView.scalesPageToFit = true
        webView.contentMode = .scaleAspectFit
        self.view.addSubview(webView)
        webView.isHidden = true
        
        //1つ進むボタン
        goButton = UIButton()
        goButton.frame = CGRect(x: self.view.frame.size.width - 50, y:self.view.frame.size.height - 128 , width: 50, height: 50)
        goButton.setImage(UIImage(named:"go.png"), for: .normal)
        goButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        self.view.addSubview(goButton)
        
        //戻るボタン
        backButton = UIButton()
        backButton.frame = CGRect(x: 10, y:self.view.frame.size.height - 128, width: 50, height: 50)
        backButton.setImage(UIImage(named:"back.png"), for: .normal)
        backButton.addTarget(self, action: #selector(backPage), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        //キャンセルボタン
        cancelButton = UIButton()
        cancelButton.frame = CGRect(x: 10, y:80, width: 50, height: 50)
        cancelButton.setImage(UIImage(named:"home.png"), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        self.view.addSubview(cancelButton)
        
        //デフォルトで非表示にする
        goButton.isHidden = true
        backButton.isHidden = true
        cancelButton.isHidden = true
        
        
        //ロード中に表示するアニメーション設定
        dotsView.frame = CGRect(x: 0, y: self.view.frame.size.height/3, width: self.view.frame.size.width, height: 100)
        dotsView.dotsCount = 5
        dotsView.dotsRadius = 10
        self.view.addSubview(dotsView)
        dotsView.isHidden = true
    }
    
    
    //セルの個数を決める
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //配列の要素の個数を決める
        return NewsItems.count
    }
    
    //セルの内容を決める(セルの中身に何を表示するか)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = NewsItems[indexPath.row] as? String
        cell.textLabel?.textColor = UIColor.black
        cell.imageView?.image = UIImage(named: NewsItems[indexPath.row])
        cell.imageView?.layer.borderColor = UIColor.black.cgColor
        cell.imageView?.layer.borderWidth = 3

        return cell
    }
    
    // セルが選択された時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //WebViewを表示する
        let linkURL = NewsURL[indexPath.row]
        
        let url:URL = URL(string:linkURL)!
        let urlRequest = NSURLRequest(url: url)
        webView.loadRequest(urlRequest as URLRequest)
    }
    
    //セルの高さを指定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    //WebViewのtロード開始時
    func webViewDidStartLoad(_ webView: UIWebView) {
        dotsView.isHidden = false
        dotsView.startAnimating()
    }
    
    //WebViewのロード終了時
    func webViewDidFinishLoad(_ webView: UIWebView) {
        //非表示状態
        dotsView.isHidden = true
        dotsView.stopAnimating()
        
        //表示状態
        webView.isHidden = false
        goButton.isHidden  = false
        backButton.isHidden = false
        cancelButton.isHidden = false
    }
    
    //webViewを1ページ進めるメソッド
    @objc func nextPage(){
        webView.goForward()
    }
    
    //webViewを1ページ戻すメソッド
    @objc func backPage(){
        webView.goBack()
    }
    
    //webViewを隠すメソッド
    @objc func cancel(){
        //すべて非表示にする
        webView.isHidden = true
        goButton.isHidden = true
        backButton.isHidden = true
        cancelButton.isHidden = true
    }
    
}
