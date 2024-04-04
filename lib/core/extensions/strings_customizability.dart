extension StringsCustomizability on String {
  String placeId(String id) => replaceFirst('&id&', id);
}
