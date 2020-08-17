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
    
    private let alphaTarget: CGFloat = 0
    private let alphaMin: CGFloat = 0.1
    private let alphaDecay: CGFloat = 1 - pow(0.001, 1 / 500)
    private let velocityDecay: CGFloat = 0.9
    
    var particles: Set<Node> = []
    private var forces: [(CGFloat, inout Set<Node>) -> Void] = []
    private var ticks: [(inout Set<Node>) -> Void] = []
    
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
    
    public init() {
        
    }
    
    public func insert<U: Force>(force: U) {
        forces.append(force.tick)
    }
    
    public func insert(tick: @escaping (inout Set<Node>) -> Void) {
        ticks.append(tick)
    }
    
    public func insert(particle: Node) {
        particles.insert(particle)
    }
    
    public func remove(particle: Node) {
        particles.remove(particle)
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
        
        for force in forces {
            force(alpha, &particles)
        }
        
        for particle in particles {
            if particle.fixed {
                particle.velocity = .zero
            } else {
                particle.velocity *= velocityDecay
                particle.position += particle.velocity
            }
            particles.update(with: particle)
        }
        
        for particle in particles {
            particle.tick()
        }
        for tick in ticks {
            tick(&particles)
        }
        
//        NotificationCenter.default.post(name: .graphTick, object: nil, userInfo: nil)
    }
}
