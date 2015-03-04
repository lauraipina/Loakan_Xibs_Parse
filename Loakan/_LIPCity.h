// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LIPCity.h instead.

@import CoreData;

extern const struct LIPCityAttributes {
	__unsafe_unretained NSString *name;
} LIPCityAttributes;

extern const struct LIPCityRelationships {
	__unsafe_unretained NSString *markets;
} LIPCityRelationships;

@class LIPMarket;

@interface LIPCityID : NSManagedObjectID {}
@end

@interface _LIPCity : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LIPCityID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *markets;

- (NSMutableSet*)marketsSet;

@end

@interface _LIPCity (MarketsCoreDataGeneratedAccessors)
- (void)addMarkets:(NSSet*)value_;
- (void)removeMarkets:(NSSet*)value_;
- (void)addMarketsObject:(LIPMarket*)value_;
- (void)removeMarketsObject:(LIPMarket*)value_;

@end

@interface _LIPCity (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSMutableSet*)primitiveMarkets;
- (void)setPrimitiveMarkets:(NSMutableSet*)value;

@end
