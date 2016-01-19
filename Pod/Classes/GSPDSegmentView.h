#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GSPDSegmentViewAngleStyle) {
    GSPDSegmentViewAngleStyleDefault,
    GSPDSegmentViewAngleStyleLeftSided,
    GSPDSegmentViewAngleStyleRightSided,
    GSPDSegmentViewAngleStyleTwoSided
};

@class GSPDSegmentedBarSegment;

@interface GSPDSegmentView : UIView

@property (nonatomic, strong) GSPDSegmentedBarSegment *segment;
@property (nonatomic, assign) GSPDSegmentViewAngleStyle angleStyle;
@property (nonatomic, strong) UIColor *valuesTextColor;
@property (nonatomic, strong) UIColor *descriptionsTextColor;
@property (nonatomic, strong) UIFont *valuesFont;
@property (nonatomic, strong) UIFont *descriptionsFont;
@property (nonatomic, assign) CGFloat angularPartWidth;
@property (nonatomic, assign, readonly) CGFloat bottomPadding;

- (instancetype)initWithSegment:(GSPDSegmentedBarSegment *)segment angleStyle:(GSPDSegmentViewAngleStyle)style;

@end
