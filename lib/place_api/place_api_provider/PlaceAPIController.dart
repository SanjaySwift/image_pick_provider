import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:image_pick_provider/LocationSearch/place_provider/location_provider.dart';
import 'package:image_pick_provider/place_api/APIConstant.dart';
import 'package:image_pick_provider/place_api/place_details_api.dart';
import 'package:image_pick_provider/place_api/query_autocomplete_model.dart';
import 'package:provider/provider.dart';

class PlaceAPIController extends ChangeNotifier {

  bool isLoading = true;
  bool isLoadingAutoSearchPlace = true;
  Geometry? geometry;
  List<Predictions> predictions=[];



  Future<dynamic> autoSearchPlaceAPI({required String searchAddress}) async {
    isLoadingAutoSearchPlace=true;
    notifyListeners();
    try {
      final response = await http.get(APIConstant.placeAutoSearch(searchAddress: searchAddress));
      const utf8Decoder = Utf8Decoder(allowMalformed: true);
      final decodedBytes = utf8Decoder.convert(response.bodyBytes);
      Map<String, dynamic> responseBody = json.decode(decodedBytes);
      if (response.statusCode == 200) {
        QueryAutocompleteModel packagesResponse = QueryAutocompleteModel.fromJson(responseBody);
        predictions = packagesResponse.predictions!;
        isLoadingAutoSearchPlace=false;
        notifyListeners();
      }
    } on TimeoutException catch (e) {
      isLoadingAutoSearchPlace = false;
      notifyListeners();
    } on SocketException catch (e) {
      isLoadingAutoSearchPlace = false;
      notifyListeners();
    } on Error catch (e) {
      isLoadingAutoSearchPlace = false;
      notifyListeners();
    } catch (e) {
      isLoadingAutoSearchPlace = false;
      notifyListeners();
    }
    return null;
  }

  Future<PlaceDetailsApi?> placeAPI({required String placeId}) async {
    try {
      EasyLoading.show(status: "Please wait...", dismissOnTap: false, maskType: EasyLoadingMaskType.black);
      final response = await http.get(APIConstant.placeAPi(placeId: placeId));
      const utf8Decoder = Utf8Decoder(allowMalformed: true);
      final decodedBytes = utf8Decoder.convert(response.bodyBytes);
      Map<String, dynamic> responseBody = json.decode(decodedBytes);
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        return PlaceDetailsApi.fromJson(responseBody);
      }
    } on TimeoutException catch (e) {
      EasyLoading.dismiss();
      notifyListeners();
    } on SocketException catch (e) {
      EasyLoading.dismiss();
      notifyListeners();
    } on Error catch (e) {
      EasyLoading.dismiss();
      notifyListeners();
    } catch (e) {
      EasyLoading.dismiss();
      notifyListeners();
    }
    return null;
  }

}
