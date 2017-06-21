//
//  ResultViewController.h
//  SearchControllerTest
//
//  Created by Yubin on 2017/6/21.
//  Copyright © 2017年 X. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ResultViewControllerDelegate <NSObject>

@required

- (void)resultViewController:(UIViewController *)vc didSelectRow:(NSIndexPath *)indexPath;

@end

@interface ResultViewController : UIViewController

@property(nonatomic, weak) id<ResultViewControllerDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet UITableView *resultTalbeView;

@end
