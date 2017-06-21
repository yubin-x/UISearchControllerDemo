//
//  ResultViewController.h
//  SearchControllerTest
//
//  Created by Yubin on 2017/6/21.
//  Copyright © 2017年 X. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Delegate <NSObject>

- (void)didselect;

@end

@interface ResultViewController : UIViewController
@property(nonatomic) id<Delegate> delegate;
@end
