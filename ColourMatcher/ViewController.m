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
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.matrix = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 10 , self.view.bounds.size.width - 10, self.view.bounds.size.height - 20) collectionViewLayout:layout];
    self.matrix.backgroundColor = [UIColor blackColor];
    self.matrix.clipsToBounds = YES;
    self.matrix.delegate = self;
    self.matrix.dataSource = self;
    [self.matrix setCenter:self.view.center];
    [self.matrix registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"matrixCell"];
    [self.view addSubview:self.matrix];
    
    winCards = [NSMutableArray array];
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

#pragma mark UICollectionView Data Source & Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)sectio
{
    return 16;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"matrixCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor purpleColor];
    
    for(UIView *subview in cell.subviews)
        [subview removeFromSuperview];
    //UIImageView *imgV = (UIImageView *)[cell viewWithTag:343];
    //{
        UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:cards[indexPath.row]]];
        [imgV setFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height)];
        [imgV setTag:343];
        [cell addSubview:imgV];
    //}
    
    [imgV setHidden:YES];
    cell.userInteractionEnabled = YES;
    
//    if([winCards containsObject:cards[indexPath.row]])
//    {
//        cell.userInteractionEnabled = NO;
//        [imgV setHidden:NO];
//    }
//    else
//    {
//        cell.userInteractionEnabled = YES;
//        [imgV setHidden:YES];
//    }
    
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
                         [imgV setUserInteractionEnabled:NO];
                         if(!lastCard){
                             lastCard = cards[indexPath.row];
                         }
                         else
                         {
                             if([cards[indexPath.row] isEqualToString:lastCard])
                             {
                                 [winCards addObject:lastCard];
                             }
                             else
                             {
                                 [collectionView performSelector:@selector(reloadData) withObject:nil afterDelay:1];
                             }
                             lastCard = nil;
                             
                         }

                     }];
    
    
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((collectionView.bounds.size.width - 15)/4, (collectionView.bounds.size.height - 50)/4);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
