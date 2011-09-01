//
//  FileUploader.h
//  Muppets
//
//  Created by Gaurav Sharma on 6/17/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    FileUploaderStatusNew=0,
    FileUploaderStatusUploadCompleted,
    FileUploaderStatusUploadError,
    FileUploaderStatusNotifiedServer,
    FileUploaderStatusNotifiedServerError,
} FileUploaderStatus;

@class FileUploader;

@protocol FileUploadListener
@optional
- (void)uploadStatusChanged:(FileUploader *)uploader;
@end

typedef void(^StatusBlock)(FileUploaderStatus);
typedef void(^FinishedBlock)(FileUploader *, NSDictionary *);

@interface FileUploader : NSObject {
    FileUploaderStatus status;
    id delegate;

    StatusBlock statusBlock;
    FinishedBlock finishedBlock;
    
    NSDictionary *asset;
}

@property (nonatomic, assign) FileUploaderStatus status;
@property (nonatomic, retain) id delegate;
@property (nonatomic, copy) StatusBlock statusBlock;
@property (nonatomic, copy) FinishedBlock finishedBlock;
@property (nonatomic, retain) NSDictionary *asset;


- (void)startUploadingImage:(UIImage *)image 
                  withToken:(NSDictionary *)aToken 
              statusChanged:(void (^)(FileUploaderStatus))astatusblock
                   finished:(void (^)(FileUploader *, NSDictionary *))acompletionblock;

- (void)startUploadingFile:(NSString *)path
                 withToken:(NSDictionary *)aToken 
             statusChanged:(void (^)(FileUploaderStatus))astatusblock
                  finished:(void (^)(FileUploader *, NSDictionary *))acompletionblock;

@end


