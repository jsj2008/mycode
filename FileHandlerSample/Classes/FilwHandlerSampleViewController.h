//
//  FilwHandlerSampleViewController.h
//  FilwHandlerSample
//
//  Created by Santosh on 25/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilwHandlerSampleViewController : UIViewController {

}
- (IBAction) createFile : (id)sender;
- (IBAction) deleteFile : (id) sender;
- (IBAction) writeToFile :(id) sender;
- (IBAction) readToFile : (id)sender;
- (IBAction) copyFile : (id)sender;
- (IBAction) moveFile : (id)sender;
- (IBAction) getFileAttribute : (id)sender;
- (IBAction) changeAttribute :(id) sender;

- (void) seekFile;
//Plist

- (IBAction) readPlistFile: (id)sender;
- (IBAction) writePlistFile : (id)sender;


- (NSMutableDictionary *) getPlistFileSettings;
- (void) setPlistFileSettings : (id) value key:(NSString *)key;
@end

