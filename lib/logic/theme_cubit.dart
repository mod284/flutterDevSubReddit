import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());

  bool _isDarkTheme = false;
  bool get darkTheme => _isDarkTheme;
  void changTheme(){
    _isDarkTheme = !_isDarkTheme;

    emit(ThemeChanged());
  }
}
