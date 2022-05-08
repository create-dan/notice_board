// Used while creating notice
class NoticeModel1 {
  static String? title;
  static String? description;
  static String? subject;
  static String? year;
  static String? branch;
  static String? owner;
  static String? noticeType;
  static String? imageUrl;
  static String? pdfUrl;
}

// Used while displaying the notice
class NoticeModel2 {
  String? title;
  String? description;
  String? subject;
  String? noticeType;
  String? imageUrl;
  String? pdfUrl;
  List<String> tags = [];
  String? createdAt;

  NoticeModel2({
    required this.title,
    required this.description,
    required this.subject,
    required this.noticeType,
    required this.imageUrl,
    required this.pdfUrl,
    required this.createdAt,
    required this.tags,
  });
}
