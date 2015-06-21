/**
 The MIT License (MIT)
 
 Copyright (c) 2015 DreamCao
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

#import "DMForwardAnimation.h"


#if DEBUG
#   define DMFALog(...)  NSLog(__VA_ARGS__)
#else
#   define DMFALog(...)
#endif

//动画时间
CGFloat kForwardAnimationInterval = 0.3;


@interface DMForwardAnimation ()

@property (nonatomic, strong) UIImage *m_image;
@property (nonatomic, assign) NSInteger m_count;
@property (nonatomic, assign) NSTimeInterval m_timeInterval;
@property (nonatomic, assign) CGFloat m_scale;
@property (nonatomic, assign) CGFloat m_alpha;
@property (nonatomic, strong) CADisplayLink *m_link;

@end

@implementation DMForwardAnimation

/**
 *  动画
 *
 *  @param superView 父窗口
 *  @param frame     范围
 *  @param image     图片数据
 *
 *  @return object
 */
+ (instancetype)forwardAnimationWithInView:(UIView *)superView frame:(CGRect)frame image:(UIImage *)image timeInterval:(NSTimeInterval)timeInterval
{
    DMForwardAnimation *view = [[DMForwardAnimation alloc] initWithFrame:frame];
    [superView addSubview:view];
    view.m_image = image;
    view.m_timeInterval = timeInterval;

    return view;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.m_scale = 1;
        self.m_alpha = 1;
        self.backgroundColor = [UIColor clearColor];
        
        [self displayLinkCreate];
    }
    
    return self;
}

- (void)displayLinkRemove
{
    [self.m_link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [self.m_link invalidate];
    self.m_link = nil;
}

- (void)displayLinkCreate
{
    self.m_link = [CADisplayLink displayLinkWithTarget:self selector:@selector(timerInterval)];
    [self.m_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)dealloc
{
    DMFALog(@"%@ dealloc", [[self class] description]);
    
    [self displayLinkRemove];
}

- (void)timerInterval
{
    self.m_scale += 0.04;
    self.m_alpha -= 0.04;
    self.m_count++;
    if ((self.m_count * self.m_link.duration) > self.m_timeInterval)
    {
        [self displayLinkRemove];
        
        [super removeFromSuperview];
    }
    else
    {
        [self setNeedsDisplay];
    }
}


- (void)drawRect:(CGRect)rect
{
    CGFloat w = rect.size.width * self.m_scale;
    CGFloat h = rect.size.height * self.m_scale;
    CGFloat x = (rect.size.width - w) / 2;
    CGFloat y = (rect.size.height - h) / 2;
    CGRect frame = {x,y,w,h};

    [self.m_image drawInRect:frame blendMode:kCGBlendModeNormal alpha:self.m_alpha];
}


@end
