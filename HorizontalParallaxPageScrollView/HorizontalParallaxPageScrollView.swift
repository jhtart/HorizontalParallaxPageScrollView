//
//  PallaxPageScrollView.swift
//  Memebox
//
//  Created by Elon on 2017. 7. 5..
//  Copyright © 2017년 memebox. All rights reserved.
//

import UIKit

protocol HorizontalParallaxPageScrollViewDelegate: class {
    func parallaxPageScrollViewDidScroll(_ scrollView: HorizontalParallaxPageScrollView, atContentOffset offset: CGPoint)
    func parallaxPageScrollViewDidEndDecelerating(_ scrollView: HorizontalParallaxPageScrollView)
}

class HorizontalParallaxPageScrollView: UIScrollView {
    var parallaxPageScrollViewDelegate: HorizontalParallaxPageScrollViewDelegate?
    private(set) var position = 0
    private(set) var count = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initialize() {
        contentSize = CGSize(width: CGFloat(contentSize.width), height: CGFloat(bounds.height))
        
        scrollsToTop = false
        bounces = true
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        isPagingEnabled = true
        delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentSize = CGSize(width: self.contentSize.width, height: bounds.size.height)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if point.x < 10 { // Swiper gesture back VC를 위한 responder chain 넘기기
            return nil
        }
        
        return self
    }
    
    // MARK: - Public method
    func addPage(_ view: UIView) {
        let count = subviews.count
        
        let scrollView = UIScrollView(frame: CGRect(x: bounds.size.width * CGFloat(count), y: 0, width: bounds.size.width, height: bounds.size.height) )
        scrollView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        scrollView.isScrollEnabled = false
        
        view.frame = bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        scrollView.addSubview(view)
        
        self.addSubview(scrollView)
        
        self.count = count + 1
        
        self.contentSize = CGSize(width: bounds.size.width * CGFloat(self.count), height: bounds.size.height)
    }
    
    func removePage(atPosition position: Int) -> Bool {
        return removePage(page(atPosition: position))
    }
    
    func removePage(_ page: UIView?) -> Bool {
        guard let page = page, let scrollView = page.superview as? UIScrollView else {
            return false
        }
        
        page.removeFromSuperview()
        scrollView.removeFromSuperview()
        
        return true
    }
    
    func removeAllPages() {
        subviews.forEach { $0.removeFromSuperview() }
        contentSize = bounds.size
        count = 0
    }
    
    func currentPage() -> Int {
        let realIndex = Int(contentOffset.x / bounds.width)
        
        return realIndex
    }
    
    func currentPageView() -> UIView? {
        let currentPageIdx = currentPage()
        return page(atPosition: currentPageIdx)
    }
    
    func indexOfPage(_ view: UIView) -> Int {
        if let index = subviews.index(of: view) {
            return index
        }
        return -1
    }
        
    func movePage(toPosition position: Int, animated: Bool) {
        DispatchQueue.main.async(execute: {[weak self]() -> Void in
            guard let wself = self else { return; }
            wself.setContentOffset(CGPoint(x: wself.bounds.width * CGFloat(position), y: 0.0), animated: animated)
        })
        
        self.position = position
    }
    
    func page(atPosition position: Int) -> UIView? {
        return subviews[safe: position]
    }
    
    func pages() -> [Any]? {
        var pages = [Any]()
        for i in 0..<count {
            if let page = page(atPosition: i) {
                pages.append(page)
            }
        }
        return pages
    }
}

extension HorizontalParallaxPageScrollView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        parallaxPageScrollViewDelegate?.parallaxPageScrollViewDidEndDecelerating(self)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        let currentScrollMoveX = (scrollView.contentOffset.x - (scrollView.frame.size.width * CGFloat(currentPage)))
        let ratio = currentScrollMoveX / 2
        
        if let subScrollView = subviews[safe: currentPage] as? UIScrollView {
            subScrollView.setContentOffset(CGPoint(x: -ratio, y:0), animated: false)
        }
        
        if let subScrollView = subviews[safe: currentPage+1] as? UIScrollView {
            subScrollView.setContentOffset(CGPoint(x: (scrollView.frame.size.width - currentScrollMoveX) / 2, y:0), animated: false)
        }
        
        parallaxPageScrollViewDelegate?.parallaxPageScrollViewDidScroll(self, atContentOffset: scrollView.contentOffset)
    }
}

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
