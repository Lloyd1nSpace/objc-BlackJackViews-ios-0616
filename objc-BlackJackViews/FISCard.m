//
//  FISCard.m
//  OOP-Cards-Model
//
//  Created by Lloyd W. Sykes on 6/16/16.
//  Copyright © 2016 Al Tyus. All rights reserved.
//

#import "FISCard.h"

@interface FISCard ()

@property (strong, nonatomic, readwrite) NSString *suit;
@property (strong, nonatomic, readwrite) NSString *rank;
@property (strong, nonatomic, readwrite) NSString *cardLabel;
@property (nonatomic, readwrite) NSUInteger cardValue;

@end

@implementation FISCard

- (instancetype)init {
    
    self = [self initWithSuit:@"!" rank:@"N"];
    
    return self;
    
}

- (instancetype)initWithSuit:(NSString *)suit
                        rank:(NSString *)rank {
    
    self = [super init];
    
    if (self) {
        
        _suit = suit;
        _rank = rank;
        _cardLabel = [self cardLabelForSuitAndRank];
        _cardValue = [self cardValueForRank];
        
    }

    
    return self;
    
}

+ (NSArray *)validSuits {
    
    NSArray *cardSuits = @[@"♠", @"♥", @"♣", @"♦"];
    return cardSuits;
    
}

+ (NSArray *)validRanks {
    
    NSArray *ranks = @[@"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
    return ranks;
    
}

- (NSString *)description {
    
    return self.cardLabel;
    
}

- (NSString *)cardLabelForSuitAndRank {

    
    return [NSString stringWithFormat:@"%@%@", self.suit, self.rank];

    
}

- (NSUInteger)cardValueForRank {
    
    NSArray *validRanks = [FISCard validRanks];
    
    NSUInteger index = [validRanks indexOfObject:self.rank];
    
    NSUInteger cardValue = 0;
    
    if (index <= 9) {
        
        cardValue = index + 1;
        
    } else {
        
        cardValue = 10;
        
    }
    
    return cardValue;
}

@end
