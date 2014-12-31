//
//  ViewController.swift
//  count
//
//  Created by yokoyama.tatsuya on 2014/12/30.
//  Copyright (c) 2014年 yokoyama.tatsuya. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    // 現在の時刻
    var currentTime = NSDate()
    // 新年までの時間
    var restTime : Int = 1000
    // 新年になる時刻(GMTで定義)
    let newTimeStr : String = "2015/01/01 09:00:00:000"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfig()
        makeView()
        // 更新
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1/3, target: self, selector: "updateView", userInfo: nil, repeats: true)
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
        myLabelHNY.text = "2015年まで あと\(self.restTime)秒"
        myLabel.text = dateFormatter.stringFromDate(currentTime)
    }
    // 残り時間を計算
    func calcRestTime() -> Int {
        let newTime = dateFormatter.dateFromString(self.newTimeStr)!
        var rest = newTime.timeIntervalSinceNow
        return Int(rest)
    }
    // 更新
    func updateView() {
        self.restTime = calcRestTime()
        if !self.isChanged {
            // 切り替え前
            if self.restTime > 69690 {
                currentTime = NSDate()
                makeView()
                println("before \(i++), \(self.restTime)")
            } else {
                println("kirikae done")
                self.isChanged = true
                self.timer.invalidate()
                play()
                performSegueWithIdentifier("toNextViewController", sender: nil)
            }
        } else {
            // 切り替え後
            println("already")
        }
    }
    func play() {
        // 音声ファイルパス取得
        let audioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!)
        // プレイヤー準備
        player = AVAudioPlayer(contentsOfURL: audioPath, error: nil)
        player.prepareToPlay()
        player.play()
    }
}

