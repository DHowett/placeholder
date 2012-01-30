@interface SDFileType : NSObject {
	NSArray *_MIMETypes;
	NSArray *_extensions;
	NSString *_name;
	NSString *_genericType;
	NSString *_category;
	BOOL _forceExtensionUse;
}
@property (nonatomic, readonly, copy) NSArray *MIMETypes;
@property (nonatomic, readonly, copy) NSArray *extensions;
@property (nonatomic, readonly, retain) NSString *name;
@property (nonatomic, readonly, retain) NSString *genericType;
@property (nonatomic, readonly, retain) NSString *category;
@property (nonatomic, readonly, assign) BOOL forceExtensionUse;
@property (nonatomic, readonly) NSString *primaryMIMEType;
+ (void)loadAllFileTypes;
+ (void)unloadAllFileTypes;
+ (SDFileType *)fileTypeForMIMEType:(NSString *)MIMEType;
+ (SDFileType *)fileTypeForExtension:(NSString *)extension;
+ (SDFileType *)fileTypeForExtension:(NSString *)extension orMIMEType:(NSString *)MIMEType;
#if SDFILETYPE_MAP_CATEGORIES == 1
+ (NSDictionary *)allCategories;
#endif
- (id)initWithName:(NSString *)name dictionary:(NSString *)dictionary;
@end
