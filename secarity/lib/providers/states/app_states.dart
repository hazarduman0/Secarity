import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  const AppState();

  @override
  List<Object?> get props => [];
}

class LoginStateInitial extends AppState {
  const LoginStateInitial();

  @override
  List<Object?> get props => [];
}

class LoginStateLoading extends AppState {
  const LoginStateLoading();

  @override
  List<Object?> get props => [];
}

class LoginStateSucces extends AppState {
  const LoginStateSucces();

  @override
  List<Object?> get props => [];
}

class LoginStateError extends AppState {
  final String error;

  const LoginStateError(this.error);

  @override
  List<Object?> get props => [];
}

class RegisterState extends AppState {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

class HomeState extends AppState {
  const HomeState();

  @override
  List<Object?> get props => [];
}
