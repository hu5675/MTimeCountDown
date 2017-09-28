//
//  MTimeCountDown.swift
//  FBSnapshotTestCase
//
//  Created by mars on 2017/9/28.
//

import UIKit
import Foundation

public class MTimeCountDownTimeSource : NSObject {
    
    var timer:DispatchSourceTimer?

    /// 开始计时
    ///
    /// - Parameters:
    ///   - delay: 延迟执行时间 秒
    ///   - timeCount: 倒计时时间 秒
    ///   - repeatBlock: 每执行一次的回调
    ///   - finishBlock: 倒计时结束回调
    public func startCountDown(delay: TimeInterval, timeCount: TimeInterval, repeatBlock:MTimeCountingDownTaskBlock?,finishBlock:MTimeFinishedBlock?) {
        timer = DispatchSource.makeTimerSource(queue:DispatchQueue.global())
        var timeCount = timeCount
        self.timer?.scheduleRepeating(deadline: .now() + delay, interval: .seconds(1))
        // 设定时间源的触发事件
        self.timer?.setEventHandler(handler: {
            // 每秒计时一次
            timeCount = timeCount - 1
            // 时间到了取消时间源
            if timeCount <= 0 {
                self.timer?.cancel()
                DispatchQueue.main.async {
                    //倒计时结束
                   finishBlock?(0)
                }
            }else{
                // 返回主线程处理一些事件，更新UI等等
                DispatchQueue.main.async {
                    //每次执行
                    repeatBlock?(timeCount)
                }
            }
        })
        self.timer?.resume()
    }
    
    /// 取消倒计时
    public func cancelCountDown(){
        self.timer?.cancel()
        self.timer = nil
    }
}
