// ignore_for_file: avoid_unnecessary_containers, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_generator/features/prompts/bloc/prompt_bloc.dart';

class CreatePromptScreen extends StatefulWidget {
  const CreatePromptScreen({super.key});

  @override
  State<CreatePromptScreen> createState() => _CreatePromptScreen();
}

class _CreatePromptScreen extends State<CreatePromptScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  PromptBloc promptBloc =PromptBloc();

  @override
  void initState() {
    promptBloc.add(PromptInitialEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade900,
        title: Center(
            child: Text(
          "Generate Images",
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
      // ignore: avoid_unnecessary_containers
      body: BlocConsumer<PromptBloc, PromptState>(
        bloc: promptBloc,
        listener: (context, state) {
          
        },
        builder: (context, state) {
          switch(state.runtimeType){
            case PromptGeneratingImageLoadedState:
            return Center(child: CircularProgressIndicator());

            case PromptGeneratingImageErrorState:
            return Center(child: Text("Something went wrong!"),);
            
            case PromptGeneratingImageSuccessState:
            final successstate =state as PromptGeneratingImageSuccessState;
            return  Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Container(
                      width: double.maxFinite,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: MemoryImage(successstate.uint8list))
                  ),
                )), //box where the image will appear
                Container(
                  // place where we will give our prompts
                  height: 250,
                  padding: EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enter your prompt",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _textEditingController,
                        cursorColor: Colors.deepPurple,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.deepPurple))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                          height: 48,
                          width: double.maxFinite,
                          child: ElevatedButton.icon(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.deepPurple)),
                              onPressed: () {
                                if(_textEditingController.text.isNotEmpty){
                                  promptBloc.add(PromptEnteredEvent(prompt: _textEditingController.text));
                                }
                              },
                              icon: Icon(Icons.generating_tokens),
                              label: Text("Generate")))
                    ],
                  ),
                )
              ],
            ),
          );
          default:
          return SizedBox();
          }
        },
      ),
    );
  }
}
