//
//  GameScene.m
//  SharkScout V.2
//
//  Created by Julien Sloan on 3/3/16.
//  Copyright (c) 2016 Julien Sloan. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

#pragma mark - Variable Declaration

@synthesize selected;
@synthesize notSelected;

SKSpriteNode *A1;
SKSpriteNode *A2;
SKSpriteNode *B1;
SKSpriteNode *B2;
SKSpriteNode *C1;
SKSpriteNode *C2;
SKSpriteNode *D1;
SKSpriteNode *D2;

bool draging = false;

#pragma mark - Important Functions

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */

    A1 = [SKSpriteNode spriteNodeWithImageNamed:@"A cheval de frise"];
    A2 = [SKSpriteNode spriteNodeWithImageNamed:@"A portcullis"];
    B1 = [SKSpriteNode spriteNodeWithImageNamed:@"B moat"];
    B2 = [SKSpriteNode spriteNodeWithImageNamed:@"B ramparts"];
    C1 = [SKSpriteNode spriteNodeWithImageNamed:@"C drawbridge"];
    C2 = [SKSpriteNode spriteNodeWithImageNamed:@"C sally port"];
    D1 = [SKSpriteNode spriteNodeWithImageNamed:@"D rock wall"];
    D2 = [SKSpriteNode spriteNodeWithImageNamed:@"D rough terrain"];
    
    [self setUpNodes];
    
    [self setBackgroundColor:[SKColor colorWithWhite:251/255.0f alpha:1.0]];
    
    //initilize arays
    
    selected = [[NSMutableArray alloc] init];
    notSelected = [[NSMutableArray alloc] init];
    
    [selected addObject:A1];
    [selected addObject:B1];
    [selected addObject:C1];
    [selected addObject:D1];
    
    [notSelected addObject:A2];
    [notSelected addObject:B2];
    [notSelected addObject:C2];
    [notSelected addObject:D2];
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    if (!draging) {
        for (SKSpriteNode *child in self.selected) {
            [child setPosition:CGPointMake([self mapWithOldMin:0 oldMax:[self.selected count]-1 newMin:child.frame.size.width/2 newMax:self.frame.size.width - 199 - (child.frame.size.width/2) oldValue:[self.selected indexOfObject:child]], self.frame.size.height/2)];
        }
        for (SKSpriteNode *child in self.notSelected) {
            [child setPosition:CGPointMake(self.frame.size.width - (child.frame.size.width/2), [self mapWithOldMin:0 oldMax:[self.notSelected count]-1 newMin:(self.frame.size.height/5) newMax:(self.frame.size.height/5)*4 oldValue:[self.notSelected indexOfObject:child]])];
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        for (SKSpriteNode *child in self.children) {
            if (CGRectContainsPoint(child.frame, location)) {
                if ([child.name containsString:@"Defence"]) {
                    draging = true;
                    
                    //add drag tag
                    
                    child.name = [NSString stringWithFormat:@"%@ drag",child.name];
                    child.position = location;
                }
            }
        }
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        //atach draged defence to touch location
        
        for (SKSpriteNode *child in self.children) {
            if ([child.name containsString:@"drag"]) {
                child.position = location;
            }
        }
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    //stop draging
    
    draging = false;
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        for (SKSpriteNode *child in self.children) {
            if ([child.name containsString:@"drag"]) {
                
                child.position = location;
                
                //remove drag tag
                
                child.name = [child.name substringToIndex:[child.name length] - 5];
            }
        }
    }
    
}

#pragma mark - Suporting Functions


-(void)setUpNodes {
    
#warning Hard Coded
    
    SKShapeNode *divider = [SKShapeNode node];
    CGMutablePathRef pathToDraw = CGPathCreateMutable();
    CGPathMoveToPoint(pathToDraw, NULL, self.frame.size.width - 198, 0);
    CGPathAddLineToPoint(pathToDraw, NULL, self.frame.size.width - 198, self.frame.size.height);
    divider.path = pathToDraw;
    divider.glowWidth = 1;
    [divider setStrokeColor:[SKColor blackColor]];
    divider.name = @"divider";
    [self addChild:divider];
    
    //A
    
    A1.xScale = 0.5;
    A1.yScale = 0.5;
    A1.name = @"Defence A 1";
    A1.position = CGPointZero;
    [self addChild:A1];
    
    A2.xScale = 0.5;
    A2.yScale = 0.5;
    A2.name = @"Defence A 2";
    A2.position = CGPointZero;
    [self addChild:A2];
    
    //B
    
    B1.xScale = 0.5;
    B1.yScale = 0.5;
    B1.name = @"Defence B 1";
    B1.position = CGPointZero;
    [self addChild:B1];
    
    B2.xScale = 0.5;
    B2.yScale = 0.5;
    B2.name = @"Defence B 2";
    B2.position = CGPointZero;
    [self addChild:B2];
    
    //C
    
    C1.xScale = 0.5;
    C1.yScale = 0.5;
    C1.name = @"Defence C 1";
    C1.position = CGPointZero;
    [self addChild:C1];
    
    C2.xScale = 0.5;
    C2.yScale = 0.5;
    C2.name = @"Defence C 2";
    C2.position = CGPointZero;
    [self addChild:C2];
    
    //D
    
    D1.xScale = 0.5;
    D1.yScale = 0.5;
    D1.name = @"Defence D 1";
    D1.position = CGPointZero;
    [self addChild:D1];
    
    D2.xScale = 0.5;
    D2.yScale = 0.5;
    D2.name = @"Defence D 2";
    D2.position = CGPointZero;
    [self addChild:D2];
}

-(NSUInteger)mapWithOldMin:(NSUInteger)oldMin oldMax:(NSUInteger)oldMax newMin:(NSUInteger)newMin newMax:(NSUInteger)newMax oldValue:(NSUInteger)oldValue {
    NSUInteger oldRange = (oldMax - oldMin);
    NSUInteger newRange = (newMax - newMin);
    NSUInteger newValue = (((oldValue - oldMin) * newRange) / oldRange) + newMin;
    return newValue;
}

@end
