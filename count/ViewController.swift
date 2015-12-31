//
//  ViewController.swift
//  count
//
//  Created by yokoyama.tatsuya on 2014/12/30.
//  Copyright (c) 2014年 yokoyama.tatsuya. All rights reserved.
//
//  2015年をすぎたため、L62にnewTime = afterTime // デバッグ用をたしてます。

import UIKit
import AVFoundation

class ViewController: UIViewController {
    // 現在の時刻
    var currentTime = NSDate()
    // 新年までの時間
    var restTime : Int = 1000
    // 新年になる時刻
    let newTimeStr : String = "2016/01/01 00:00:00:000"
    let afterTime = NSDate(timeIntervalSinceNow: 10);
    // 時刻を扱うクラス(後で色々使う)
    var dateFormatter : NSDateFormatter = NSDateFormatter()
    // 更新されたことのデバッグ用のイテレータ
    var i = 0
    var isChanged = false
    
    var player : AVAudioPlayer! = nil
    
    var timer = NSTimer()
    // 表示ラベル
    @IBOutlet weak var myLabelHNY: UILabel!
    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var myImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myImage!.image = UIImage(named:"eva.png")
        setConfig()
        makeView()
        // 更新
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1/100, target: self, selector: "updateView", userInfo: nil, repeats: true)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.playAtRest()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // dateFormatterのパラメーターを設定
    func setConfig() {
        self.dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        self.dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss:SSS"
    }
    // Labelに出力
    func makeView() {
        myLabelHNY.text = "2016年まで あと\(self.restTime)秒"
        myLabel.text = dateFormatter.stringFromDate(currentTime)
    }
    // 残り時間を計算
    func calcRestTime() -> Int {
        var newTime = dateFormatter.dateFromString(self.newTimeStr)!
        newTime = afterTime // デバッグ用
        let rest = newTime.timeIntervalSinceNow
        return Int(rest)
    }
    // 更新
    func updateView() {
        self.restTime = calcRestTime()
        if !self.isChanged {
            // 切り替え前
            if self.restTime > 0 {
                currentTime = NSDate()
                makeView()
                print("before \(i++), \(self.restTime)")
            } else {
                print("kirikae done")
                self.isChanged = true
                self.timer.invalidate()
                play()
                performSegueWithIdentifier("toNextViewController", sender: nil)
            }
        } else {
            // 切り替え後
            print("already")
        }
    }
    func playAtRest() {
        // 音声ファイルパス取得
        let audioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("fly", ofType: "mp3")!)
        // プレイヤー準備
        player = try? AVAudioPlayer(contentsOfURL: audioPath)
        player.prepareToPlay()
        player.play()
    }
    func play() {
        // 音声ファイルパス取得
        let audioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!)
        // プレイヤー準備
        player = try? AVAudioPlayer(contentsOfURL: audioPath)
        player.prepareToPlay()
        player.play()
    }
}

