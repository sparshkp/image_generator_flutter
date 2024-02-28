part of 'prompt_bloc.dart';

@immutable
sealed class PromptState {}

final class PromptInitial extends PromptState {}


class PromptGeneratingImageLoadedState extends PromptState{}

class PromptGeneratingImageErrorState extends PromptState{}

class PromptGeneratingImageSuccessState extends PromptState{
  final Uint8List uint8list;

  PromptGeneratingImageSuccessState(this.uint8list);

  
}
