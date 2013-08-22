//
//  GameResult.h
//  Matchismo
//
//  Created by Teddy Wyly on 8/14/13.
//  Copyright (c) 2013 Teddy Wyly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (readonly, nonatomic) NSTimeInterval duration;
@property (readonly, nonatomic) NSString *gameName;
@property (nonatomic) int score;

+ (NSArray *)allGameResults;

+ (void)deleteGameResults;

- (id)initWithGameName:(NSString *)name;

- (NSComparisonResult)compareScoreToGameResult:(GameResult *)otherResult;
- (NSComparisonResult)compareEndDateToGameResult:(GameResult *)otherResult;
- (NSComparisonResult)compareDurationToGameResult:(GameResult *)otherResult;

@end
