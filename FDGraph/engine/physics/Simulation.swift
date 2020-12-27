//
//  GraphController.swift
//  hu.hevi.node.ios
//
//  Created by Hevi on 18/05/2019.
//  Copyright © 2019 Hevi. All rights reserved.
//

import CoreGraphics
import QuartzCore

public class Simulation {
    
    public var tickCallback: (() -> ())?
    
    private let alphaTarget: CGFloat = 0
    private let alphaMin: CGFloat = 0.1
    private let alphaDecay: CGFloat = 1 - pow(0.001, 1 / 500)
    private let velocityDecay: CGFloat = 0.9
    
    var allParticles: Set<NodeParticle> = []
    var forceParticles: Set<NodeParticle> = []
    
    private var centerForce: (CGFloat, inout Set<NodeParticle>) -> Void
    private var linksForce: (CGFloat, inout Set<NodeParticle>) -> Void
    private var manyParticleForce: (CGFloat, inout Set<NodeParticle>) -> Void
    
    private var ticks: [(inout Set<NodeParticle>) -> Void] = []
    
    private weak var displayLink: CADisplayLink?
    
    private var alpha: CGFloat = 1 {
        didSet {
            self.start()
            if alpha < alphaMin {
                alpha = 0
                self.stop()
            }
            displayLink?.isPaused = (alpha < alphaMin)
        }
    }
    
    private var centerIndex: Int?
    
    public init(manyParticleForce: @escaping (CGFloat, inout Set<NodeParticle>) -> Void,
                linksForce: @escaping (CGFloat, inout Set<NodeParticle>) -> Void,
                centerForce: @escaping (CGFloat, inout Set<NodeParticle>) -> Void) {
        
        self.manyParticleForce = manyParticleForce
        self.linksForce = linksForce
        self.centerForce = centerForce
    }
    
    public func insert(center: Center) {
        self.centerForce = center.tick
    }
    
    public func insert(tick: @escaping (inout Set<NodeParticle>) -> Void) {
        ticks.append(tick)
    }
    
    public func insert(particle: NodeParticle) {
        allParticles.insert(particle)
    }
    
    public func remove(particle: NodeParticle) {
        allParticles.remove(particle)
    }
    
    public func start() {
        guard displayLink == nil else { return }
        print("simulation start...")
        let link = CADisplayLink(target: self, selector: #selector(tick))
        link.add(to: RunLoop.main, forMode: RunLoop.Mode.common)
        displayLink = link
    }
    
    public func stop() {
        print("simulation stop...")
        displayLink?.remove(from: RunLoop.main, forMode: RunLoop.Mode.common)
    }
    
    public func kick() {
        alpha = 1
    }
    
    @objc private func tick() {
        
        alpha += (alphaTarget - alpha) * alphaDecay;
        guard alpha > alphaMin else { return }
        
        self.manyParticleForce(alpha, &forceParticles)
        self.linksForce(alpha, &forceParticles)
        self.centerForce(alpha, &forceParticles)
        
        for particle in forceParticles {
            if particle.fixed {
                particle.velocity = .zero
            } else {
                particle.velocity *= velocityDecay
                particle.position += particle.velocity
            }
            forceParticles.update(with: particle)
            allParticles.update(with: particle)
        }
        
        for particle in forceParticles {
            particle.tick()
        }
        for tick in ticks {
            tick(&allParticles)
        }
        
        tickCallback?()
        
//        NotificationCenter.default.post(name: .graphTick, object: nil, userInfo: nil)
    }
}
