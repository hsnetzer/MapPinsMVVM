//
//  MapViewController.h
//  MapPinsMVVM
//
//  Created by Harry Netzer on 7/14/19.
//  Copyright © 2019 Harry Netzer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MapViewModel;

@interface MapViewController : UIViewController

@property MapViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
