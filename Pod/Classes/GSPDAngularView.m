#import "GSPDAngularView.h"

@implementation GSPDAngularView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.anglularPartWidth = 10.0f;
        self.customBackgroundColor = [UIColor greenColor];
        [super setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (instancetype)initWithAngularPartWidth:(CGFloat)angularPartWidth style:(GSPDAngularViewStyle)style backgroundColor:(UIColor *)backgroundColor {
    self = [super init];
    if (self) {
        self.anglularPartWidth = angularPartWidth;
        self.style = style;
        self.customBackgroundColor = backgroundColor;
        [super setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (instancetype)initWithStyle:(GSPDAngularViewStyle)style {
    return [self initWithAngularPartWidth:10.0f style:style backgroundColor:[UIColor greenColor]];
}

- (void)drawRect:(CGRect)rect {
    CGPoint leftPoint = CGPointMake(rect.origin.x, CGRectGetMidY(rect));
    CGPoint leftTopPoint = CGPointMake(_anglularPartWidth, rect.origin.y);
    CGPoint leftBottomPoint = CGPointMake(_anglularPartWidth, rect.size.height);
    CGPoint rightPoint = CGPointMake(rect.size.width, CGRectGetMidY(rect));
    CGPoint rightTopPoint = CGPointMake(rect.size.width - _anglularPartWidth, rect.origin.y);
    CGPoint rightBottomPoint = CGPointMake(rect.size.width - _anglularPartWidth, rect.size.height);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    switch (self.style) {
        case GSPDAngularViewStyleDefault: {
            CGContextAddRect(context, rect);
        }
            break;
        case GSPDAngularViewStyleLeftSided: {
            CGRect leftSidedStyledRect = CGRectMake(leftTopPoint.x, rect.origin.y, rect.size.width - (leftTopPoint.x - rect.origin.x), rect.size.height);
            CGContextAddRect(context, leftSidedStyledRect);
            CGContextMoveToPoint(context, leftTopPoint.x, leftTopPoint.y);
            CGContextAddLineToPoint(context, leftPoint.x, leftPoint.y);
            CGContextAddLineToPoint(context, leftBottomPoint.x, leftBottomPoint.y);
        }
            break;
        case GSPDAngularViewStyleRightSided: {
            CGRect rightSidedStyledRect = CGRectMake(rect.origin.x, rect.origin.y, rightTopPoint.x - rect.origin.x, rect.size.height);
            CGContextAddRect(context, rightSidedStyledRect);
            CGContextMoveToPoint(context, rightBottomPoint.x, rightBottomPoint.y);
            CGContextAddLineToPoint(context, rightPoint.x, rightPoint.y);
            CGContextAddLineToPoint(context, rightTopPoint.x, rightTopPoint.y);
        }
            break;
        case GSPDAngularViewStyleTwoSided: {
            CGRect twoSidedStyledRect = CGRectMake(leftTopPoint.x, rect.origin.y, rightTopPoint.x - leftTopPoint.x, rect.size.height);
            CGContextAddRect(context, twoSidedStyledRect);
            CGContextMoveToPoint(context, rightBottomPoint.x, rightBottomPoint.y);
            CGContextAddLineToPoint(context, rightPoint.x, rightPoint.y);
            CGContextAddLineToPoint(context, rightTopPoint.x, rightTopPoint.y);
            CGContextMoveToPoint(context, leftTopPoint.x, leftTopPoint.y);
            CGContextAddLineToPoint(context, leftPoint.x, leftPoint.y);
            CGContextAddLineToPoint(context, leftBottomPoint.x, leftBottomPoint.y);
        }
            break;
        default:
            break;
    }
    
    CGContextSetFillColorWithColor(context, self.customBackgroundColor.CGColor);
    CGContextFillPath(context);
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    self.customBackgroundColor = backgroundColor;
}

- (void)setCustomBackgroundColor:(UIColor *)customBackgroundColor {
    _customBackgroundColor = customBackgroundColor;
    [self setNeedsDisplay];
}

- (void)setAnglularPartWidth:(CGFloat)anglularPartWidth {
    _anglularPartWidth = anglularPartWidth;
    [self setNeedsDisplay];
}

- (void)setStyle:(GSPDAngularViewStyle)style {
    _style = style;
    [self setNeedsDisplay];
}

@end
