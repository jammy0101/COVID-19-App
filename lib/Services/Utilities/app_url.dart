//
// class AppUrl {
//
//
//   static const String baseUrl = 'https://disease.sh/v3/covid-19/all';
//   static const String worldStatesApi = baseUrl + 'all';
//   static const String countriesList = baseUrl + 'countries';
// }
class AppUrl {
  static const String baseUrl = 'https://disease.sh/v3/covid-19/';
  static const String worldStatesApi = '${baseUrl}all';
  static const String countriesList = '${baseUrl}countries';
}
