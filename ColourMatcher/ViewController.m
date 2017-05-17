//
//  ViewController.m
//  ColourMatcher
//
//  Created by Swati Wadhera on 5/12/17.
//  Copyright © 2017 Swati Wadhera. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    self.navigationItem.title = @"Main";
    [self.navigationController setNavigationBarHidden:YES];
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(5, 20, 100, 20)];
    [logo setImage:[UIImage imageNamed:@"logo"]];
    [self.view addSubview:logo];
    
    scoreLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 20)];
    [scoreLbl setTextColor:[UIColor blackColor]];
    [scoreLbl setTextAlignment:NSTextAlignmentCenter];
    [scoreLbl setFont:[UIFont boldSystemFontOfSize:14]];
    [self.view addSubview:scoreLbl];
    
    UIButton *highScoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [highScoreBtn setTitle:@"High Score" forState:UIControlStateNormal];
    [highScoreBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [highScoreBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [highScoreBtn addTarget:self action:@selector(highScoreBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [highScoreBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [highScoreBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [highScoreBtn sizeToFit];
     [highScoreBtn setFrame:CGRectMake(self.view.bounds.size.width - highScoreBtn.bounds.size.width - 10, 20, highScoreBtn.bounds.size.width, 20)];
    [self.view addSubview:highScoreBtn];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.matrix = [[UICollectionView alloc] initWithFrame:CGRectMake(5, scoreLbl.frame.origin.y + scoreLbl.frame.size.height + 5, self.view.bounds.size.width - 10, self.view.bounds.size.height - 20) collectionViewLayout:layout];
    self.matrix.backgroundColor = [UIColor clearColor];
    self.matrix.clipsToBounds = YES;
    self.matrix.delegate = self;
    self.matrix.dataSource = self;
    [self.matrix registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"matrixCell"];
    [self.view addSubview:self.matrix];
    
    [self updateScore];
    
    cards = [NSMutableArray array];
    for(int i = 1; i <= 8; i++){
        [cards addObject:[NSString stringWithFormat:@"colour%d",i]];
    }
    
    [cards addObjectsFromArray:cards];
    cards = [self shuffleElements:cards];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSMutableArray *)shuffleElements:(NSMutableArray *)items {
    
    for (int x = 0; x < [items count]; x++) {
        int randInt = (arc4random() % ([items count] - x)) + x;
        [items exchangeObjectAtIndex:x withObjectAtIndex:randInt];
    }
    
    return items;
}

#pragma mark - UICollectionView Data Source & Delegate -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)sectio
{
    return 16;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"matrixCell" forIndexPath:indexPath];
    
    winCards = 0;
    cell.backgroundColor = [UIColor blackColor];
    
    for(UIView *subview in cell.subviews)
        [subview removeFromSuperview];
   
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:cards[indexPath.row]]];
    [imgV setFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height)];
    [imgV setTag:343];
    [cell addSubview:imgV];
    
    [imgV setHidden:YES];
    cell.userInteractionEnabled = YES;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    UIImageView * imgView = (UIImageView *)[cell viewWithTag:343];
    [imgView setImage:nil];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    UIImageView *imgV = (UIImageView *)[cell viewWithTag:343];
   
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void) {
                         cell.transform = CGAffineTransformMakeScale(-1, 1);
                        }
                     completion:^(BOOL success){
                         [imgV setHidden:NO];
                         [cell setUserInteractionEnabled:NO];
                     }];
    
    if(!lastCard){
        lastCard = cards[indexPath.row];
    }
    else
    {
        if([cards[indexPath.row] isEqualToString:lastCard])
        {
            score = score + 2;
            winCards = winCards + 1;
            if(winCards == 8)
            {
                [[DBManager sharedManager] saveScore:score withName:@"Swati"];
                [self performSelector:@selector(showSuccessAlert) withObject:nil afterDelay:1];
            }
        }
        else
        {
            score = score - 1;
            [collectionView performSelector:@selector(reloadData) withObject:nil afterDelay:1];
        }
        lastCard = nil;
    }
    
    [self updateScore];
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((collectionView.bounds.size.width - 15)/4, (collectionView.bounds.size.height - 50)/4);
    
}

#pragma mark - UIAlertViewDelegate Method -
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
}

#pragma mark - Helper Methods -

- (void)highScoreBtnClicked {
    HighScoreViewController *highScoreObj = [[HighScoreViewController alloc] init];
    [self.navigationController presentViewController:highScoreObj animated:YES completion:nil];
}

- (void)updateScore {
    [scoreLbl setText:[NSString stringWithFormat:@"SCORE : %d", score]];
}

- (void)showSuccessAlert {
    UIView *sizeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 50, 0)];
    sizeView.layer.borderColor = [UIColor purpleColor].CGColor;
    sizeView.layer.borderWidth = 5;
    sizeView.clipsToBounds = NO;
    
    UILabel *winLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, sizeView.bounds.size.width, 30)];
    [winLbl setTextColor:[UIColor redColor]];
    [winLbl setFont:[UIFont systemFontOfSize:15]];
    [winLbl setNumberOfLines:0];
    [winLbl setText:@"WOHOOO !!! YOU WIN\n\nPlease enter your name for score card"];
    [winLbl setTextAlignment:NSTextAlignmentCenter];
    [sizeView addSubview:winLbl];
    
    UITextField *nameTF = [[UITextField alloc] initWithFrame:CGRectMake(10, winLbl.frame.origin.x + winLbl.frame.size.height + 20, sizeView.bounds.size.width - 100, 30)];
    [nameTF setPlaceholder:@"Your Name"];
    [nameTF setFont:[UIFont systemFontOfSize:14]];
    [nameTF setTextColor:[UIColor blueColor]];
    [nameTF setTextAlignment:NSTextAlignmentLeft];
    [nameTF setAutocorrectionType:UITextAutocorrectionTypeNo];
    [nameTF setCenter:CGPointMake(sizeView.center.x, nameTF.center.y)];
    [nameTF.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [nameTF.layer setBorderWidth:1];
    nameTF.clipsToBounds = NO;
    [nameTF setTag:2];
    [sizeView addSubview:nameTF];
    
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setFrame:CGRectMake(10, nameTF.frame.origin.y + nameTF.frame.size.height + 10, 100, 25)];
    [doneBtn setTitle:@"DONE" forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(popupDoneBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    doneBtn.layer.cornerRadius = 5;
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneBtn setBackgroundColor:[UIColor blackColor]];
    [doneBtn setCenter:CGPointMake(sizeView.center.x, doneBtn.center.y)];
    [sizeView addSubview:doneBtn];
    
    [sizeView setFrame:CGRectMake(sizeView.frame.origin.x, sizeView.frame.origin.y, sizeView.frame.size.width, doneBtn.frame.origin.y + doneBtn.frame.size.height + 20)];
    
    popupController = [[CNPPopupController alloc] initWithContents:@[sizeView]];
    popupController.theme = [CNPPopupTheme defaultTheme];
    popupController.theme.shouldDismissOnBackgroundTouch = NO;
    popupController.theme.popupStyle = CNPPopupStyleCentered;
    popupController.theme.maxPopupWidth = sizeView.bounds.size.width;
    popupController.theme.popupContentInsets = UIEdgeInsetsZero;
    [popupController presentPopupControllerAnimated:YES];

}

- (void)popupDoneBtnClicked: (id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSString *name = ((UITextField *)[btn.superview viewWithTag:2]).text;
    if([self validateName:name]) {
        [popupController dismissPopupControllerAnimated:YES];
        [[DBManager sharedManager] saveScore:score withName:name];
        [self highScoreBtnClicked];
        [self resetBoard];
    }
    else {
        [[[UIAlertView alloc] initWithTitle:@"Oops" message:@"Enter a name properly" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
}

- (BOOL)validateName:(NSString *)name {
    NSString *regex = @"[a-zA-Z][a-zA-Z ]*";
    NSPredicate *TestResult = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [TestResult evaluateWithObject:name];
}

- (void)resetBoard {
    [self.matrix reloadData];
    score = 0;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
