//
//  CarouselScrollerView.m
//  SmartCommunity
//
//  Created by 陈洋 on 16/5/17.
//  Copyright © 2016年 shenghuo. All rights reserved.
//

#import "CarouselScrollerView.h"
#import "Masonry.h"
//#import "WebViewViewController.h"
#import "UIImageView+WebCache.h"

@interface CarouselScrollerView() {
    UIView *scrollContentView;
    UIView *tempFirstView;
    UIView *tempLastView;
    NSTimer *timer;
}
@property(strong, nonatomic) NSArray *imagesData;
@end

@implementation CarouselScrollerView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self main];
    }
    return self;
}

- (instancetype)init: (UIImage *)defaultImage {
    self = [super init];
    if (self) {
        [self main];
    }
    return self;
}

- (void)main {
    scrollContentView = UIView.new;
    self.delegate = self;
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)]];
    [self addSubview:scrollContentView];
    
    [scrollContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.height.equalTo(self.mas_height);
    }];
//    KYDrawerController *drawerController = (KYDrawerController *)[[[UIApplication sharedApplication].delegate window] rootViewController];
//    [self.panGestureRecognizer requireGestureRecognizerToFail:drawerController.screenEdgePanGesture];
}

- (void)dealloc {
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
}

- (void)setImagesData:(NSArray *)images {
    if (_imagesData == images) {
        return;
    }
    _imagesData = images;
    NSMutableArray *imagesArray = NSMutableArray.new;
    int i = 0;
    for (NSDictionary *image in images) {
        NSString *imgUrl = image[@"img_url"];
        imgUrl = imgUrl ? imgUrl : image[@"imgUrl"];
        imgUrl = imgUrl ? [imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] : @"";
        UIImageView *imageView = UIImageView.new;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:_defaultImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (i == 0 && tempLastView && image) {
                ((UIImageView *)(tempLastView)).image = image;
            }
            if (i == images.count - 1 && tempFirstView && image) {
                ((UIImageView *)(tempFirstView)).image = image;
            }
        }];
        [imagesArray addObject:imageView];
        i++;
    }
    if (images.count > 0) {
        @try {
            NSString *stopTime = [images firstObject][@"stop_time"];
            self.interval = stopTime.floatValue;
        }
        @catch (NSException *exception) {
            self.interval = 2;
        }
    }
    [self setViews:imagesArray];
}

- (void)setImages:(NSArray *)images {
    NSMutableArray *imagesArray = NSMutableArray.new;
    for (UIImage *image in images) {
        UIImageView *imageView = UIImageView.new;
        imageView.image = image;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [imagesArray addObject:imageView];
    }
    [self setViews:imagesArray];
}

- (void)setInterval:(float)interval {
    if (interval < 2) {
        _interval = 2;
    } else {
        _interval = interval;
    }
}

- (void)setViews:(NSArray *)views {
    _views = views;
    
    for (UIView *view in scrollContentView.subviews) {
        [view removeFromSuperview];
    }
    if (_views) {
        if (!tempFirstView && _views.count > 0) {
            NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:views.lastObject];
            tempFirstView = [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
            if ([tempFirstView isKindOfClass:UIImageView.class] && !((UIImageView *)(tempFirstView)).image.CGImage) {
                ((UIImageView *)(tempFirstView)).image = _defaultImage;
            }
        }
        [scrollContentView addSubview:tempFirstView];
        [tempFirstView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(0);
            make.top.equalTo(0);
            make.size.equalTo(self);
        }];
        UIView *prevView = tempFirstView;
        for (UIView *view in _views) {
            [scrollContentView addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(prevView.mas_right);
                make.top.equalTo(0);
                make.size.equalTo(self);
            }];
            
            prevView = view;
            if (!tempLastView && _views.count > 1) {
                NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
                tempLastView = [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
                if ([tempLastView isKindOfClass:UIImageView.class] && !((UIImageView *)(tempLastView)).image.CGImage) {
                    ((UIImageView *)(tempLastView)).image = _defaultImage;
                }
            }
        }
        if (!tempLastView  && _views.count == 0) {
            tempLastView = UIImageView.new;
            tempLastView.contentMode = UIViewContentModeScaleAspectFill;
            tempLastView.clipsToBounds = YES;
            ((UIImageView *)(tempLastView)).image = _defaultImage;
        }
        if (tempLastView) {
            [scrollContentView addSubview:tempLastView];
            [tempLastView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(prevView ? prevView.mas_right : @0);
                make.top.equalTo(0);
                make.size.equalTo(self);
                make.right.equalTo(scrollContentView);
            }];
        }
        if (_views.count > 1) {
            [self setContentOffset:CGPointMake(self.bounds.size.width, 0) animated: NO];
            if (timer && timer.isValid) {
                [timer invalidate];
                timer = nil;
            }
//            timer = [NSTimer scheduledTimerWithTimeInterval:self.interval target:self selector:@selector(changePage) userInfo:nil repeats:YES];
            [self shouldStartShow:YES];
            self.scrollEnabled = YES;
        } else {
            [self shouldStartShow:NO];
            if (_views.count == 1) {
                [self setContentOffset:CGPointMake(0, 0) animated:NO];
            }
            self.scrollEnabled = NO;
        }
    } else {
        UIImageView *tempLastImageView = UIImageView.new;
        tempLastImageView.image = _defaultImage;
        [scrollContentView addSubview:tempLastImageView];
        [tempLastImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(0);
            make.top.equalTo(0);
            make.size.equalTo(self);
        }];
    }
}

- (void)changePage {
    int index = self.contentOffset.x / self.bounds.size.width + 1;
    [self setContentOffset:CGPointMake(index * self.bounds.size.width, 0) animated:YES];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    //    self.scrollView.scrollEnabled = NO;
    if (self.carouselDelegate && [self.carouselDelegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [self.carouselDelegate scrollViewDidEndScrollingAnimation:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self shouldStartShow:NO];
    if (self.carouselDelegate && [self.carouselDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.carouselDelegate scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    [self shouldStartShow:YES];
    if (self.carouselDelegate && [self.carouselDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.carouselDelegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if (self.carouselDelegate && [self.carouselDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [self.carouselDelegate scrollViewWillBeginDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self shouldStartShow:NO];
    [self shouldStartShow:YES];
    if (self.carouselDelegate && [self.carouselDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.carouselDelegate scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float index = self.contentOffset.x / self.bounds.size.width;
    if (index >= _views.count + 1) {
        [self setContentOffset:CGPointMake(self.bounds.size.width, 0) animated: NO];
        index = 1;
    }
    if (index <= 0) {
        [self setContentOffset:CGPointMake(_views.count * self.bounds.size.width, 0) animated: NO];
        index = (float)_views.count;
    }
    self.pageIndex = (int)index - 1;
    if (self.carouselDelegate && [self.carouselDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.carouselDelegate scrollViewDidScroll:scrollView];
    }
}

- (void)shouldStartShow:(BOOL)shouldStart {
    if (shouldStart) {
        if (!timer || !timer.isValid) {
            timer = [NSTimer scheduledTimerWithTimeInterval:self.interval target:self selector:@selector(changePage) userInfo:nil repeats:YES];
            NSRunLoop *loop = [NSRunLoop mainRunLoop];
            [loop addTimer:timer forMode:NSRunLoopCommonModes];
        }
    } else {
        if (timer && timer.isValid) {
            [timer invalidate];
            timer = nil;
        }
    }
}

- (void)viewTapped:(UITapGestureRecognizer *)recognizer {
    @try {
        if (!self.views || self.views.count == 0 || !self.imagesData) {
            return;
        }
        int index = self.contentOffset.x / self.bounds.size.width - 1;
        if (index == -1) {
            index = 0;
        }
        NSDictionary *img = self.imagesData[index];
        NSString *url = img[@"skip_url"];
        url = url ? url : img[@"skipUrl"];
//        if (url && url.length > 1) {
//            [ViewUtil handleAppPageForward:url withController:[mAppUtils getCurrentViewController:self]];
//        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
}

@end
