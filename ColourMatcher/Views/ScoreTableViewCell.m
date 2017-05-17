//
//  ScoreTableViewCell.m
//  ColourMatcher
//
//  Created by Swati Wadhera on 5/17/17.
//  Copyright © 2017 Swati Wadhera. All rights reserved.
//

#import "ScoreTableViewCell.h"

@implementation ScoreTableViewCell
@synthesize rankLbl, nameLbl, scoreLbl;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.clipsToBounds = NO;
        
        rankLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        [rankLbl setTextColor:[UIColor blackColor]];
        [rankLbl setFont:[UIFont systemFontOfSize:14]];
        [rankLbl setTextAlignment:NSTextAlignmentCenter];
        [rankLbl setBackgroundColor:[UIColor lightGrayColor]];
        [self addSubview:rankLbl];
        
        nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(rankLbl.frame.origin.x + rankLbl.frame.size.width, 0, self.bounds.size.width - rankLbl.bounds.size.width * 2, 40)];
        [nameLbl setTextColor:[UIColor blackColor]];
        [nameLbl setFont:[UIFont systemFontOfSize:14]];
        [nameLbl setTextAlignment:NSTextAlignmentCenter];
        [nameLbl setBackgroundColor:[UIColor yellowColor]];
        [nameLbl setLineBreakMode:NSLineBreakByTruncatingTail];
        [self addSubview:nameLbl];
        
        scoreLbl = [[UILabel alloc] initWithFrame:CGRectMake(nameLbl.frame.origin.x + nameLbl.frame.size.width, 0, rankLbl.bounds.size.width, 40)];
        [scoreLbl setTextColor:[UIColor blackColor]];
        [scoreLbl setBackgroundColor:[UIColor lightGrayColor]];
        [scoreLbl setFont:[UIFont systemFontOfSize:14]];
        [scoreLbl setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:scoreLbl];

    }
    
    return self;
}

- (void)layoutSubviews {
    [rankLbl setFrame:CGRectMake(0, 0, 60, 40)];
    [nameLbl setFrame:CGRectMake(rankLbl.frame.origin.x + rankLbl.frame.size.width, 0, self.bounds.size.width - rankLbl.bounds.size.width*2, 40)];
    [scoreLbl setFrame:CGRectMake(nameLbl.frame.origin.x + nameLbl.frame.size.width, 0, rankLbl.bounds.size.width, 40)];

}

@end
