import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'slider_state.dart';

class SliderCubit extends Cubit<int> {
  SliderCubit() : super(0);

  position(int pos) => emit(pos);
}
