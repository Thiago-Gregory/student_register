class Student {
  final int? id;
  final String name;
  final String email;

  Student({
    this.id,
    required this.name,
    required this.email,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'email': this.email,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      email: map ['email'],
    );
  }
}
