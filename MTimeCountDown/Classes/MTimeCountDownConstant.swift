//
//  MTimeCountDownConstant.swift
//  FBSnapshotTestCase
//
//  Created by mars on 2017/9/28.
//

/// 计时中回调
public typealias MTimeCountingDownTaskBlock = (_ timeInterval: TimeInterval) -> Void
// 计时结束后回调
public typealias MTimeFinishedBlock = (_ timeInterval: TimeInterval) -> Void
