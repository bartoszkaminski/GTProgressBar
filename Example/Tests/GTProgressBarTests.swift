//
//  GTProgressBarTests.swift
//  GTProgressBar
//
//  Created by Grzegorz Tatarzyn on 19/09/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import Nimble
import GTProgressBar

class GTProgressBarTests: XCTestCase {
    
    func testInitWithFrame_shouldCreateProgressBarBackgroundAndFillViews() {
        let view = GTProgressBar(frame: CGRect.zero)
        
        expect(view.subviews).to(haveCount(2))
    }
    
    func testLayoutSubviews_shouldSetBackgroundViewFrameToSameSizeAsTheParent() {
        let view = setupView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
        
        let expectedFrame = CGRect(x: 0, y: 0, width: 100, height: 100)
        expect(view.subviews.first!.frame).to(equal(expectedFrame))
    }
    
    func testLayoutSubviews_shouldRenderBackgroundViewWithDefaultBorder() {
        let view = setupView()
        let backgroundView = view.subviews.first!
        
        expect(backgroundView.layer.borderWidth).to(equal(2))
    }
    
    func testLayoutSubviews_shouldRenderBackgroundViewWithRoundedCorners() {
        let view = setupView(frame: CGRect(x: 0, y: 0, width: 100, height: 10))
        let backgroundView = view.subviews.first!
        
        let expectedRoundedCorners: CGFloat = 3.5
        expect(backgroundView.layer.cornerRadius).to(beCloseTo(expectedRoundedCorners, within: 0.01))
    }
    
    func testLayoutSubviews_shouldRenderBackgroundViewWithDefaultColors() {
        let view = setupView()
        let backgroundView = view.subviews.first!
        
        expect(backgroundView.layer.borderColor).to(equal(UIColor.black.cgColor))
        expect(backgroundView.backgroundColor).to(equal(UIColor.white))
    }
    
    func testLayoutSubviews_shouldCalculateCorrectFrameForFillView() {
        let view = setupView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
        
        let expectedFrame = CGRect(x: 4, y: 4, width: 92, height: 92)
        expect(view.subviews[1].frame).to(equal(expectedFrame))
    }
    
    func testLayoutSubviews_shouldRenderFillViewWithRoundedCorners() {
        let view = setupView(frame: CGRect(x: 0, y: 0, width: 100, height: 10))
        
        let expectedRoundedCorners: CGFloat = 0.7
        expect(view.subviews[1].layer.cornerRadius).to(beCloseTo(expectedRoundedCorners, within: 0.01))
    }
    
    func testLayoutSubviews_shouldRenderFillViewWithDefaultFillColor() {
        let view = setupView()
        
        expect(view.subviews[1].backgroundColor).to(equal(UIColor.black))
    }
    
    func testLayoutSubivews_shouldSetCorrectWidthForFillViewWhenProgressSet() {
        let view = setupView()
        view.progress = 0.5
        view.layoutSubviews()
        
        let expectedFrameWidth: CGFloat = 46
        expect(view.subviews[1].frame.width).to(equal(expectedFrameWidth))
    }
    
    func testLayoutSubivews_shouldNotAllowNegativeValuesForProgress() {
        let view = setupView()
        view.progress = -0.5
        view.layoutSubviews()
        
        let expectedFrameWidth: CGFloat = 0
        expect(view.subviews[1].frame.width).to(equal(expectedFrameWidth))
    }
    
    func testLayoutSubivews_shouldNotAllowProgressToBeGreaterThanOne() {
        let view = setupView()
        view.progress = 1.5
        view.layoutSubviews()
        
        let expectedFrameWidth: CGFloat = 92
        expect(view.subviews[1].frame.width).to(equal(expectedFrameWidth))
    }
    
    func testShouldAllowToSetProgressBarBorderColor() {
        let view = setupView()
        view.barBorderColor = UIColor.yellow
        
        view.layoutSubviews()
        
        expect(view.subviews.first!.layer.borderColor).to(equal(UIColor.yellow.cgColor))
    }
    
    private func setupView(frame: CGRect = CGRect(x: 0, y: 0, width: 100, height: 100)) -> GTProgressBar {
        let view = GTProgressBar(frame: frame)
        view.layoutSubviews()
        
        return view
    }
    
}
