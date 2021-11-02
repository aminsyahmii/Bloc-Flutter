import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'input/input.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: BlocProvider(
          create: (context) => InputCubit(),
          child: MyHomePage(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String word = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capitalise an Input'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<InputCubit, String>(
                  bloc: context.read<InputCubit>(),
                  builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'type here: ',
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  context.read<InputCubit>().capatalise(state);
                                },
                                icon: const Icon(Icons.check_circle_rounded),
                              ),
                            ),
                            onChanged: (String? value) {
                              state = value!;
                            },
                          ),
                        )
                      ],
                    );
                  }),
              BlocBuilder(
                  bloc: context.read<InputCubit>(),
                  builder: (context, state) {
                    return Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        color: Colors.green,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text('Capitalised: $state')],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
