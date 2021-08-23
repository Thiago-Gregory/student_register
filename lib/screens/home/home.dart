import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:student_register/models/student.dart';
import 'package:student_register/repositories/students/studentdb_repository.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _registerController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cadastro de Alunos",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Matrícula do Aluno",
                  hintText: "Somente números",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                controller: _registerController,
                enabled: isEdit ? true : false,
              ),
              SizedBox(height: 5),
              TextField(
                decoration: InputDecoration(
                  labelText: "Nome do Aluno",
                  hintText: "Somente texto",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.name,
                controller: _nameController,
              ),
              SizedBox(height: 5),
              TextField(
                decoration: InputDecoration(
                  labelText: "E-mail do Aluno",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              Row(
                children: [
                  Switch(
                    value: isEdit,
                    onChanged: (status){
                      setState(() {
                        isEdit = !isEdit;
                      });
                    },
                  ),
                  Text(
                    "Editar",
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: isEdit ? null : ((){
                      saveRegister();
                    }),
                    child: Text("Cadastrar"),
                  ),
                  SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: saveRegister,
                    child: Text("Editar"),
                  ),
                ],
              )
            ],
          )
        ),
      ),
    );
  }

  void saveRegister() async {
    final String name = _nameController.text;
    final String email = _emailController.text;
    String message;

    if(!EmailValidator.validate(email)){
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "Mensagem do sistema",
          ),
          content: Text(
            "E-mail inválido!!!",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "OK"
              ),
            )
          ],
        )
      );
    }
    else {
      Student student = Student(
        name: name,
        email: email
      );

      var repository = StudentDBRepository();
      int result = await repository.insert(student);

      if(result != 0) {
        message = "O aluno $name foi cadastrado com sucesso.";
      }
      else {
        message = "Não foi possível cadastrar o aluno $name";
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "Mensagem do sistema",
          ),
          content: Text(
            message,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "OK"
              ),
            )
          ],
        )
      );
    }
  }
}
