#import "GSPDSegmentedBarView.h"
#import "GSPDSegmentView.h"
#import "GSPDSegmentedBarSegment.h"
#import "GSPDBalloonView.h"

static NSInteger const NO_VALUE_SEGMENT_INDEX = -1;

@interface GSPDSegmentedBarView ()

@property (nonatomic, strong) NSArray *segmentViews;
@property (nonatomic, strong) GSPDBalloonView *valueView;

@end

@implementation GSPDSegmentedBarView {
    CGFloat balloonViewHeight;
    CGFloat balloonViewWidth;
    CGFloat arrowViewHeight;
    CGFloat segmentViewHeight;
    UIFont *balloonValueFont;
    UIFont *balloonUnitFont;
}

- (instancetype)initWithValue:(NSNumber *)value unit:(NSAttributedString *)unit segments:(NSArray *)segments {
    return [self initWithValue:value unit:unit segments:segments valueSegmentIndex:NO_VALUE_SEGMENT_INDEX];
}

- (instancetype)initWithValue:(NSNumber *)value unit:(NSAttributedString *)unit segments:(NSArray *)segments valueSegmentIndex:(NSUInteger)index {
    self = [super init];
    if (self) {
        _value = value;
        _unit = unit;
        _segments = segments;
        _valueSegmentIndex = index;
        _valueSegmentText = @"Current Value";
        [self initialConfiguration];
        [self generateSegmentViewsForSegments];
        [self generateValueView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _value = nil;
        _unit = nil;
        _segments = nil;
        _valueSegmentIndex = NO_VALUE_SEGMENT_INDEX;
        _valueSegmentText = @"Current Value";
        [self initialConfiguration];
        [self generateSegmentViewsForSegments];
        [self generateValueView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _value = nil;
        _unit = nil;
        _segments = nil;
        _valueSegmentIndex = NO_VALUE_SEGMENT_INDEX;
        _valueSegmentText = @"Current Value";
        [self initialConfiguration];
        [self generateSegmentViewsForSegments];
        [self generateValueView];
    }
    return self;
}

- (void) initialConfiguration {
    
    _distanceBetweenSegments = 3.0f;
    _noSegmentsText = @"Empty";
    _noSegmentsBackgroundColor = [UIColor lightGrayColor];
    balloonViewHeight = 32.0f;
    balloonViewWidth = 72.0f;
    arrowViewHeight = 5.0f;
    segmentViewHeight = 48.0f;
    _valuesTextColor = [UIColor whiteColor];
    _descriptionsTextColor = [UIColor lightGrayColor];
    _balloonTextColor = [UIColor whiteColor];
    _valuesFont = [UIFont systemFontOfSize:12];
    _descriptionsFont = [UIFont systemFontOfSize:12];
    balloonValueFont = [UIFont systemFontOfSize:12];
    balloonUnitFont = [UIFont systemFontOfSize:10];
}

- (NSInteger)segmentIndexForValue:(NSNumber *)value {
    NSInteger currentIndex = 0;
    for (GSPDSegmentedBarSegment *segment in self.segments) {
        if (([value compare:segment.minValue] == NSOrderedDescending || ([value compare:segment.minValue] == NSOrderedSame && segment.containsMinValue)) && ([value compare:segment.maxValue] == NSOrderedAscending || ([value compare:segment.maxValue] == NSOrderedSame && segment.containsMaxValue))) {
            return currentIndex;
        }
        currentIndex++;
    }
    return NO_VALUE_SEGMENT_INDEX;
}

- (CGFloat)offsetForValue:(NSNumber *)value insideSegmentWithIndex:(NSInteger)index withWidth:(CGFloat)width {
    GSPDSegmentedBarSegment *segment = [self.segments objectAtIndex:index];
    if (![segment isPoint]) {
        return width * ((value.doubleValue - segment.minValue.doubleValue) / (segment.maxValue.doubleValue - segment.minValue.doubleValue));
    } else {
        return width / 2;
    }
}

- (void)setSegments:(NSArray *)segments {
    _segments = [segments sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        GSPDSegmentedBarSegment *segment1 = (GSPDSegmentedBarSegment *)obj1;
        GSPDSegmentedBarSegment *segment2 = (GSPDSegmentedBarSegment *)obj2;
        NSComparisonResult result = [segment1.minValue compare:segment2.minValue];
        if (result == NSOrderedSame) {
            if (segment1.containsMinValue) {
                return NSOrderedAscending;
            } else {
                return NSOrderedDescending;
            }
        } else {
            return result;
        }
    }];
    [self generateSegmentViewsForSegments];
    [self generateValueView];
}

- (void)generateSegmentViewsForSegments {
    if (_segmentViews.count > 0) {
        for (GSPDSegmentView *segmentView in _segmentViews) {
            [segmentView removeFromSuperview];
        }
    }
    if (!self.segments || self.segments.count == 0) {
        GSPDSegmentedBarSegment *emptySegment = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(0.0) maxValue:@(0.0) color:self.noSegmentsBackgroundColor];
        emptySegment.text = self.noSegmentsText;
        GSPDSegmentView *segmentView = [[GSPDSegmentView alloc] initWithSegment:emptySegment angleStyle:GSPDSegmentViewAngleStyleTwoSided];
        [self addSubview:segmentView];
        _segmentViews = @[segmentView];
    } else {
        NSMutableArray *segmentViews = [NSMutableArray arrayWithCapacity:self.segments.count];
        NSUInteger index = 0;
        for (GSPDSegmentedBarSegment *segment in self.segments) {
            GSPDSegmentViewAngleStyle angleStyle;
            if (index == 0) {
                if (self.segments.count == 1) {
                    angleStyle = GSPDSegmentViewAngleStyleTwoSided;
                } else {
                    angleStyle = GSPDSegmentViewAngleStyleLeftSided;
                }
            } else {
                if (index < self.segments.count - 1) {
                    angleStyle = GSPDSegmentViewAngleStyleDefault;
                } else {
                    angleStyle = GSPDSegmentViewAngleStyleRightSided;
                }
            }
            GSPDSegmentView *segmentView = [[GSPDSegmentView alloc] initWithSegment:segment angleStyle:angleStyle];
            [self addSubview:segmentView];
            [segmentViews addObject:segmentView];
            index++;
        }
        _segmentViews = segmentViews;
    }
    [self setNeedsLayout];
}

- (void)generateValueView {
    [self.valueView removeFromSuperview];
    if (_value || _valueSegmentIndex != NO_VALUE_SEGMENT_INDEX) {
        self.valueView = [[GSPDBalloonView alloc] initWithFrame:CGRectNull];
        //TODO: add value + unit and customize
        NSAttributedString *valueUnitString = [self generateValueUnitString];
        self.valueView.attributedText = valueUnitString;
        [self addSubview:self.valueView];
    } else {
        self.valueView = nil;
    }
    [self setNeedsLayout];
}

- (NSAttributedString *)generateValueUnitString {
    NSMutableAttributedString *valueUnitString = [[NSMutableAttributedString alloc] init];
    NSMutableDictionary *valueAttributes = [@{NSFontAttributeName : balloonValueFont,
                                              NSForegroundColorAttributeName : _balloonTextColor,
                                              NSBackgroundColorAttributeName : [UIColor clearColor]} mutableCopy];
    if (self.valueSegmentIndex != NO_VALUE_SEGMENT_INDEX) {
        [valueAttributes setObject:[UIFont systemFontOfSize:9] forKey:NSFontAttributeName];
        [valueUnitString appendAttributedString:[[NSAttributedString alloc] initWithString:_valueSegmentText attributes:valueAttributes]];
    } else {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        formatter.maximumFractionDigits = 3;
        [valueUnitString appendAttributedString:[[NSAttributedString alloc] initWithString:[formatter stringFromNumber:_value]
                                                                                attributes:valueAttributes]];
        if (_unit) {
            NSMutableAttributedString *mutableUnit = [_unit mutableCopy];
            [valueUnitString appendAttributedString:[[NSAttributedString alloc] initWithString:@" " attributes:valueAttributes]];
            [mutableUnit enumerateAttributesInRange:NSMakeRange(0, _unit.length) options:NSAttributedStringEnumerationReverse usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
                NSMutableDictionary *mutableAttributes = [NSMutableDictionary dictionaryWithDictionary:attrs];
                [mutableAttributes setObject:balloonUnitFont forKey:NSFontAttributeName];
                [mutableUnit setAttributes:mutableAttributes range:range];
            }];
            [valueUnitString appendAttributedString:mutableUnit];
        }
    }
    return valueUnitString;
}

- (void)layoutSubviews {
    CGFloat segmentViewsYOffset;
    if (self.valueView) {
        segmentViewsYOffset = balloonViewHeight + arrowViewHeight;
    } else {
        segmentViewsYOffset = 0;
    }
    NSUInteger segmentViewsCount = _segmentViews.count;
    CGFloat segmentViewWidth = (self.frame.size.width - (segmentViewsCount - 1) * self.distanceBetweenSegments) / segmentViewsCount;
    NSUInteger index = 0;
    CGFloat minSegmentViewBottomPadding = CGFLOAT_MAX;
    for (GSPDSegmentView *segmentView in _segmentViews) {
        segmentView.frame = (CGRect){{index * (segmentViewWidth + self.distanceBetweenSegments), segmentViewsYOffset}, {segmentViewWidth, segmentViewHeight}};
        if (segmentView.bottomPadding < minSegmentViewBottomPadding) {
            minSegmentViewBottomPadding = segmentView.bottomPadding;
        }
        index++;
    }
    CGSize expectedSize = self.frame.size;
    CGSize realSize = (CGSize){self.frame.size.width, segmentViewsYOffset + segmentViewHeight};
    _bottomPadding = expectedSize.height - realSize.height;
    
    if (self.valueSegmentIndex != NO_VALUE_SEGMENT_INDEX) {
        self.valueView.arrowEnabled = YES;
        self.valueView.frame = (CGRect){{self.valueSegmentIndex * (segmentViewWidth + self.distanceBetweenSegments) + segmentViewWidth / 2 - balloonViewWidth / 2, 0}, {balloonViewWidth, balloonViewHeight + arrowViewHeight}};
    } else {
        NSUInteger segmentIndex = [self segmentIndexForValue:self.value];
        if (segmentIndex == NO_VALUE_SEGMENT_INDEX) {
            self.valueView.arrowEnabled = NO;
            self.valueView.frame = (CGRect){{self.frame.size.width / 2 - balloonViewWidth / 2, 0}, {balloonViewWidth, balloonViewHeight + arrowViewHeight}};
        } else {
            self.valueView.arrowEnabled = YES;
            CGFloat offset;
            GSPDSegmentView *segmentViewForIndex = self.segmentViews[segmentIndex];
            if (segmentIndex == 0) {
                if (self.segments.count == 1) {
                    offset = segmentViewForIndex.angularPartWidth + [self offsetForValue:self.value insideSegmentWithIndex:segmentIndex withWidth:segmentViewWidth - 2 * (segmentViewForIndex.angularPartWidth)];
                } else {
                    offset = segmentViewForIndex.angularPartWidth + [self offsetForValue:self.value insideSegmentWithIndex:segmentIndex withWidth:segmentViewWidth - segmentViewForIndex.angularPartWidth];
                }
            } else {
                if (segmentIndex < self.segments.count - 1) {
                    offset = [self offsetForValue:self.value insideSegmentWithIndex:segmentIndex withWidth:segmentViewWidth];
                } else {
                    offset = [self offsetForValue:self.value insideSegmentWithIndex:segmentIndex withWidth:segmentViewWidth - segmentViewForIndex.angularPartWidth];
                }
            }
            CGRect virtualValueViewFrame = (CGRect){{segmentIndex * (segmentViewWidth + self.distanceBetweenSegments) + offset - balloonViewWidth / 2, 0}, {balloonViewWidth, balloonViewHeight+ arrowViewHeight}};
            CGFloat xOffset;
            if (virtualValueViewFrame.origin.x < 0) {
                xOffset = virtualValueViewFrame.origin.x;
            } else if (virtualValueViewFrame.origin.x + virtualValueViewFrame.size.width > self.frame.size.width) {
                xOffset = virtualValueViewFrame.origin.x + virtualValueViewFrame.size.width - self.frame.size.width;
            } else {
                xOffset = 0;
            }
            CGRect realValueViewFrame = (CGRect){{virtualValueViewFrame.origin.x - xOffset, virtualValueViewFrame.origin.y}, virtualValueViewFrame.size};
            self.valueView.frame = realValueViewFrame;
            self.valueView.arrowIndent = self.valueView.frame.size.width / 2 + xOffset;
        }
    }
}

- (void)setValue:(NSNumber *)value {
    _value = value;
    [self generateValueView];
}

- (void)setValueSegmentIndex:(NSInteger)valueSegmentIndex {
    _valueSegmentIndex = valueSegmentIndex;
    [self generateValueView];
}

- (void)setUnit:(NSAttributedString *)unit {
    _unit = unit;
    [self generateValueView];
}

- (void)setDistanceBetweenSegments:(CGFloat)distanceBetweenSegments {
    _distanceBetweenSegments = distanceBetweenSegments;
    [self setNeedsLayout];
}

- (void)setNoSegmentsBackgroundColor:(UIColor *)noSegmentsBackgroundColor {
    _noSegmentsBackgroundColor = noSegmentsBackgroundColor;
    if (!self.segments || self.segments.count == 0) {
        [self setNeedsLayout];
    }
}

- (void)setNoSegmentsText:(NSString *)noSegmentsText {
    _noSegmentsText = noSegmentsText;
    if (!self.segments || self.segments.count == 0) {
        [self setNeedsLayout];
    }
}

- (void)setValuesTextColor:(UIColor *)valuesTextColor {
    _valuesTextColor = valuesTextColor;
    for (GSPDSegmentView *segmentView in _segmentViews) {
        segmentView.valuesTextColor = _valuesTextColor;
    }
}

- (void)setValuesFont:(UIFont *)valuesFont {
    _valuesFont = valuesFont;
    for (GSPDSegmentView *segmentView in _segmentViews) {
        segmentView.valuesFont = _valuesFont;
    }
}

- (void)setDescriptionsTextColor:(UIColor *)descriptionsTextColor {
    _descriptionsTextColor = descriptionsTextColor;
    for (GSPDSegmentView *segmentView in _segmentViews) {
        segmentView.descriptionsTextColor = _descriptionsTextColor;
    }
}

- (void)setDescriptionsFont:(UIFont *)descriptionsFont {
    _descriptionsFont = descriptionsFont;
    for (GSPDSegmentView *segmentView in _segmentViews) {
        segmentView.descriptionsFont = _descriptionsFont;
    }
}

- (BOOL)isFractionNumber:(NSNumber *)number {
    double dValue = [number doubleValue];
    if (dValue < 0.0)
        return (dValue != ceil(dValue));
    else
        return (dValue != floor(dValue));
}

@end
