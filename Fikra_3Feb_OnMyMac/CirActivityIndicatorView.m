
#import "CirActivityIndicatorView.h"

#import "Circle.h"

#import <QuartzCore/QuartzCore.h>

@implementation CirActivityIndicatorView

@synthesize color;


- (void)commonInit
{
    isAnimating = NO;
    maxCircleNumber = 4;
}

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame andColor:[UIColor yellowColor]];
}

- (id)initWithFrame:(CGRect)frame andColor:(UIColor*)theColor
{
    self = [super initWithFrame:frame];

    if (self)
    {
        color = theColor;
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    if (isAnimating){
        //[
    }
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:CGRectMake(0, 50, 320, 60)];
    [self setBackgroundColor:[UIColor clearColor]];
    
    if (isAnimating)
    {
        [self stopAnimating];
        [self startAnimating];
    }
}

-(void)startAnimating{
    
    if (!isAnimating){
        
        isAnimating = YES;
        
        circleNumber = 0;
        
        radius = self.frame.size.width/2;
        
        if (self.frame.size.width > self.frame.size.height){
            radius = self.frame.size.height/2;
        }
        
        circleSize = 15*radius/55;
        
        //add circles
        
        circleDelay = [NSTimer scheduledTimerWithTimeInterval: 0.20 target: self
                                                     selector: @selector(nextCircle) userInfo: nil repeats: YES];
        
    }
}

-(void)nextCircle{
    
    
    if (circleNumber<maxCircleNumber){
        
        circleNumber ++;
        
        Circle *circle = [[Circle alloc] initWithFrame:CGRectMake((self.frame.size.width-circleSize)/2 - 1, self.frame.size.height-circleSize -1, circleSize +2, circleSize+2)];
        
        circle.color = color;
        circle.backgroundColor = [UIColor clearColor];
        [self addSubview:circle];
        
        CGMutablePathRef circlePath = CGPathCreateMutable();
        CGPathMoveToPoint(circlePath, NULL, 0, 0);
        
        CGPathAddLineToPoint(circlePath, &CGAffineTransformIdentity, 350.0f, 0.0f);
        
        CAKeyframeAnimation *circleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        circleAnimation.duration = 1.5;
        circleAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.15f :0.60f :0.85f :0.4f];
        [circleAnimation setCalculationMode:kCAAnimationPaced];
        circleAnimation.path = circlePath;
        circleAnimation.repeatCount = HUGE_VALF;
        [circle.layer addAnimation:circleAnimation forKey:@"circleAnimation"];
        
        CGPathRelease(circlePath);
        
    } else {
        [circleDelay invalidate];
    }
    
    
    
}


-(void)stopAnimating{
    
    [self.layer removeAllAnimations];
    [circleDelay invalidate];
    for (UIView *v in self.subviews){
        [v removeFromSuperview];
    }
    isAnimating = NO;
}

-(BOOL)isAnimating{
    return isAnimating;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
