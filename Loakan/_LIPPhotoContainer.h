// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LIPPhotoContainer.h instead.

@import CoreData;

extern const struct LIPPhotoContainerAttributes {
	__unsafe_unretained NSString *photoData;
} LIPPhotoContainerAttributes;

extern const struct LIPPhotoContainerRelationships {
	__unsafe_unretained NSString *markets;
} LIPPhotoContainerRelationships;

@class LIPMarket;

@interface LIPPhotoContainerID : NSManagedObjectID {}
@end

@interface _LIPPhotoContainer : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LIPPhotoContainerID* objectID;

@property (nonatomic, strong) NSData* photoData;

//- (BOOL)validatePhotoData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) LIPMarket *markets;

//- (BOOL)validateMarkets:(id*)value_ error:(NSError**)error_;

@end

@interface _LIPPhotoContainer (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitivePhotoData;
- (void)setPrimitivePhotoData:(NSData*)value;

- (LIPMarket*)primitiveMarkets;
- (void)setPrimitiveMarkets:(LIPMarket*)value;

@end
