//
//  LIPTutorialViewController.h
//  Loakan
//
//  Created by Laura Iglesias Piña on 2/3/15.
//  Copyright (c) 2015 lip. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LIPTutorialViewController : UIViewController
<UIScrollViewDelegate>{
    
    BOOL pageControl_isChangePage;
}

@property (weak, nonatomic) IBOutlet UIScrollView *tutorialScrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *tutorialPageControl;

- (IBAction)changePage:(id)sender;
- (IBAction)btnExitTutorial:(id)sender;

@end
