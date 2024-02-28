// ignore_for_file: unnecessary_string_escapes

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_generator/features/prompts/repos/prompt_repo.dart';

part 'prompt_event.dart';
part 'prompt_state.dart';

class PromptBloc extends Bloc<PromptEvent, PromptState> {
  PromptBloc() : super(PromptInitial()) {
   on<PromptInitialEvent>(promptInitialEvent);
   on<PromptEnteredEvent>(promptEnteredEvent);
  }

  FutureOr<void> promptEnteredEvent(PromptEnteredEvent event, Emitter<PromptState> emit) async{
    emit(PromptGeneratingImageLoadedState());
    Uint8List? bytes=await PromptRepo.generateImage(event.prompt);
    if(bytes!=null){
      emit(PromptGeneratingImageSuccessState(Uint8List.fromList(bytes)));
    }
    else{
      emit(PromptGeneratingImageErrorState());
    }
  }

  FutureOr<void> promptInitialEvent(PromptInitialEvent event, Emitter<PromptState> emit) async{
    ByteData data= await rootBundle.load('assets/castle.png');
    Uint8List bytes =data.buffer.asUint8List();
   // Uint8List bytes = await File('C:/Users/Sparsh Kapoor/OneDrive/Desktop/Flutter/image_generator/assets/castle.png').readAsBytes();
    emit(PromptGeneratingImageSuccessState(bytes));
  }
}
