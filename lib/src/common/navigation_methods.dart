import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void pushAndReplaceTopage(BuildContext context, page){
  // Navigator.pushReplacementNamed(context, page);
  final route = MaterialPageRoute(
    builder: (context) => page
  );
  Navigator.pushReplacement(context, route);
  
}
void pushTopage(BuildContext context, page){

  final route = MaterialPageRoute(
    builder: (context) => page
  );
  Navigator.push(context, route);
  
}

void pushTopageBloc(BuildContext context, page, BlocBase bloc){

  final route = MaterialPageRoute(
    builder: (context) => BlocProvider.value(value: bloc, child: page,)
  );
  Navigator.push(context, route);
  
}