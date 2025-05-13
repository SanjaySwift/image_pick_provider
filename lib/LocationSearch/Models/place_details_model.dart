class PlaceDetailsModel {
  PlaceDetailsModel({
      List<dynamic>? htmlAttributions, 
      Result? result, 
      String? status,}){
    _htmlAttributions = htmlAttributions;
    _result = result;
    _status = status;
}

  PlaceDetailsModel.fromJson(dynamic json) {
    if (json['html_attributions'] != null) {
      _htmlAttributions = [];
      json['html_attributions'].forEach((v) {
        _htmlAttributions?.add([]);
      });
    }
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
    _status = json['status'];
  }
  List<dynamic>? _htmlAttributions;
  Result? _result;
  String? _status;
PlaceDetailsModel copyWith({  List<dynamic>? htmlAttributions,
  Result? result,
  String? status,
}) => PlaceDetailsModel(  htmlAttributions: htmlAttributions ?? _htmlAttributions,
  result: result ?? _result,
  status: status ?? _status,
);
  List<dynamic>? get htmlAttributions => _htmlAttributions;
  Result? get result => _result;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_htmlAttributions != null) {
      map['html_attributions'] = _htmlAttributions?.map((v) => v.toJson()).toList();
    }
    if (_result != null) {
      map['result'] = _result?.toJson();
    }
    map['status'] = _status;
    return map;
  }

}

class Result {
  Result({
      List<AddressComponents>? addressComponents, 
      String? adrAddress, 
      String? businessStatus, 
      String? formattedAddress, 
      String? formattedPhoneNumber, 
      Geometry? geometry, 
      String? icon, 
      String? iconBackgroundColor, 
      String? iconMaskBaseUri, 
      String? internationalPhoneNumber, 
      String? name, 
      List<Photos>? photos, 
      String? placeId, 
      PlusCode? plusCode, 
      num? rating, 
      String? reference, 
      List<Reviews>? reviews, 
      List<String>? types, 
      String? url, 
      num? userRatingsTotal, 
      num? utcOffset, 
      String? vicinity, 
      String? website,}){
    _addressComponents = addressComponents;
    _adrAddress = adrAddress;
    _businessStatus = businessStatus;
    _formattedAddress = formattedAddress;
    _formattedPhoneNumber = formattedPhoneNumber;
    _geometry = geometry;
    _icon = icon;
    _iconBackgroundColor = iconBackgroundColor;
    _iconMaskBaseUri = iconMaskBaseUri;
    _internationalPhoneNumber = internationalPhoneNumber;
    _name = name;
    _photos = photos;
    _placeId = placeId;
    _plusCode = plusCode;
    _rating = rating;
    _reference = reference;
    _reviews = reviews;
    _types = types;
    _url = url;
    _userRatingsTotal = userRatingsTotal;
    _utcOffset = utcOffset;
    _vicinity = vicinity;
    _website = website;
}

  Result.fromJson(dynamic json) {
    if (json['address_components'] != null) {
      _addressComponents = [];
      json['address_components'].forEach((v) {
        _addressComponents?.add(AddressComponents.fromJson(v));
      });
    }
    _adrAddress = json['adr_address'];
    _businessStatus = json['business_status'];
    _formattedAddress = json['formatted_address'];
    _formattedPhoneNumber = json['formatted_phone_number'];
    _geometry = json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
    _icon = json['icon'];
    _iconBackgroundColor = json['icon_background_color'];
    _iconMaskBaseUri = json['icon_mask_base_uri'];
    _internationalPhoneNumber = json['international_phone_number'];
    _name = json['name'];
    if (json['photos'] != null) {
      _photos = [];
      json['photos'].forEach((v) {
        _photos?.add(Photos.fromJson(v));
      });
    }
    _placeId = json['place_id'];
    _plusCode = json['plus_code'] != null ? PlusCode.fromJson(json['plus_code']) : null;
    _rating = json['rating'];
    _reference = json['reference'];
    if (json['reviews'] != null) {
      _reviews = [];
      json['reviews'].forEach((v) {
        _reviews?.add(Reviews.fromJson(v));
      });
    }
    _types = json['types'] != null ? json['types'].cast<String>() : [];
    _url = json['url'];
    _userRatingsTotal = json['user_ratings_total'];
    _utcOffset = json['utc_offset'];
    _vicinity = json['vicinity'];
    _website = json['website'];
  }
  List<AddressComponents>? _addressComponents;
  String? _adrAddress;
  String? _businessStatus;
  String? _formattedAddress;
  String? _formattedPhoneNumber;
  Geometry? _geometry;
  String? _icon;
  String? _iconBackgroundColor;
  String? _iconMaskBaseUri;
  String? _internationalPhoneNumber;
  String? _name;
  List<Photos>? _photos;
  String? _placeId;
  PlusCode? _plusCode;
  num? _rating;
  String? _reference;
  List<Reviews>? _reviews;
  List<String>? _types;
  String? _url;
  num? _userRatingsTotal;
  num? _utcOffset;
  String? _vicinity;
  String? _website;
Result copyWith({  List<AddressComponents>? addressComponents,
  String? adrAddress,
  String? businessStatus,
  String? formattedAddress,
  String? formattedPhoneNumber,
  Geometry? geometry,
  String? icon,
  String? iconBackgroundColor,
  String? iconMaskBaseUri,
  String? internationalPhoneNumber,
  String? name,
  List<Photos>? photos,
  String? placeId,
  PlusCode? plusCode,
  num? rating,
  String? reference,
  List<Reviews>? reviews,
  List<String>? types,
  String? url,
  num? userRatingsTotal,
  num? utcOffset,
  String? vicinity,
  String? website,
}) => Result(  addressComponents: addressComponents ?? _addressComponents,
  adrAddress: adrAddress ?? _adrAddress,
  businessStatus: businessStatus ?? _businessStatus,
  formattedAddress: formattedAddress ?? _formattedAddress,
  formattedPhoneNumber: formattedPhoneNumber ?? _formattedPhoneNumber,
  geometry: geometry ?? _geometry,
  icon: icon ?? _icon,
  iconBackgroundColor: iconBackgroundColor ?? _iconBackgroundColor,
  iconMaskBaseUri: iconMaskBaseUri ?? _iconMaskBaseUri,
  internationalPhoneNumber: internationalPhoneNumber ?? _internationalPhoneNumber,
  name: name ?? _name,
  photos: photos ?? _photos,
  placeId: placeId ?? _placeId,
  plusCode: plusCode ?? _plusCode,
  rating: rating ?? _rating,
  reference: reference ?? _reference,
  reviews: reviews ?? _reviews,
  types: types ?? _types,
  url: url ?? _url,
  userRatingsTotal: userRatingsTotal ?? _userRatingsTotal,
  utcOffset: utcOffset ?? _utcOffset,
  vicinity: vicinity ?? _vicinity,
  website: website ?? _website,
);
  List<AddressComponents>? get addressComponents => _addressComponents;
  String? get adrAddress => _adrAddress;
  String? get businessStatus => _businessStatus;
  String? get formattedAddress => _formattedAddress;
  String? get formattedPhoneNumber => _formattedPhoneNumber;
  Geometry? get geometry => _geometry;
  String? get icon => _icon;
  String? get iconBackgroundColor => _iconBackgroundColor;
  String? get iconMaskBaseUri => _iconMaskBaseUri;
  String? get internationalPhoneNumber => _internationalPhoneNumber;
  String? get name => _name;
  List<Photos>? get photos => _photos;
  String? get placeId => _placeId;
  PlusCode? get plusCode => _plusCode;
  num? get rating => _rating;
  String? get reference => _reference;
  List<Reviews>? get reviews => _reviews;
  List<String>? get types => _types;
  String? get url => _url;
  num? get userRatingsTotal => _userRatingsTotal;
  num? get utcOffset => _utcOffset;
  String? get vicinity => _vicinity;
  String? get website => _website;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_addressComponents != null) {
      map['address_components'] = _addressComponents?.map((v) => v.toJson()).toList();
    }
    map['adr_address'] = _adrAddress;
    map['business_status'] = _businessStatus;
    map['formatted_address'] = _formattedAddress;
    map['formatted_phone_number'] = _formattedPhoneNumber;
    if (_geometry != null) {
      map['geometry'] = _geometry?.toJson();
    }
    map['icon'] = _icon;
    map['icon_background_color'] = _iconBackgroundColor;
    map['icon_mask_base_uri'] = _iconMaskBaseUri;
    map['international_phone_number'] = _internationalPhoneNumber;
    map['name'] = _name;
    if (_photos != null) {
      map['photos'] = _photos?.map((v) => v.toJson()).toList();
    }
    map['place_id'] = _placeId;
    if (_plusCode != null) {
      map['plus_code'] = _plusCode?.toJson();
    }
    map['rating'] = _rating;
    map['reference'] = _reference;
    if (_reviews != null) {
      map['reviews'] = _reviews?.map((v) => v.toJson()).toList();
    }
    map['types'] = _types;
    map['url'] = _url;
    map['user_ratings_total'] = _userRatingsTotal;
    map['utc_offset'] = _utcOffset;
    map['vicinity'] = _vicinity;
    map['website'] = _website;
    return map;
  }

}

class Reviews {
  Reviews({
      String? authorName, 
      String? authorUrl, 
      String? profilePhotoUrl, 
      num? rating, 
      String? relativeTimeDescription, 
      String? text, 
      num? time, 
      bool? translated,}){
    _authorName = authorName;
    _authorUrl = authorUrl;
    _profilePhotoUrl = profilePhotoUrl;
    _rating = rating;
    _relativeTimeDescription = relativeTimeDescription;
    _text = text;
    _time = time;
    _translated = translated;
}

  Reviews.fromJson(dynamic json) {
    _authorName = json['author_name'];
    _authorUrl = json['author_url'];
    _profilePhotoUrl = json['profile_photo_url'];
    _rating = json['rating'];
    _relativeTimeDescription = json['relative_time_description'];
    _text = json['text'];
    _time = json['time'];
    _translated = json['translated'];
  }
  String? _authorName;
  String? _authorUrl;
  String? _profilePhotoUrl;
  num? _rating;
  String? _relativeTimeDescription;
  String? _text;
  num? _time;
  bool? _translated;
Reviews copyWith({  String? authorName,
  String? authorUrl,
  String? profilePhotoUrl,
  num? rating,
  String? relativeTimeDescription,
  String? text,
  num? time,
  bool? translated,
}) => Reviews(  authorName: authorName ?? _authorName,
  authorUrl: authorUrl ?? _authorUrl,
  profilePhotoUrl: profilePhotoUrl ?? _profilePhotoUrl,
  rating: rating ?? _rating,
  relativeTimeDescription: relativeTimeDescription ?? _relativeTimeDescription,
  text: text ?? _text,
  time: time ?? _time,
  translated: translated ?? _translated,
);
  String? get authorName => _authorName;
  String? get authorUrl => _authorUrl;
  String? get profilePhotoUrl => _profilePhotoUrl;
  num? get rating => _rating;
  String? get relativeTimeDescription => _relativeTimeDescription;
  String? get text => _text;
  num? get time => _time;
  bool? get translated => _translated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['author_name'] = _authorName;
    map['author_url'] = _authorUrl;
    map['profile_photo_url'] = _profilePhotoUrl;
    map['rating'] = _rating;
    map['relative_time_description'] = _relativeTimeDescription;
    map['text'] = _text;
    map['time'] = _time;
    map['translated'] = _translated;
    return map;
  }

}

class PlusCode {
  PlusCode({
      String? compoundCode, 
      String? globalCode,}){
    _compoundCode = compoundCode;
    _globalCode = globalCode;
}

  PlusCode.fromJson(dynamic json) {
    _compoundCode = json['compound_code'];
    _globalCode = json['global_code'];
  }
  String? _compoundCode;
  String? _globalCode;
PlusCode copyWith({  String? compoundCode,
  String? globalCode,
}) => PlusCode(  compoundCode: compoundCode ?? _compoundCode,
  globalCode: globalCode ?? _globalCode,
);
  String? get compoundCode => _compoundCode;
  String? get globalCode => _globalCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['compound_code'] = _compoundCode;
    map['global_code'] = _globalCode;
    return map;
  }

}

class Photos {
  Photos({
      num? height, 
      List<String>? htmlAttributions, 
      String? photoReference, 
      num? width,}){
    _height = height;
    _htmlAttributions = htmlAttributions;
    _photoReference = photoReference;
    _width = width;
}

  Photos.fromJson(dynamic json) {
    _height = json['height'];
    _htmlAttributions = json['html_attributions'] != null ? json['html_attributions'].cast<String>() : [];
    _photoReference = json['photo_reference'];
    _width = json['width'];
  }
  num? _height;
  List<String>? _htmlAttributions;
  String? _photoReference;
  num? _width;
Photos copyWith({  num? height,
  List<String>? htmlAttributions,
  String? photoReference,
  num? width,
}) => Photos(  height: height ?? _height,
  htmlAttributions: htmlAttributions ?? _htmlAttributions,
  photoReference: photoReference ?? _photoReference,
  width: width ?? _width,
);
  num? get height => _height;
  List<String>? get htmlAttributions => _htmlAttributions;
  String? get photoReference => _photoReference;
  num? get width => _width;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['height'] = _height;
    map['html_attributions'] = _htmlAttributions;
    map['photo_reference'] = _photoReference;
    map['width'] = _width;
    return map;
  }

}

class Geometry {
  Geometry({
      Location? location, 
      Viewport? viewport,}){
    _location = location;
    _viewport = viewport;
}

  Geometry.fromJson(dynamic json) {
    _location = json['location'] != null ? Location.fromJson(json['location']) : null;
    _viewport = json['viewport'] != null ? Viewport.fromJson(json['viewport']) : null;
  }
  Location? _location;
  Viewport? _viewport;
Geometry copyWith({  Location? location,
  Viewport? viewport,
}) => Geometry(  location: location ?? _location,
  viewport: viewport ?? _viewport,
);
  Location? get location => _location;
  Viewport? get viewport => _viewport;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_location != null) {
      map['location'] = _location?.toJson();
    }
    if (_viewport != null) {
      map['viewport'] = _viewport?.toJson();
    }
    return map;
  }

}

class Viewport {
  Viewport({
      Northeast? northeast, 
      Southwest? southwest,}){
    _northeast = northeast;
    _southwest = southwest;
}

  Viewport.fromJson(dynamic json) {
    _northeast = json['northeast'] != null ? Northeast.fromJson(json['northeast']) : null;
    _southwest = json['southwest'] != null ? Southwest.fromJson(json['southwest']) : null;
  }
  Northeast? _northeast;
  Southwest? _southwest;
Viewport copyWith({  Northeast? northeast,
  Southwest? southwest,
}) => Viewport(  northeast: northeast ?? _northeast,
  southwest: southwest ?? _southwest,
);
  Northeast? get northeast => _northeast;
  Southwest? get southwest => _southwest;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_northeast != null) {
      map['northeast'] = _northeast?.toJson();
    }
    if (_southwest != null) {
      map['southwest'] = _southwest?.toJson();
    }
    return map;
  }

}

class Southwest {
  Southwest({
      num? lat, 
      num? lng,}){
    _lat = lat;
    _lng = lng;
}

  Southwest.fromJson(dynamic json) {
    _lat = json['lat'];
    _lng = json['lng'];
  }
  num? _lat;
  num? _lng;
Southwest copyWith({  num? lat,
  num? lng,
}) => Southwest(  lat: lat ?? _lat,
  lng: lng ?? _lng,
);
  num? get lat => _lat;
  num? get lng => _lng;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = _lat;
    map['lng'] = _lng;
    return map;
  }

}

class Northeast {
  Northeast({
      num? lat, 
      num? lng,}){
    _lat = lat;
    _lng = lng;
}

  Northeast.fromJson(dynamic json) {
    _lat = json['lat'];
    _lng = json['lng'];
  }
  num? _lat;
  num? _lng;
Northeast copyWith({  num? lat,
  num? lng,
}) => Northeast(  lat: lat ?? _lat,
  lng: lng ?? _lng,
);
  num? get lat => _lat;
  num? get lng => _lng;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = _lat;
    map['lng'] = _lng;
    return map;
  }

}

class Location {
  Location({
      num? lat, 
      num? lng,}){
    _lat = lat;
    _lng = lng;
}

  Location.fromJson(dynamic json) {
    _lat = json['lat'];
    _lng = json['lng'];
  }
  num? _lat;
  num? _lng;
Location copyWith({  num? lat,
  num? lng,
}) => Location(  lat: lat ?? _lat,
  lng: lng ?? _lng,
);
  num? get lat => _lat;
  num? get lng => _lng;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = _lat;
    map['lng'] = _lng;
    return map;
  }

}

class AddressComponents {
  AddressComponents({
      String? longName, 
      String? shortName, 
      List<String>? types,}){
    _longName = longName;
    _shortName = shortName;
    _types = types;
}

  AddressComponents.fromJson(dynamic json) {
    _longName = json['long_name'];
    _shortName = json['short_name'];
    _types = json['types'] != null ? json['types'].cast<String>() : [];
  }
  String? _longName;
  String? _shortName;
  List<String>? _types;
AddressComponents copyWith({  String? longName,
  String? shortName,
  List<String>? types,
}) => AddressComponents(  longName: longName ?? _longName,
  shortName: shortName ?? _shortName,
  types: types ?? _types,
);
  String? get longName => _longName;
  String? get shortName => _shortName;
  List<String>? get types => _types;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['long_name'] = _longName;
    map['short_name'] = _shortName;
    map['types'] = _types;
    return map;
  }

}