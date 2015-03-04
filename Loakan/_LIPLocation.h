// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LIPLocation.h instead.

@import CoreData;

extern const struct LIPLocationAttributes {
	__unsafe_unretained NSString *address;
	__unsafe_unretained NSString *latitude;
	__unsafe_unretained NSString *longitude;
} LIPLocationAttributes;

extern const struct LIPLocationRelationships {
	__unsafe_unretained NSString *market;
} LIPLocationRelationships;

@class LIPMarket;

@interface LIPLocationID : NSManagedObjectID {}
@end

@interface _LIPLocation : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LIPLocationID* objectID;

@property (nonatomic, strong) NSString* address;

//- (BOOL)validateAddress:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* latitude;

@property (atomic) double latitudeValue;
- (double)latitudeValue;
- (void)setLatitudeValue:(double)value_;

//- (BOOL)validateLatitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* longitude;

@property (atomic) double longitudeValue;
- (double)longitudeValue;
- (void)setLongitudeValue:(double)value_;

//- (BOOL)validateLongitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) LIPMarket *market;

//- (BOOL)validateMarket:(id*)value_ error:(NSError**)error_;

@end

@interface _LIPLocation (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveAddress;
- (void)setPrimitiveAddress:(NSString*)value;

- (NSNumber*)primitiveLatitude;
- (void)setPrimitiveLatitude:(NSNumber*)value;

- (double)primitiveLatitudeValue;
- (void)setPrimitiveLatitudeValue:(double)value_;

- (NSNumber*)primitiveLongitude;
- (void)setPrimitiveLongitude:(NSNumber*)value;

- (double)primitiveLongitudeValue;
- (void)setPrimitiveLongitudeValue:(double)value_;

- (LIPMarket*)primitiveMarket;
- (void)setPrimitiveMarket:(LIPMarket*)value;

@end
