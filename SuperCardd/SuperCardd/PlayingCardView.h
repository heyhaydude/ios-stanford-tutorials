//
//  PlayingCardView.h
//  SuperCardd
//
//  Created by mobile on 3/30/16.
//  Copyright (c) 2016 McMaster-Carr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;

@end
