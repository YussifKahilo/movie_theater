abstract class DBConsumer {
  Future<void> addData(
      {required Map<String, dynamic> row, required String table});

  Future<void> updateData(
      {required Map<String, dynamic> row,
      String? where,
      required String table});

  Future<List<Map<String, dynamic>>> getData(
      {String? where, required String table});

  Future<void> deleteData({String? where, required String table});
}
