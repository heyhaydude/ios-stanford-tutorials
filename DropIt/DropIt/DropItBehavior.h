//
//  DropItBehavior.h
//  DropIt
//
//  Created by mobile on 4/1/16.
//  Copyright (c) 2016 McMaster-Carr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropItBehavior : UIDynamicBehavior

- (void)addItem:(id <UIDynamicItem>)item;
- (void)removeItem:(id <UIDynamicItem>)item;

@end
