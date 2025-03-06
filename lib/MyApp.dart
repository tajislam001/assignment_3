import 'package:assignment_3/presentation/ui/screens/crud_project.dart';
import 'package:flutter/material.dart';





class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CrudProject(),

    );
  }
}