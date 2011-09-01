//
//  CanvasUploader.m
//  Muppets
//
//  Created by Gaurav Sharma on 6/20/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import "CanvasUploader.h"
#import "ASIHTTPRequest.h"
#import "SBJson.h"
#import "FileUploader.h"

@implementation CanvasUploader

//@synthesize canvasViewController;

- (void)startUpload{
  //  ASIHTTPRequest *_request    = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:kMuppetsApiNewCanvas([canvasViewController.canvas.subviews count])]];

	//[_request setDelegate:self];
   // [_request setDidFinishSelector:@selector(requestDone:)];
	//[_request setDidFailSelector:@selector(requestFailed:)];

   // [_request startAsynchronous];
}

//- (void)requestDone:(ASIHTTPRequest *)request{
//    NSDictionary *_responseData = [[[request responseString] JSONValue] objectForKey:@"data"];
//    dispatch_queue_t myQueue    = dispatch_queue_create("com.muppets.uploadqueue", 0);
//    
//    __block int index=0;
//    for (NSDictionary *_asset in [_responseData objectForKey:@"assets"]) {
//        dispatch_async(myQueue, ^{
//            FileUploader *_uploader = [FileUploader new];
//            UIImage *_uploadImage   = [[[canvasViewController.canvas subviews] objectAtIndex:index++] captureImage];
//            [_uploader startUploadingImage:_uploadImage withToken:_asset statusChanged:^(FileUploaderStatus status){
//                NSLog(@"%d", status);
//            } finished:^(FileUploader *uploader, NSDictionary *response) {
//                [uploader release];
//            }];
//        });
//    }
//}

- (void)requestFailed:(ASIHTTPRequest *)request{
}

- (void)uploadScene{
    ASIHTTPRequest *_request    = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:kMuppetsApiNewVideoCanvas]];
    
	[_request setDelegate:self];
    [_request setDidFinishSelector:@selector(uploadSceneDone:)];
	[_request setDidFailSelector:@selector(uploadSceneFailed:)];
    
    [_request startAsynchronous];
}

//- (void)uploadSceneDone:(ASIHTTPRequest *)request{
//    NSDictionary *_responseData = [[[request responseString] JSONValue] objectForKey:@"data"];
//    dispatch_queue_t myQueue    = dispatch_queue_create("com.muppets.uploadqueue", 0);
//    
//    for (NSDictionary *_asset in [_responseData objectForKey:@"assets"]) {
//        dispatch_async(myQueue, ^{
//            FileUploader *_uploader = [FileUploader new];
//            DLog(@"%@: %@", [_asset objectForKey:@"asset_type"], [canvasViewController pathForResourceType:[_asset objectForKey:@"asset_type"]])
//            [_uploader startUploadingFile:[canvasViewController pathForResourceType:[_asset objectForKey:@"asset_type"]] withToken:_asset statusChanged:^(FileUploaderStatus status){
//                NSLog(@"%d", status);
//            } finished:^(FileUploader *uploader, NSDictionary *response) {
//                if ([response objectForKey:@"canvas"]) {
//                    NSString *_sharePath = [[response objectForKey:@"canvas"] objectForKey:@"url"];
//                    canvasViewController.sharePath = [_sharePath copy];
//                }
//                [uploader release];
//            }];
//        });
//    }
//
//}

- (void)uploadSceneFailed:(ASIHTTPRequest *)request{
}


- (void)dealloc{
   // [canvasViewController release];
    [super dealloc];
}

@end
