//
//  BaseDemoViewController.m
//  UICollectionViewDemo
//
//  Created by 讯心科技 on 2017/9/5.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import "BaseDemoViewController.h"
#import "CollectionHeaderView.h"
#import "StoryboardCell.h"
#import "CodeCell.h"
#import "XibCell.h"


@interface BaseDemoViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    CGFloat _itemWidth;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end


@implementation BaseDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _itemWidth = ([UIScreen mainScreen].bounds.size.width-80.0)/3.0;
    
#warning - 当itemSize，sectionInset，minimumLineSpacing，minimumInteritemSpacing，headerReferenceSize，footerReferenceSize的大小固定时，直接给布局对象对应属性赋值就可。这样做会比通过调用UICollectionViewDelegateFlowLayout委托方法返回的程序执行效率要高。(但这里我还是在委托方法中返回)
//    self.flowLayout.itemSize     = CGSizeMake(_itemWidth, _itemWidth);
//    self.flowLayout.sectionInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
//    self.flowLayout.minimumLineSpacing      = 10.0;
//    self.flowLayout.minimumInteritemSpacing = 10.0;
//    self.flowLayout.headerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 40.0);
//    self.flowLayout.footerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 40.0);
    
    
    
    // 纯代码布局时，注册cell和Supplementary View
    [self.collectionView registerClass:[CodeCell class] forCellWithReuseIdentifier:@"CodeCell"];
    
    [self.collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderB"];
    
    [self.collectionView registerClass:[CollectionFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterB"];
    
    // Xib布局时，注册cell和Supplementary View
    [self.collectionView registerNib:[UINib nibWithNibName:@"XibCell" bundle:nil] forCellWithReuseIdentifier:@"XibCell"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CustomHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderC"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CustomFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterC"];
}


#pragma mark- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
        {
            StoryboardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StoryboardCell" forIndexPath:indexPath];
            
            cell.footLabel.text = [NSString stringWithFormat:@"(%ld,%ld)",indexPath.row,indexPath.section];
            
            return cell;
        }
            break;
        case 1:
        {
            CodeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CodeCell" forIndexPath:indexPath];
            
            cell.headLabel.text = [NSString stringWithFormat:@"(%ld,%ld)",indexPath.row,indexPath.section];
            
            return cell;
        }
            break;
        case 2:
        {
            XibCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XibCell" forIndexPath:indexPath];
            
            cell.textLabel.text = [NSString stringWithFormat:@"(%ld,%ld)",indexPath.row,indexPath.section];
            
            return cell;
        }
            break;
        default:
            return nil;
            break;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        switch (indexPath.section)
        {
            case 0:
            {
                UICollectionReusableView *supplementaryView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderA" forIndexPath:indexPath];
                return supplementaryView;
            }
                break;
            case 1:
            {
                CollectionHeaderView *supplementaryView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderB" forIndexPath:indexPath];
                return supplementaryView;
            }
                break;
            case 2:
            {
                UICollectionReusableView *supplementaryView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderC" forIndexPath:indexPath];
                return supplementaryView;
            }
                break;
            default:
                return nil;
                break;
        }
    }else
    {
        switch (indexPath.section)
        {
            case 0:
            {
                UICollectionReusableView *supplementaryView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FooterA" forIndexPath:indexPath];
                
                return supplementaryView;
            }
                break;
            case 1:
            {
                CollectionFooterView *supplementaryView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FooterB" forIndexPath:indexPath];
                
                return supplementaryView;
            }
                break;
            case 2:
            {
                UICollectionReusableView *supplementaryView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FooterC" forIndexPath:indexPath];
                
                return supplementaryView;
            }
                break;
            default:
                return nil;
                break;
        }
    }
}

#pragma mark- UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor lightGrayColor];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0:
            cell.contentView.backgroundColor = [UIColor greenColor];
            break;
        case 1:
            cell.contentView.backgroundColor = [UIColor redColor];
            break;
        case 2:
            cell.contentView.backgroundColor = [UIColor yellowColor];
            break;
        default:
            break;
    }
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// called when the user taps on an already-selected item in multi-select mode
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选中%ld-%ld",indexPath.row,indexPath.section);
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"取消选中%ld-%ld",indexPath.row,indexPath.section);
}


#pragma mark- UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(_itemWidth, _itemWidth);
}

// 行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0;
}

// 列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 20.0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.frame.size.width, 40.0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.frame.size.width, 40.0);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
