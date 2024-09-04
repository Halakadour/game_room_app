class IdManager {
  
  static String generateId() {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    return id;
  }
}
