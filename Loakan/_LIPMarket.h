// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LIPMarket.h instead.

@import CoreData;

extern const struct LIPMarketAttributes {
	__unsafe_unretained NSString *facebook;
	__unsafe_unretained NSString *favorite;
	__unsafe_unretained NSString *info;
	__unsafe_unretained NSString *instagram;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *timetable;
	__unsafe_unretained NSString *twitter;
	__unsafe_unretained NSString *web;
} LIPMarketAttributes;

extern const struct LIPMarketRelationships {
	__unsafe_unretained NSString *address;
	__unsafe_unretained NSString *city;
	__unsafe_unretained NSString *photo;
} LIPMarketRelationships;

@class LIPLocation;
@class LIPCity;
@class LIPPhotoContainer;

@interface LIPMarketID : NSManagedObjectID {}
@end

@interface _LIPMarket : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LIPMarketID* objectID;

@property (nonatomic, strong) NSString* facebook;

//- (BOOL)validateFacebook:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* favorite;

@property (atomic) BOOL favoriteValue;
- (BOOL)favoriteValue;
- (void)setFavoriteValue:(BOOL)value_;

//- (BOOL)validateFavorite:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* info;

//- (BOOL)validateInfo:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* instagram;

//- (BOOL)validateInstagram:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* timetable;

//- (BOOL)validateTimetable:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* twitter;

//- (BOOL)validateTwitter:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* web;

//- (BOOL)validateWeb:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) LIPLocation *address;

//- (BOOL)validateAddress:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) LIPCity *city;

//- (BOOL)validateCity:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) LIPPhotoContainer *photo;

//- (BOOL)validatePhoto:(id*)value_ error:(NSError**)error_;

@end

@interface _LIPMarket (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveFacebook;
- (void)setPrimitiveFacebook:(NSString*)value;

- (NSNumber*)primitiveFavorite;
- (void)setPrimitiveFavorite:(NSNumber*)value;

- (BOOL)primitiveFavoriteValue;
- (void)setPrimitiveFavoriteValue:(BOOL)value_;

- (NSString*)primitiveInfo;
- (void)setPrimitiveInfo:(NSString*)value;

- (NSString*)primitiveInstagram;
- (void)setPrimitiveInstagram:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveTimetable;
- (void)setPrimitiveTimetable:(NSString*)value;

- (NSString*)primitiveTwitter;
- (void)setPrimitiveTwitter:(NSString*)value;

- (NSString*)primitiveWeb;
- (void)setPrimitiveWeb:(NSString*)value;

- (LIPLocation*)primitiveAddress;
- (void)setPrimitiveAddress:(LIPLocation*)value;

- (LIPCity*)primitiveCity;
- (void)setPrimitiveCity:(LIPCity*)value;

- (LIPPhotoContainer*)primitivePhoto;
- (void)setPrimitivePhoto:(LIPPhotoContainer*)value;

@end
