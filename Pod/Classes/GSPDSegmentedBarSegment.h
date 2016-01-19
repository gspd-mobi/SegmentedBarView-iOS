#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GSPDSegmentedBarSegmentSideTextStyle) {
    GSPDSegmentedBarSegmentSideTextStyleTwoSided,
    GSPDSegmentedBarSegmentSideTextStyleOneSided
};

@interface GSPDSegmentedBarSegment : NSObject

@property (nonatomic, strong) NSNumber *minValue;
@property (nonatomic, strong) NSNumber *maxValue;
@property (nonatomic, strong) NSString *segmentDescription;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) BOOL containsMinValue;
@property (nonatomic, assign) BOOL containsMaxValue;
@property (nonatomic, assign) GSPDSegmentedBarSegmentSideTextStyle sideTextStyle;

- (instancetype)initWithMinValue:(NSNumber *)minValue maxValue:(NSNumber *)maxValue color:(UIColor *)color;

- (BOOL)isPoint;

@end
