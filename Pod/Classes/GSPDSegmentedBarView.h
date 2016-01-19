#import <UIKit/UIKit.h>
#import "GSPDSegmentedBarSegment.h"

@interface GSPDSegmentedBarView : UIView

@property (nonatomic, strong) NSNumber *value;
@property (nonatomic, strong) NSAttributedString *unit;
@property (nonatomic, strong) NSArray *segments;
@property (nonatomic, assign) NSInteger valueSegmentIndex;
@property (nonatomic, strong) NSString *valueSegmentText;

//Customize appearance
@property (nonatomic, assign) CGFloat distanceBetweenSegments;
@property (nonatomic, strong) NSString *noSegmentsText;
@property (nonatomic, strong) UIColor *noSegmentsBackgroundColor;
@property (nonatomic, strong) UIColor *valuesTextColor;
@property (nonatomic, strong) UIColor *descriptionsTextColor;
@property (nonatomic, strong) UIColor *balloonTextColor;
@property (nonatomic, strong) UIFont *valuesFont;
@property (nonatomic, strong) UIFont *descriptionsFont;

//Readonly Properties
@property (nonatomic, assign, readonly) CGFloat bottomPadding;

- (instancetype)initWithValue:(NSNumber *)value unit:(NSAttributedString *)unit segments:(NSArray *)segments;

@end
