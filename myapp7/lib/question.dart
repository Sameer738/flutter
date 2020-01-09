class Question {
  int id;
  String question, op1, op2, op3, op4, ans, language;

  Question(
      {this.id,
      this.question,
      this.op1,
      this.op2,
      this.op3,
      this.op4,
      this.ans,
      this.language});

  factory Question.fromJson(Map<String, dynamic> json){
    return new Question(
      id: json['id'],
      question : json['question'],
        op1 : json['op1'],
        op2 : json['op2'],
        op3 : json['op3'],
        op4 : json['op4'],
        ans : json['ans'],
        language : json['language']
    );
  }

  // Map<String, dynamic> toJson() => {
  //       'ques': question,
  //       'op1': op1,
  //       'op2': op2,
  //       'op3': op3,
  //       'op4': op4,
  //       'ans': ans,
  //       'language': language,
  //     };
}
