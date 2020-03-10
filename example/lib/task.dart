
class Task {


  final int day;
  final int stress;
  //final String lunch;

  //final String colorVal;
  Task(this.day,this.stress);

  Task.fromMap(Map<String, dynamic> map)
      : assert(map['day'] != null),
        assert(map['stress'] != null),

        day= map['day'],
        stress = map['stress'];
        //lunch=map['lunch'];

  @override
  String toString() => "Record<$stress:$day>";
}