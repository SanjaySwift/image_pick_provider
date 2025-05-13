
class APIConstant {


  static Uri placeAPi({required String placeId}) {
    final getAllOfferUri = Uri.parse("https://maps.googleapis.com/maps/api/place/details/json").replace(
        queryParameters: {
          'place_id': placeId,
          'key': "AIzaSyDtpNz8PDcYLXCE5CRW3z5evNo0mFEfzCE"
        });
    return getAllOfferUri;
  }

  static Uri placeAutoSearch({required String searchAddress}) {
    final getAllOfferUri = Uri.parse("https://maps.googleapis.com/maps/api/place/queryautocomplete/json").replace(
        queryParameters: {
          'input': searchAddress,
          'key': "AIzaSyDtpNz8PDcYLXCE5CRW3z5evNo0mFEfzCE"
        });
    return getAllOfferUri;
  }


}