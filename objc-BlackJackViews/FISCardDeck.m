//
//  FISCardDeck.m
//  OOP-Cards-Model
//
//  Created by Lloyd W. Sykes on 6/16/16.
//  Copyright © 2016 Al Tyus. All rights reserved.
//

#import "FISCardDeck.h"
#import "FISCard.h"

@implementation FISCardDeck

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        
        _remainingCards = [NSMutableArray new];
        _dealtCards = [NSMutableArray new];
        
        [self generateDeck];
        
    }
    
    return self;
    
}

- (FISCard *)drawNextCard {
    
    if ([self.remainingCards count] == 0) {
        
        return nil;
        NSLog(@"The deck is empty!");
        
    }
    
    FISCard *nextCard = [self.remainingCards lastObject];
    
    [self.remainingCards removeObject:nextCard];
    [self.dealtCards addObject:nextCard];
    
    return nextCard;
    
}

- (void)resetDeck; {
    
    [self gatherDealtCards];
    [self shuffleRemainingCards];
    
}

- (void)gatherDealtCards {
    
    [self.remainingCards addObjectsFromArray:self.dealtCards];
    [self.dealtCards removeAllObjects];
    
}

- (void)shuffleRemainingCards {
    
    [self gatherDealtCards];
    
    NSUInteger cardCount = [self.remainingCards count];
    
    NSMutableArray *cardsLeft = [self.remainingCards mutableCopy];
    [self.remainingCards removeAllObjects];
    
    for (NSUInteger i = 0; i < cardCount; i++) {
        
        NSUInteger randomizeCard = arc4random_uniform((uint32_t) [cardsLeft count]);
        
        FISCard *randomCards = cardsLeft[randomizeCard];
        
        [self.remainingCards addObject:randomCards];
        [cardsLeft removeObject:randomCards];
        
    }
    
}

- (void)generateDeck {
    
    NSArray *suits = [FISCard validSuits];
    NSArray *ranks = [FISCard validRanks];
    
    for (NSUInteger s = 0; s < [suits count]; s++) {
        for (NSUInteger r = 0; r < [ranks count]; r++) {
            
            FISCard *card = [[FISCard alloc] initWithSuit:suits[s] rank:ranks[r]];
            
            [self.remainingCards addObject:card];
            
            
        }
        
    }
    
    NSLog(@"THESE ARE MY REMAINING CARDS: %@", self.remainingCards);
}

- (NSString *)description {
    
    NSMutableArray *deck = [NSMutableArray new];
    NSMutableString *newDescription = [NSMutableString stringWithFormat:@"\ncount: %lu \ncards:", self.remainingCards.count];
    
    for (FISCard *card in self.remainingCards) {
        
        if ([deck count] % 13 == 0) {
            
            [deck addObject:[NSString stringWithFormat:@"\n%@", card.cardLabel]];
            
        } else {
            
            [deck addObject:card.cardLabel];
            
        }
        
    }
    
    [newDescription appendFormat:@"%@", [deck componentsJoinedByString:@" "]];
    
    NSLog(@"\nCHECK OUT MY DECK!: \n\n\n\n\n\n%@\n\n\n\n\n\n", newDescription);
    
    return newDescription;
    
}

@end
