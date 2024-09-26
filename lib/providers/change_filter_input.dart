import 'package:flutter_riverpod/flutter_riverpod.dart';


class FilterInputNotifier extends StateNotifier<int> {
  FilterInputNotifier() : super(0);

  void filterInputCategory(){
    state = 0;
  }
  void filterInputName(){
    state = 1;
  }
  void filterInputDate(){
    state = 2;
  }
  void filterInputHeure(){
    state = 3;
  }
}


final filterInputProvider = StateNotifierProvider<FilterInputNotifier, int>((ref){
  return FilterInputNotifier();
});