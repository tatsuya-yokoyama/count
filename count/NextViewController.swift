//
//  NextViewController.swift
//  count
//
//  Created by yokoyama.tatsuya on 2014/12/31.
//  Copyright (c) 2014年 yokoyama.tatsuya. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    var i = 0
    let imageNum = 34
    @IBOutlet weak var myImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        myImage!.image = UIImage(named:"omedeto.jpeg")
        NSTimer.scheduledTimerWithTimeInterval(1/10, target: self, selector: "updateView", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func updateView() {
        if i++ < 1 {
            sleep(3)
        }
        // arc4random()の戻り値に合わせてUInt32で除算
        let rand = Int(arc4random() % UInt32(self.imageNum)) + 1

        if ++i > 1000 {
            setOmedetoImage()
        } else {
            myImage!.image = UIImage(named:"\(rand).jpeg")
        }
    }
    func setOmedetoImage() {
        myImage!.image = UIImage(named:"omedeto.jpeg")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
