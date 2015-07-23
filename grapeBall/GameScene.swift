//
//  GameScene.swift
//  grapeBall
//
//  Created by hiroki.yamamoto on 2015/07/21.
//  Copyright (c) 2015年 hiroki.yamamoto. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let background = SKSpriteNode(imageNamed: "back");
    let ball = SKSpriteNode(imageNamed: "ball");
    let grape = SKSpriteNode(imageNamed: "grape");

    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.size = CGSizeMake(320, 568);
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame);
        self.physicsBody?.restitution = 1.0;
        self.physicsBody?.friction = 0;
        self.physicsBody?.linearDamping = 0;
        background.position = CGPointMake(0, 0);
        background.anchorPoint = CGPointMake(0, 0);
        self.addChild(background);
        makeBall()
        makeGrape();
        self.physicsWorld.contactDelegate = self;
    }
    func makeBall() {
        ball.position = CGPointMake(10, 300);
        ball.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "ball"), size: ball.size);
        ball.physicsBody?.affectedByGravity = false;
        ball.physicsBody?.restitution = 1.0;
        ball.physicsBody?.friction = 0;
        ball.physicsBody?.linearDamping = 0;
        ball.physicsBody?.contactTestBitMask = 1;

        self.addChild(ball);
    }
    
    func makeGrape() {
        grape.position = CGPointMake(120, 300);
        grape.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "grape"), size: grape.size);
        grape.physicsBody?.affectedByGravity = false;
        grape.physicsBody?.dynamic = false;
        grape.physicsBody?.restitution = 1;
        grape.physicsBody?.contactTestBitMask = 1;
        
        self.addChild(grape);
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        if let touch: AnyObject = touches.first {
            ball.physicsBody?.applyImpulse(CGVector(dx: 4, dy:1));
        }
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

extension GameScene:SKPhysicsContactDelegate {
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.node == grape || contact.bodyB.node == grape {
            print("contact grape ! ");
            let particle = SKEmitterNode(fileNamed: "MyParticle")
            particle.position = grape.position;
            let durationAction = SKAction.waitForDuration(1)
            let removeAction = SKAction.removeFromParent();
            let sequenceAction = SKAction.sequence([durationAction, removeAction]);
            particle.runAction(sequenceAction);
            grape.removeFromParent()

            self.addChild(particle);
            
        }
    }
}
