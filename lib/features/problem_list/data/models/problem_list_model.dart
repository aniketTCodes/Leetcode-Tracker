class ProblemListModel {
  final String title;
  final String description;
  final String createdOn;
  final int solved;
  final int total;

  ProblemListModel(
      {required this.title,
      required this.description,
      required this.createdOn,
      required this.solved,
      required this.total});

  factory ProblemListModel.fromFirestore(Map<String, dynamic> map) {
    return ProblemListModel(
        title: map['title'],
        description: map['description'],
        createdOn: map['createdOn'],
        solved: map['solved'],
        total: map['total']);
  }

  Map<String,dynamic> toFirestore(){
    return {
      'title':title,
      'description':description,
      'createdOn':createdOn,
      'solved':solved,
      'total':total
    };
  }
}
