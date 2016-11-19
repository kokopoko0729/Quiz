//
//  QuizViewController.swift
//  Quiz
//
//  Created by ぽこここ on 2016/11/05.
//  Copyright © 2016年 ぽこここ. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    //問題文を格納する配列
    var quizArray = [AnyObject]()
    
    //正解数
    var correctAnswer: Int = 0
    
    //クイズを表示するTextView
    @IBOutlet var quizTextView: UITextView!
    
    //選択肢のボタン
    @IBOutlet var choiceButton1: UIButton!
    @IBOutlet var choiceButton2: UIButton!
    @IBOutlet var choiceButton3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //一時的にクイズを格納しておく配列
        var tmpArray = [AnyObject]()
        
        //tmpArrayに問題文と３つの選択肢と答えの番号が入った配列を追加していく
        tmpArray.append(["日本一チャンネル登録者が多いYouTuberは？","ヒカキン","瀬戸弘司","はじめシャチョー",3])
        tmpArray.append(["甘いのは？","塩","砂糖","七味",2])
        tmpArray.append(["辛いのは？","醤油","砂糖","わさび",3])
        tmpArray.append(["哺乳類は？","キツネ","イカ","カエル",1])
        tmpArray.append(["大きいのは？","11インチ","13インチ","15インチ",3])
        tmpArray.append(["物語の主人公は？","ベジータ","ルフィ","ジャイアン",2])
        
        
        //問題をシャッフルしてquizArrayに格納する
        srand(UInt32(time(nil)))
        while (tmpArray.count > 0) {
            let index = Int(rand()) % tmpArray.count
            quizArray.append(tmpArray[index])
            tmpArray.removeAtIndex(index)
        }
        
        choiceQuiz()
        // Do any additional setup after loading the view.
    }
    
    func choiceQuiz() {
        
        //問題文のテキストを表示
        quizTextView.text = quizArray[0][0] as! String
        
        //選択肢のボタンにそれぞれ選択肢のテキストセット
        choiceButton1.setTitle(quizArray[0][1] as? String, forState: .Normal)
        choiceButton2.setTitle(quizArray[0][2] as? String, forState: .Normal)
        choiceButton3.setTitle(quizArray[0][3] as? String, forState: .Normal)
    }
    
    @IBAction func choiceAnswer(sender: UIButton) {
        if quizArray[0][4] as! Int == sender.tag {
            
            //正解数を増やす
            correctAnswer = correctAnswer + 1
        }
        
        //解いた問題をpuizArrayから取り除く
        quizArray.removeAtIndex(0)
        
        //解いた問題数の合計が予め設定していた問題数に達したら結果画面へ
        if quizArray.count == 0 {
            performSegueToResult()
        } else {
            choiceQuiz()
        }
    }
    
    func performSegueToResult() {
        performSegueWithIdentifier("toResultView", sender: nil)
        
    }
    //セグエを準備（prepare)するときに呼ばれるメソッド
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toResultView" {
            let resultViewController = segue.destinationViewController as! ResultViewController
            resultViewController.correctAnswer = self.correctAnswer
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
