//
//  SetCard.m
//  Matchismo
//
//  Created by Teddy Wyly on 8/8/13.
//  Copyright (c) 2013 Teddy Wyly. All rights reserved.
//

#import "SetCard.h"

#define COLOR_SET_KEY @"color key";
#define SHADE_SET_KEY @"shade key";
#define NUMBER_SET_KEY @"number key";
#define SYMBOL_SET_KEY @"symbol key";

@implementation SetCard

+ (NSUInteger)maximumNumber
{
    return 3;
}

+ (NSArray *)validSymbols
{
    return @[@"diamond", @"squiggle", @"oval"];
}

+ (NSArray *)validShadings
{
    return @[@"solid", @"striped", @"open"];
}

+ (NSArray *)validColors
{
    return @[@"red", @"green", @"purple"];
}

- (NSString *)contents
{
    return [NSString stringWithFormat:@"%i %@ %@ %@", self.number, self.color, self.shading, self.symbol];
}


- (void)setNumber:(NSUInteger)number
{
    if (number <= [[self class] maximumNumber]) {
        _number = number;
    }
}

- (void)setSymbol:(NSString *)symbol
{
    if ([[[self class] validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (void)setShading:(NSString *)shading
{
    if ([[[self class] validShadings] containsObject:shading]) {
        _shading = shading;
    }
}

- (void)setColor:(NSString *)color
{
    if ([[[self class] validColors] containsObject:color]) {
        _color = color;
    }
}



- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    BOOL numberMatch = NO;
    BOOL colorMatch = NO;
    BOOL shadingMatch = NO;
    BOOL symbolMatch = NO;
    
    // set logic
    
    if ([otherCards count] == 2) {
        SetCard *firstCard = otherCards[0];
        SetCard *secondCard = otherCards[1];

        
        if (self.number == firstCard.number && self.number == secondCard.number && firstCard.number == secondCard.number) numberMatch = YES;
        if ([self.color isEqualToString:firstCard.color] && [self.color isEqualToString:secondCard.color]) colorMatch = YES;
        if ([self.shading isEqualToString:firstCard.shading] && [self.shading isEqualToString:secondCard.shading]) shadingMatch = YES;
        if ([self.symbol isEqualToString:firstCard.symbol] && [self.symbol isEqualToString:secondCard.symbol]) symbolMatch = YES;
        
        
        if (self.number != firstCard.number && firstCard.number != secondCard.number && self.number != secondCard.number) numberMatch = YES;
        if (![self.color isEqualToString:firstCard.color] && ![firstCard.color isEqualToString:secondCard.color] && ![self.color isEqualToString:secondCard.color]) colorMatch = YES;
        if (![self.shading isEqualToString:firstCard.shading] && ![firstCard.shading isEqualToString:secondCard.shading] && ![self.shading isEqualToString:secondCard.shading]) shadingMatch = YES;
        if (![self.symbol isEqualToString:firstCard.symbol] && ![firstCard.symbol isEqualToString:secondCard.symbol] && ![self.symbol isEqualToString:secondCard.symbol]) symbolMatch = YES;
        
        if (numberMatch && colorMatch && shadingMatch && symbolMatch) score = 10;
        
        
    }
    
    return score;
}

@end
