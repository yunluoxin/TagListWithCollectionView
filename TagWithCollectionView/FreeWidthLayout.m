//
//  FreeWidthLayout.m
//  TagWithCollectionView
//
//  Created by ZhangXiaodong on 16/9/13.
//  Copyright © 2016年 ZhangXiaodong. All rights reserved.
//

#import "FreeWidthLayout.h"

@interface FreeWidthLayout()

@property (nonatomic, assign) CGFloat instrinsicHeight ;
/**
    缓存的属性对象数组
 */
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *cacheAttributesArray ;
@end

@implementation FreeWidthLayout

- (void)prepareLayout
{
    self.cacheAttributesArray = [NSMutableArray arrayWithCapacity:10] ;
    [super prepareLayout] ;
    NSLog(@"%s",__func__) ;
    self.instrinsicHeight = 44 ;
    self.minimumInteritemSpacing = 8.0f ;
    self.minimumLineSpacing = 18.0f ;
    self.sectionInset = UIEdgeInsetsMake(0, 8, 0, 8) ;
    self.scrollDirection = UICollectionViewScrollDirectionVertical ;
    
    if (self.cacheAttributesArray.count == 0) {
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width - self.sectionInset.left - self.sectionInset.right ;
        CGFloat totalX = self.sectionInset.left ;
        CGFloat totalY = self.sectionInset.top ;
        BOOL first = YES ;
        for (int i = 0 ; i < self.datas.count;  i ++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0] ;
            UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexPath] ;
            CGFloat width = [self widthForCellAtIndexPath:indexPath] ;
            CGRect frame ;
            if (first == YES) {
                frame = CGRectMake(totalX, totalY, width, self.instrinsicHeight) ;
                totalX = totalX + width ;
                first = NO ;
            }else if (totalX + width + self.minimumInteritemSpacing <= maxWidth) {
                //不换行
                frame = CGRectMake(totalX + self.minimumInteritemSpacing, totalY, width, self.instrinsicHeight) ;
                totalX = totalX + width + self.minimumInteritemSpacing ;
            }else{
                //换行
                totalX = self.sectionInset.left ;
                totalY = totalY + self.instrinsicHeight + self.minimumLineSpacing ;
                frame = CGRectMake(totalX, totalY, width, self.instrinsicHeight) ;
                totalX = totalX + width + self.minimumInteritemSpacing ;
            }
            attr.frame = frame ;
            [self.cacheAttributesArray addObject:attr] ;
        }
    }
}

- (CGSize)collectionViewContentSize
{
    CGFloat h = CGRectGetMaxY([self.cacheAttributesArray lastObject].frame) + self.sectionInset.bottom;
    return  CGSizeMake(self.collectionView.bounds.size.width, h) ;
}

//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath ] ;
//    CGFloat w = [self widthForCellAtIndexPath:indexPath] ;
//    attributes.size = CGSizeMake(w, self.instrinsicHeight) ;
////    NSLog(@"%@",attributes) ;
//    return attributes ;
//}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *arrayM = [NSMutableArray array] ;
    for (int i = 0 ; i < self.cacheAttributesArray.count; i ++) {
        UICollectionViewLayoutAttributes *attr = self.cacheAttributesArray[i];
        if (CGRectIntersectsRect(attr.frame, rect )) {
            [arrayM addObject:attr] ;
        }
    }
    return arrayM ;
}

- (CGFloat)widthForCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = self.datas[indexPath.row] ;
    CGFloat width = [UIScreen mainScreen].bounds.size.width - self.sectionInset.left - self.sectionInset.right ;
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, self.instrinsicHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil] ;
//    NSLog(@"%@",NSStringFromCGRect(rect)) ;
    return CGRectGetWidth(rect) + 21 ;
}

@end
