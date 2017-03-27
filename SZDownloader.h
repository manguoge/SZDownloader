//
//  SZDownloader.h
//  LalightL
//
//  Created by comfouriertech on 17/3/27.
//  Copyright © 2017年 ronghua_li. All rights reserved.
//

#import <Foundation/Foundation.h>

//for block

typedef void (^SZDownloadProgressBlock)(float progressValue,NSInteger percentage);
typedef void (^SZDowloadFinished)(NSData* fileData);
typedef void (^SZDownloadFailBlock)(NSError*error);


@protocol SZdownloaderDelegate <NSObject>

@required
-(void)SZDownloadProgress:(float)progress Percentage:(NSInteger)percentage;
-(void)SZDownloadFinished:(NSData*)fileData;
-(void)SZDownloadFail:(NSError*)error;
@end

@interface SZdownloader : NSObject <NSURLConnectionDataDelegate>

//properties
@property (nonatomic,readonly) NSMutableData* receiveData;
@property (nonatomic,readonly) NSInteger downloadedPercentage;
@property (nonatomic,readonly) float progress;

@property (nonatomic,strong) id<SZdownloaderDelegate>delegate;
//initwith file URL and timeout
-(id)initWithURL:(NSURL *)fileURL timeout:(NSInteger)timeout;

-(void)startWithDownloading:(SZDownloadProgressBlock)progressBlock onFinished:(SZDowloadFinished)finishedBlock onFail:(SZDownloadFailBlock)failBlock;

-(void)startWithDelegate:(id<SZdownloaderDelegate>)delegate;
-(void)cancel;
@end
