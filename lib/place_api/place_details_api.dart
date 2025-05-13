class PlaceDetailsApi {
  PlaceDetailsApi({
      List<dynamic>? htmlAttributions, 
      Result? result, 
      String? status,}){
    _htmlAttributions = htmlAttributions;
    _result = result;
    _status = status;
}

  PlaceDetailsApi.fromJson(dynamic json) {
    if (json['html_attributions'] != null) {
      _htmlAttributions = [];
      json['html_attributions'].forEach((v) {
        _htmlAttributions?.add("");
      });
    }
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
    _status = json['status'];
  }
  List<dynamic>? _htmlAttributions;
  Result? _result;
  String? _status;
PlaceDetailsApi copyWith({  List<dynamic>? htmlAttributions,
  Result? result,
  String? status,
}) => PlaceDetailsApi(  htmlAttributions: htmlAttributions ?? _htmlAttributions,
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
      String? formattedAddress, 
      Geometry? geometry, 
      String? icon, 
      String? iconBackgroundColor, 
      String? iconMaskBaseUri, 
      String? name, 
      List<Photos>? photos, 
      String? placeId, 
      String? reference, 
      List<String>? types, 
      String? url, 
      num? utcOffset, 
      String? vicinity,}){
    _addressComponents = addressComponents;
    _adrAddress = adrAddress;
    _formattedAddress = formattedAddress;
    _geometry = geometry;
    _icon = icon;
    _iconBackgroundColor = iconBackgroundColor;
    _iconMaskBaseUri = iconMaskBaseUri;
    _name = name;
    _photos = photos;
    _placeId = placeId;
    _reference = reference;
    _types = types;
    _url = url;
    _utcOffset = utcOffset;
    _vicinity = vicinity;
}

  Result.fromJson(dynamic json) {
    if (json['address_components'] != null) {
      _addressComponents = [];
      json['address_components'].forEach((v) {
        _addressComponents?.add(AddressComponents.fromJson(v));
      });
    }
    _adrAddress = json['adr_address'];
    _formattedAddress = json['formatted_address'];
    _geometry = json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
    _icon = json['icon'];
    _iconBackgroundColor = json['icon_background_color'];
    _iconMaskBaseUri = json['icon_mask_base_uri'];
    _name = json['name'];
    if (json['photos'] != null) {
      _photos = [];
      json['photos'].forEach((v) {
        _photos?.add(Photos.fromJson(v));
      });
    }
    _placeId = json['place_id'];
    _reference = json['reference'];
    _types = json['types'] != null ? json['types'].cast<String>() : [];
    _url = json['url'];
    _utcOffset = json['utc_offset'];
    _vicinity = json['vicinity'];
  }
  List<AddressComponents>? _addressComponents;
  String? _adrAddress;
  String? _formattedAddress;
  Geometry? _geometry;
  String? _icon;
  String? _iconBackgroundColor;
  String? _iconMaskBaseUri;
  String? _name;
  List<Photos>? _photos;
  String? _placeId;
  String? _reference;
  List<String>? _types;
  String? _url;
  num? _utcOffset;
  String? _vicinity;
Result copyWith({  List<AddressComponents>? addressComponents,
  String? adrAddress,
  String? formattedAddress,
  Geometry? geometry,
  String? icon,
  String? iconBackgroundColor,
  String? iconMaskBaseUri,
  String? name,
  List<Photos>? photos,
  String? placeId,
  String? reference,
  List<String>? types,
  String? url,
  num? utcOffset,
  String? vicinity,
}) => Result(  addressComponents: addressComponents ?? _addressComponents,
  adrAddress: adrAddress ?? _adrAddress,
  formattedAddress: formattedAddress ?? _formattedAddress,
  geometry: geometry ?? _geometry,
  icon: icon ?? _icon,
  iconBackgroundColor: iconBackgroundColor ?? _iconBackgroundColor,
  iconMaskBaseUri: iconMaskBaseUri ?? _iconMaskBaseUri,
  name: name ?? _name,
  photos: photos ?? _photos,
  placeId: placeId ?? _placeId,
  reference: reference ?? _reference,
  types: types ?? _types,
  url: url ?? _url,
  utcOffset: utcOffset ?? _utcOffset,
  vicinity: vicinity ?? _vicinity,
);
  List<AddressComponents>? get addressComponents => _addressComponents;
  String? get adrAddress => _adrAddress;
  String? get formattedAddress => _formattedAddress;
  Geometry? get geometry => _geometry;
  String? get icon => _icon;
  String? get iconBackgroundColor => _iconBackgroundColor;
  String? get iconMaskBaseUri => _iconMaskBaseUri;
  String? get name => _name;
  List<Photos>? get photos => _photos;
  String? get placeId => _placeId;
  String? get reference => _reference;
  List<String>? get types => _types;
  String? get url => _url;
  num? get utcOffset => _utcOffset;
  String? get vicinity => _vicinity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_addressComponents != null) {
      map['address_components'] = _addressComponents?.map((v) => v.toJson()).toList();
    }
    map['adr_address'] = _adrAddress;
    map['formatted_address'] = _formattedAddress;
    if (_geometry != null) {
      map['geometry'] = _geometry?.toJson();
    }
    map['icon'] = _icon;
    map['icon_background_color'] = _iconBackgroundColor;
    map['icon_mask_base_uri'] = _iconMaskBaseUri;
    map['name'] = _name;
    if (_photos != null) {
      map['photos'] = _photos?.map((v) => v.toJson()).toList();
    }
    map['place_id'] = _placeId;
    map['reference'] = _reference;
    map['types'] = _types;
    map['url'] = _url;
    map['utc_offset'] = _utcOffset;
    map['vicinity'] = _vicinity;
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