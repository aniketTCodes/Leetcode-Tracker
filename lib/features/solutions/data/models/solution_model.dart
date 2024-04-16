class SolutionModel{
  final String questionTitle;
  final String difficulty;
  final String problemGoal;
  final String optimization;
  final String rationale;
  final List<String> tags;

  SolutionModel({required this.questionTitle, required this.difficulty, required this.problemGoal, required this.optimization, required this.rationale,required this.tags});

  factory SolutionModel.fromFirestore(Map<String,dynamic> map){
    return SolutionModel(questionTitle: map['questionTitle'], difficulty: map['difficulty'], problemGoal: map['problemGoal'], optimization: map['optimization'], rationale: map['rationale'],tags: (map['tags'] as List<dynamic>).map((e) => e.toString()).toList());
  }

  Map<String,dynamic> toFirestore(){
    return {
      'questionTitle':questionTitle,
      'difficulty':difficulty,
      'problemGoal':problemGoal,
      'optimization':optimization,
      'rationale':rationale,
      'tags':tags
    };
  }
}