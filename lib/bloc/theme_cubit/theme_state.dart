part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  ThemeState(this.darkmode);

  bool darkmode;

  @override
  List<Object> get props => [darkmode];
}

// class ThemeInitial extends ThemeState {}
