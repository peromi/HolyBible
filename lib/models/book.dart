class Book{
  int index;
  int number_of_chapters;
  String title;
  String testament;

  Book({required this.index, required this.number_of_chapters,required this.testament,required this.title});

  factory Book.fromMap(Map<String, dynamic> json) => Book(index: json['b'], number_of_chapters: json['c'], testament: json['t'], title: json['n']);
}