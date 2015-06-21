//
//  ViewController.m
//  DMForwardAnimationDemo
//
//  Created by Dream on 15/6/21.
//  Copyright (c) 2015年 GoSing. All rights reserved.
//

#import "ViewController.h"
#import "DMForwardAnimation.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    [DMForwardAnimation forwardAnimationWithInView:self.view frame:self.view.bounds image:self.m_imageView.image timeInterval:kForwardAnimationInterval];
}

@end
