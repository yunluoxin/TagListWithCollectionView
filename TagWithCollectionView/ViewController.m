//
//  ViewController.m
//  TagWithCollectionView
//
//  Created by ZhangXiaodong on 16/9/13.
//  Copyright © 2016年 ZhangXiaodong. All rights reserved.
//

#import "ViewController.h"
#import "FreeWidthLayout.h"
#import "DDCollectionViewCell.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView ;
@property (nonatomic, strong)NSMutableArray *datas ;
@property (nonatomic, strong)FreeWidthLayout *layout  ;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor] ;
    
    self.layout = [[FreeWidthLayout alloc]init ] ;
    self.layout.datas = self.datas ;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:self.layout] ;
    self.collectionView = collectionView ;
    self.collectionView.delegate = self ;
    self.collectionView.dataSource = self ;
    [self.view insertSubview:collectionView atIndex:0 ] ;
    self.collectionView.backgroundColor = [UIColor greenColor] ;
    self.collectionView.contentInset= UIEdgeInsetsMake(64, 0, 0, 0) ;
    [self.collectionView registerNib:[UINib nibWithNibName:@"DDCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"DDCollectionViewCell"] ;
}
- (IBAction)refresh:(UIBarButtonItem *)sender {
    [self.collectionView reloadData] ;
}

#pragma mark - UICollectionViewDelegate


#pragma mark - UICollectionViewDataSource方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1 ;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datas.count ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DDCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDCollectionViewCell" forIndexPath:indexPath] ;
    cell.textLabel.text = self.datas[indexPath.row] ;
    return cell ;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//     [self.datas removeObjectAtIndex:indexPath.row] ;
//    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]] ;
    
    [self.datas insertObject:@"增加一个亚" atIndex:indexPath.row] ;
    [self.collectionView insertItemsAtIndexPaths:@[indexPath]] ;
}

- (NSMutableArray *)datas
{
    if (!_datas) {
        _datas = [NSMutableArray arrayWithArray:@[
                   @"1111",
                   @"多少级2222发l』",
                   @"333333333",
                   @"23423o4023",
                   @"我去你4444444444444的",
                   @"sjdlj节哀松岛枫建瓯撒打飞机SD林凤娇撩是斗非姐了",
                   @"d",
                   @"ljoljljljljljljljljljl",
                   @"哈哈大拉发记录锁定姐返利l』",
                   @"sadjlfaj",
                   @"多少级了发l』",
                   @"s3o2",
                   @"23423o4023",
                   @"我去你妹的",
                   @"sjdlj节哀松岛枫建瓯撒打飞机SD林凤娇撩是斗非姐了",
                   @"d",
                   @"ljoljljljljljljljljljl",
                   @"哈哈大拉发记录锁定姐返利l』",
                   @"sadjlfaj",
                   @"多少级了发l』",
                   @"s3o2",
                   @"23423o4023",
                   @"我去你妹的",
                   @"sjdlj节哀松岛枫建瓯撒打飞机SD林凤娇撩是斗非姐了",
                   @"d",
                   @"ljoljljljljljljljljljl",
                   @"哈哈大拉发记录锁定姐返利l』",
                   @"sadjlfaj",
                   @"多少级了发l』",
                   @"s3o2",
                   @"23423o4023",
                   @"我去你妹的",
                   @"sjdlj节哀松岛枫建瓯撒打飞机SD林凤娇撩是斗非姐了",
                   @"d",
                   @"ljoljljljljljljljljljl",
                   @"哈哈大拉发记录锁定姐返利l』",
                   @"skcbnkhksdhf",
                   ]
                  ] ;
    }
    return _datas ;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
