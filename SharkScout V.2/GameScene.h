//
//  GameScene.h
//  SharkScout V.2
//

//  Copyright (c) 2016 Julien Sloan. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene
@property (nonatomic, copy, readwrite) NSMutableArray* selected;
@property (nonatomic, copy, readwrite) NSMutableArray* notSelected;

@end
