#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GSPDAngularViewStyle) {
    GSPDAngularViewStyleDefault,
    GSPDAngularViewStyleLeftSided,
    GSPDAngularViewStyleRightSided,
    GSPDAngularViewStyleTwoSided
};

@interface GSPDAngularView : UIView

@property (nonatomic, assign) CGFloat anglularPartWidth;
@property (nonatomic, assign) GSPDAngularViewStyle style;
@property (nonatomic, assign) UIColor *customBackgroundColor;

- (instancetype)initWithAngularPartWidth:(CGFloat)angularPartWidth style:(GSPDAngularViewStyle)style backgroundColor:(UIColor *)backgroundColor;
- (instancetype)initWithStyle:(GSPDAngularViewStyle)style;

@end
