//
//  OpenCVWrapper.m
//  scan-test
//
//  Created by peter on 2017/6/6.
//  Copyright © 2017年 Peter. All rights reserved.
//

#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>
//using namespace std;
#import "scan-test-Bridging-Header.h"
#import <UIKit/UIKit.h>

using namespace std;


@implementation OpenCVWrapper
- (void) isThisWorking {
    cout << "Hey" << endl;
}

+(UIImage *)ConvertImage:(UIImage *)image {
    cv::Mat mat;
    UIImageToMat(image, mat);
    
    cv::Mat gray;
    cv::cvtColor(mat, gray, CV_RGB2GRAY);
    
//    cv::Mat bin;
//    cv::threshold(gray, bin, 0, 255, cv::THRESH_BINARY | cv::THRESH_OTSU);
    
    UIImage *binImg = MatToUIImage(gray);
    return binImg;
}
@end
