#import "GSPDBalloonView.h"

@interface GSPDBalloonView ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation GSPDBalloonView {
    CGFloat margin;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        margin = 4.0f;
        _arrowHeight = 5.0f;
        _arrowIndent = -1.0f;
        _cornerRadius = 5.0f;
        _arrowEnabled = YES;
        _balloonBackgroundColor = [UIColor colorWithRed:0.45 green:0.57 blue:0.89 alpha:1];
        [super setBackgroundColor:[UIColor clearColor]];
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectNull];
        self.textField.userInteractionEnabled = NO;
        self.textField.textAlignment = NSTextAlignmentCenter;
        self.textField.userInteractionEnabled = NO;
        [self addSubview:self.textField];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        margin = 4.0f;
        _arrowHeight = 5.0f;
        _arrowIndent = -1.0f;
        _cornerRadius = 5.0f;
        _arrowEnabled = YES;
        _balloonBackgroundColor = [UIColor colorWithRed:0.45 green:0.57 blue:0.89 alpha:1];
        [super setBackgroundColor:[UIColor clearColor]];
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectNull];
        self.textField.userInteractionEnabled = NO;
        self.textField.textAlignment = NSTextAlignmentCenter;
        self.textField.userInteractionEnabled = NO;
        [self addSubview:self.textField];
    }
    return self;
}

- (void)layoutSubviews {
    CGRect attributedTextRect = [_attributedText boundingRectWithSize:(CGSize){self.frame.size.width, 1000} options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    CGFloat yOffset;
    //Check normal string or taller string in case of using superscript text
    if (attributedTextRect.size.height > 16) {
        yOffset = 2;
    } else {
        yOffset = 0;
    }
    self.textField.frame = (CGRect){{0, (self.frame.size.height - _arrowHeight - attributedTextRect.size.height) / 2 - yOffset}, {self.frame.size.width, attributedTextRect.size.height}};
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (_arrowEnabled) {
        CGContextAddPath(context, [self arrowPathForRect:rect]);
    }
    CGContextAddPath(context, [self roundedRectPathForRect:rect]);
    CGContextSetFillColorWithColor(context, self.balloonBackgroundColor.CGColor);
    CGContextFillPath(context);
}

- (CGMutablePathRef)arrowPathForRect:(CGRect)rect {
    if (_arrowIndent == -1.0f) {
        _arrowIndent = rect.size.width / 2;
    }
    CGPoint bottomArrowPoint = CGPointMake(_arrowIndent, rect.size.height);
    CGPoint leftArrowPoint = CGPointMake(bottomArrowPoint.x - _arrowHeight, bottomArrowPoint.y - _arrowHeight);
    CGPoint rightArrowPoint = CGPointMake(leftArrowPoint.x + _arrowHeight * 2, leftArrowPoint.y);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, leftArrowPoint.x, leftArrowPoint.y);
    CGPathAddLineToPoint(path, NULL, bottomArrowPoint.x, bottomArrowPoint.y);
    CGPathAddLineToPoint(path, NULL, rightArrowPoint.x, rightArrowPoint.y);
    
    return path;
}

- (CGMutablePathRef)roundedRectPathForRect:(CGRect)rect {
    CGRect balloonFrame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height - _arrowHeight);
    CGFloat maxCornerRadius = (2 * _cornerRadius >= CGRectGetHeight(balloonFrame) || 2 * _cornerRadius >= CGRectGetWidth(balloonFrame)) ? (CGRectGetWidth(balloonFrame) >= CGRectGetHeight(balloonFrame) ? CGRectGetHeight(balloonFrame) / 2 : CGRectGetWidth(balloonFrame) / 2) : _cornerRadius;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRoundedRect(path, NULL, balloonFrame, maxCornerRadius, maxCornerRadius);
    return path;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    self.balloonBackgroundColor = backgroundColor;
}

- (void)setBalloonBackgroundColor:(UIColor *)balloonBackgroundColor {
    _balloonBackgroundColor = balloonBackgroundColor;
    [self setNeedsDisplay];
}

- (void)setArrowHeight:(CGFloat)arrowHeight {
    _arrowHeight = arrowHeight;
    [self setNeedsDisplay];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    _attributedText = attributedText;
    self.textField.attributedText = _attributedText;
}

- (void)setArrowEnabled:(BOOL)arrowEnabled {
    _arrowEnabled = arrowEnabled;
    [self setNeedsDisplay];
}

- (void)setArrowIndent:(CGFloat)arrowIndent {
    if (arrowIndent > _cornerRadius + _arrowHeight / 2 && arrowIndent < self.frame.size.width - _cornerRadius - _arrowHeight / 2) {
        _arrowIndent = arrowIndent;
        [self setNeedsDisplay];
    } else {
        NSException *exception = [NSException exceptionWithName:@"InvalidArgumentException" reason:[NSString stringWithFormat:@"-[GSPDBalloonView setArrowIndent:] recevied invalid argument: %2.2f. Expected argument with value between %2.2f and %2.2f", arrowIndent, _cornerRadius + _arrowHeight / 2, self.frame.size.width - _cornerRadius - _arrowHeight / 2] userInfo:nil];
        @throw exception;
    }
}

@end
