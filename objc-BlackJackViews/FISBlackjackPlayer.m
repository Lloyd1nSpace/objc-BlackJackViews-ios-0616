//
//  FISBlackjackPlayer.m
//  BlackJack
//
//  Created by Lloyd W. Sykes on 6/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import "FISBlackjackPlayer.h"

@interface FISBlackjackPlayer ()

@end

@implementation FISBlackjackPlayer

- (instancetype)init {
    
    self = [self initWithName:@""];
    
    return self;
    
}

- (instancetype)initWithName:(NSString *)name  {
    
    self = [super init];
    
    if (self) {
        
        _name = name;
        _cardsInHand = [NSMutableArray new];
        _aceInHand = NO;
        _blackjack = NO;
        _busted = NO;
        _stayed = NO;
        _handscore = 0;
        _wins = 0;
        _losses = 0;
        
    }
    
    return self;
    
}

- (void)resetForNewGame {
    
    [self.cardsInHand removeAllObjects];
    self.handscore = 0;
    self.aceInHand = NO;
    self.stayed = NO;
    self.blackjack = NO;
    self.busted = NO;
    
}

- (void)acceptCard:(FISCard *)card {
    
    [self.cardsInHand addObject:card];
    
    NSString *ace = @"A";
    
    self.handscore += card.cardValue;
    
    if ([card.cardLabel containsString:ace]) {
        
        self.aceInHand = YES;
        
    }
    
    if (self.aceInHand == YES && self.handscore <= 11){
        
        self.handscore += 10;
        
    }
    
    if (self.cardsInHand.count == 2 && self.handscore == 21) {
        
        self.blackjack = YES;
        
    }
    
    if (self.handscore > 21) {
        
        self.busted = YES;
        
    }
    
}

- (BOOL)shouldHit {
    
    if (self.handscore > 17) {
        
        self.stayed = YES;
        return NO;
        
    }
    
    return YES;
    
}

- (NSString *)description {
    
    NSString *gameStats = [NSString stringWithFormat:@"\nname:  %@\ncards: ♠A ♠J\n     handscore  : %lu\n     ace in hand: %d\n     stayed     : %d\n     blackjack  : %d\n     busted     : %d\n     wins  : %lu\nlosses: %lu", self.name, self.handscore, self.aceInHand, self.stayed, self.blackjack, self.busted, self.wins, self.losses];
    
    NSLog(@"\n\n\n\n\n%@\n\n\n\n\n", gameStats);
    
    return gameStats;
    
}

@end
