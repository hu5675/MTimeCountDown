//
//  MTimeCountDownOperation.swift
//  FBSnapshotTestCase
//
//  Created by mars on 2017/9/28.
//

import UIKit

public class MTimeCountDownOperationManager: NSObject {
    //单例
    public static let manager = MTimeCountDownOperationManager()
    var operationQueue:OperationQueue
    
    override init() {
        operationQueue = OperationQueue()
        super.init()
    }
    
    /// 开始倒计时，如果倒计时管理器里具有相同的key，则直接开始回调。
    ///
    /// - Parameters:
    ///   - key: 任务key，用于标示唯一性
    ///   - delay: 延迟执行时间 秒
    ///   - timeCount: 倒计时总时间，受操作系统后台时间限制，倒计时时间规定不得大于 120 秒.
    ///   - repeatBlock: 倒计时时，会多次回调，提供当前秒数
    ///   - finishBlock:  倒计时结束时调用
    public func startCountDown(_ key:String,delay: TimeInterval,timeCount:TimeInterval,repeatBlock:MTimeCountingDownTaskBlock?,finishBlock:MTimeFinishedBlock?) -> Void {
        if let _ = self.countDownTaskExsit(key) {
            //存在 则先结束 重新定时
            self.cancelTask(key)
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
            let task = MTimeCountDownTask()
            task.leftTimeInterval = timeCount
            task.countingDownBlcok = repeatBlock
            task.finishedBlcok = finishBlock
            task.name = key
            
            self.operationQueue.addOperation(task)
        }
    }
    
    /// 查询倒计时任务是否存在
    ///
    /// - Parameter key: 任务key，用于标示唯一性
    /// - Returns: 存在则返回，不存在返回nil
    fileprivate func countDownTaskExsit(_ key:String) -> MTimeCountDownTask?{
        for (_,task) in self.operationQueue.operations.enumerated() {
            let countDownTask = task as! MTimeCountDownTask
            if countDownTask.name == key {
                return countDownTask
            }
        }
        return nil
    }
    
    /// 取消所有倒计时任务
    public func cancelAllTask(){
        self.operationQueue.cancelAllOperations()
    }
    
    /// 挂起所有倒计时任务
    public func suspendAllTask(){
        self.operationQueue.isSuspended = true
    }
    
    /// 取消指定任务的倒计时任务
    ///
    /// - Parameter key: 任务key，用于标示唯一性
    public func cancelTask(_ key:String){
        for (_,task) in self.operationQueue.operations.enumerated() {
            let countDownTask = task as! MTimeCountDownTask
            if countDownTask.name == key {
                task.cancel()
                return
            }
        }
    }
}


/// operaton 执行任务
public class MTimeCountDownTask:Operation{
    var taskIdentifier: UIBackgroundTaskIdentifier = -1
    var leftTimeInterval: TimeInterval = 0
    var countingDownBlcok: MTimeCountingDownTaskBlock?
    var finishedBlcok: MTimeFinishedBlock?
    
    public override func main() {
        if self.isCancelled {
            return
        }
        
        taskIdentifier = UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
        
        while leftTimeInterval > 0 {
            if self.isCancelled {
                return
            }
            
            DispatchQueue.main.async {
                self.countingDownBlcok?(self.leftTimeInterval)
                self.leftTimeInterval -= 1
            }
            Thread.sleep(forTimeInterval: 1)
        }
        
        DispatchQueue.main.async {
            if self.isCancelled {
                return
            }
            
            self.finishedBlcok?(0)
        }
        
        if self.taskIdentifier != UIBackgroundTaskInvalid {
            UIApplication.shared.endBackgroundTask(self.taskIdentifier)
            self.taskIdentifier = UIBackgroundTaskInvalid
        }
    }
}
