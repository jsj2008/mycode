//
//  ImageDownloaderBackground.h
//  iShopShape
//
//  Created by Santosh B on 30/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <Foundation/Foundation.h>

//@protocol ImageDownloaderDelegate;

@interface ImageDownloaderBackground : NSObject {
	//id <ImageDownloaderDelegate> delegate;
	NSMutableData *activeDownload;
    NSURLConnection *imageConnection;
	NSIndexPath *indexPathInTableView;
	NSURLRequest *urlRequest;
	NSString *instructionId;
}

@property (nonatomic, retain) NSIndexPath *indexPathInTableView;
@property (nonatomic, retain) NSMutableData *activeDownload;
@property (nonatomic, retain) NSURLConnection *imageConnection;
@property (nonatomic, retain) NSString *instructionId;

- (id) initWithRequest : (NSURL *)url;
- (void)startDownload;
- (void)cancelDownload;
@end

//@protocol ImageDownloaderDelegate 
//
//- (void)downloadDidFinishDownloading:(UIImage *)image index:(NSIndexPath *)indexPath;
//
//- (void)downloadDidFinishWithError:(NSError *)error;
//
//@end