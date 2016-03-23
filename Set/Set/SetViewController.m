//
//  ViewController.m
//  Set
//
//  Created by mobile on 3/21/16.
//  Copyright (c) 2016 McMaster-Carr. All rights reserved.
//

#import "SetViewController.h"
#import "SetGame.h"
#import "SetDeck.h"
#import "SetCard.h"

@interface SetViewController ()

@property (strong, nonatomic) SetGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation SetViewController

- (SetGame *)game{
    if (!_game) {
        _game = [[SetGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    }
    return _game;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self updateUI];
}


- (IBAction)resetButton:(UIButton *)sender {
    self.game = nil;
    [self updateUI];
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld",(long)self.game.score];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}


- (Deck *)createDeck{
    return [[SetDeck alloc] init];
}

- (void)updateUI{
    for (UIButton *cardButton in self.cardButtons) {
        NSInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle:[self titleForCard:(SetCard *)card] forState:UIControlStateNormal];
    
        if (card.isChosen) {
            [[cardButton layer] setBorderWidth:2.0f];
            [[cardButton layer] setBorderColor:[UIColor blueColor].CGColor];
        } else {
            [[cardButton layer] setBorderWidth:1.0f];
            [[cardButton layer] setBorderColor:[UIColor whiteColor].CGColor];
        }
        
        if (card.isMatched) {
            cardButton.enabled = NO;
        } else {
            cardButton.enabled = YES;
        }

        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld",self.game.score];
    }
}

- (NSMutableAttributedString *)titleForCard:(SetCard *)card{
    
    NSMutableAttributedString *as = [[NSMutableAttributedString alloc] init];
    
    // create a translation for object settings to display settings
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[UIColor blueColor] forKey:[[SetCard validColors] objectAtIndex:0]];
    [dict setObject:[self darkerColorForColor:[UIColor greenColor]] forKey:[[SetCard validColors] objectAtIndex:1]];
    [dict setObject:[UIColor redColor] forKey:[[SetCard validColors] objectAtIndex:2]];
    [dict setObject:@"▲" forKey:[[SetCard validShapes] objectAtIndex:0]];
    [dict setObject:@"●" forKey:[[SetCard validShapes] objectAtIndex:1]];
    [dict setObject:@"■" forKey:[[SetCard validShapes] objectAtIndex:2]];
    [dict setObject:@1 forKey:[[SetCard validNumbers] objectAtIndex:0]];
    [dict setObject:@2 forKey:[[SetCard validNumbers] objectAtIndex:1]];
    [dict setObject:@3 forKey:[[SetCard validNumbers] objectAtIndex:2]];
    UIColor *color = [dict objectForKey:card.color];
    [dict setObject:color forKey:[[SetCard validShading] objectAtIndex:0]];
    [dict setObject:[UIColor whiteColor] forKey:[[SetCard validShading] objectAtIndex:1]];
    [dict setObject:[color colorWithAlphaComponent:0.2] forKey:[[SetCard validShading] objectAtIndex:2]];
    
    
    // now translate
    NSMutableString *title = [[NSMutableString alloc] init];
    // get shape and number of shapes
    NSString *shape = [NSString stringWithFormat:@"%@ ",[dict objectForKey:card.shape]];
    NSNumber *numberOfShapes = [dict objectForKey:card.number];
    for (int i = 0; i < [numberOfShapes integerValue]; i++) {
        [title appendString:shape];
    }
    title = (NSMutableString *)[title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    UIFont *font = [UIFont systemFontOfSize:16];
    if ([card.shape isEqualToString:[[SetCard validShapes] objectAtIndex:1]]) {
        font = [UIFont systemFontOfSize:26];
    }
    
    as = [as initWithString:title
                 attributes:@{NSForegroundColorAttributeName:[dict objectForKey:card.shading],
                              NSStrokeColorAttributeName:[dict objectForKey:card.color],
                              NSStrokeWidthAttributeName:@-5.0,
                              NSFontAttributeName:font}];
    
    return as;
}

- (UIColor *)darkerColorForColor:(UIColor *)c
{
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r - 0.2, 0.0)
                               green:MAX(g - 0.3, 0.0)
                                blue:MAX(b - 0.2, 0.0)
                               alpha:a];
    return nil;
}


@end
