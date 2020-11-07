//
//  GraphScrollView.swift
//  ForceDirectedNew
//
//  Created by Hevi on 14/03/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import Foundation
import UIKit

class GraphScrollView: UIScrollView {
    
    var graphView: GraphView?
    
    func display(_ graphView: GraphView) {
        
        self.graphView?.removeFromSuperview()
        self.graphView = nil
        
        self.graphView = graphView
        self.addSubview(graphView)
        
    }
    
    func setup() {
        
        
        
        self.delegate = self
        self.zoomScale = 1
        self.contentSize = CGSize(width: GraphController.GRAPH_CANVAS_SIZE, height: GraphController.GRAPH_CANVAS_SIZE)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentOffset = CGPoint(x: GraphController.GRAPH_CANVAS_SIZE / 2, y: GraphController.GRAPH_CANVAS_SIZE / 2)
        
        self.setMaxMinZoomScaleForCurrentBounds()
        //        self.centerImage()
        
        //        if let circle = graphView?.circles[0] {
        //            self.scrollToView(view: circle, animated: false)
        //        }
        
    }
    
    private func centerImage() {
        guard var frameToCenter = graphView?.frame else { return }
        let boundsSize = self.frame.size
        
        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width)/2
        } else {
            frameToCenter.origin.x = 0
        }
        
        if frameToCenter.size.height < boundsSize.height {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height)/2
        } else {
            frameToCenter.origin.y = 0
        }
        
        graphView?.frame = frameToCenter
    }
    
    func scrollToView(view:UIView, animated: Bool) {
        if let origin = view.superview {
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            
            let newX = childStartPoint.x - self.bounds.width / 2
            let newY = childStartPoint.y - self.bounds.height / 2
            
            self.scrollRectToVisible(CGRect(x: newX, y: newY, width: self.frame.width, height: self.frame.height), animated: animated)
        }
    }
    
    func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }
    
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }
    
    func scrollLeft() {
        let leftOffset = CGPoint(x: contentOffset.x - 400, y: contentOffset.y)
        setContentOffset(leftOffset, animated: true)
    }
    
    func scrollRight() {
        let leftOffset = CGPoint(x: contentOffset.x + 400, y: contentOffset.y)
        setContentOffset(leftOffset, animated: true)
    }
    
    func scrollUp() {
        let leftOffset = CGPoint(x: contentOffset.x, y: contentOffset.y - 400)
        setContentOffset(leftOffset, animated: true)
    }
    
    func scrollDown() {
        let leftOffset = CGPoint(x: contentOffset.x, y: contentOffset.y + 400)
        setContentOffset(leftOffset, animated: true)
    }
    
    func zoomIn() {
        UIView.animate(withDuration: 0.2) {
            self.zoomScale = self.zoomScale * 1.2
        }
        
    }
    
    func zoomOut() {
        UIView.animate(withDuration: 0.2) {
            self.zoomScale = self.zoomScale * 0.8
        }
    }
    
}

extension GraphScrollView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.graphView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.centerImage()
    }
    
    func setMaxMinZoomScaleForCurrentBounds() {
        guard let imageSize = self.graphView?.bounds.size else { return }
        let boundsSize = self.bounds.size
        
        let xScale =  boundsSize.width  / imageSize.width
        let yScale = boundsSize.height / imageSize.height
        let minScale = min(xScale, yScale)
        
        //        var maxScale: CGFloat = 5.0
        //        if minScale < 0.1 {
        //            maxScale = 0.3
        //        }
        //        if minScale >= 0.1 && minScale < 0.5 {
        //            maxScale = 0.7
        //        }
        //        if minScale >= 0.5 {
        //            maxScale = max(1.0, minScale)
        //        }
        //
        self.maximumZoomScale = 6
        self.minimumZoomScale = minScale
    }
    
    
}
