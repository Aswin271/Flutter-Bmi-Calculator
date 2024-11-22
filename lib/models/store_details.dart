// import 'dart:convert';

class StoreDetails {
  String storeName;
  int storeAge;
  int storeHeight;
  int storeWeight;
  double storeResult;  // Change to double to match the BMI result

  StoreDetails(this.storeName, this.storeAge, this.storeHeight, this.storeWeight, this.storeResult);

  Map<String, dynamic> toJson() => {
        'storeName': storeName,
        'storeAge': storeAge,
        'storeHeight': storeHeight,
        'storeWeight': storeWeight,
        'storeResult': storeResult,
      };

  factory StoreDetails.fromJson(Map<String, dynamic> json) => StoreDetails(
        json['storeName'],
        json['storeAge'],
        json['storeHeight'],
        json['storeWeight'],
        json['storeResult'],
      );
}
