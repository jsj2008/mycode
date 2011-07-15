//
//  StyleCustomCell.h
//  iShopShape
//
//  Created by Santosh B on 27/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "ImageDownloader.h"

@interface StyleCustomCell : UITableViewCell  <ImageDownloaderDelegate>{
	UIImageView *thumbnailImageView;
	UIImageView *hotspotBgImageView;
	UILabel *productNameLbl;
	UILabel *productIdLbl;
	UILabel *productQtyLbl;
	UILabel *hotspotIDLbl;
	UIActivityIndicatorView *activityIndicator;
	ImageDownloader *imgDownloader;
	BOOL isDownloading;
	Product *product;
	UIButton *someButton;
}
@property (nonatomic, retain) UIImageView *thumbnailImageView;
@property (nonatomic, retain) UIImageView *hotspotBgImageView;
@property (nonatomic, retain) UILabel *productNameLbl;
@property (nonatomic, retain) UILabel *productIdLbl;
@property (nonatomic, retain) UILabel *productQtyLbl;
@property (nonatomic, retain) UILabel *hotspotIDLbl;
@property(nonatomic,retain) ImageDownloader *imgDownloader;

/**
 *	@functionName	: isStyleImageExistInCache
 *	@parameters		: 
 *	@return			: (BOOL)
 *	@description	: CHeck if Style Image Exist In Cache
 */
- (BOOL) isStyleImageExistInCache;

/**
 *	@functionName	: setCellData
 *	@parameters		: 
 *	@return			: (void)
 *	@description	: set the content of the costum cell with product details
 */
- (void) setCellData : (Product *)product;
@end
