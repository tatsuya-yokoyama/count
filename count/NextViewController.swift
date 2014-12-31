//
//  NextViewController.swift
//  count
//
//  Created by yokoyama.tatsuya on 2014/12/31.
//  Copyright (c) 2014年 yokoyama.tatsuya. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    @IBOutlet weak var myImage: UIImageView!
    var i = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let img = UIImage(named:"omedeto.jpeg")
        myImage!.image = img
        // Do any additional setup after loading the view.
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
        var rand = Int(arc4random()%34)+1
        var randStr = String(rand)
        //println(rand)
        if ++i > 1000 {
            randStr = "omedeto"
        }
        let img = UIImage(named:"\(randStr).jpeg")
       // println("view")
        myImage!.image = img
       
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
