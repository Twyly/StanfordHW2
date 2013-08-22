//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Teddy Wyly on 8/8/13.
//  Copyright (c) 2013 Teddy Wyly. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (id)init
{

    self = [super init];
    if (self) {
        for (NSString *color in [SetCard validColors]) {
            for (NSString *shade in [SetCard validShadings]) {
                for (NSString *symbol in [SetCard validSymbols]) {
                    for (NSUInteger number = 1; number <= [SetCard maximumNumber]; number++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.color = color;
                        card.shading = shade;
                        card.symbol = symbol;
                        card.number = number;
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
        
    }
    
    return self;
    
}

@end
