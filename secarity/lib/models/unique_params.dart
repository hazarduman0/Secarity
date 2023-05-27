import 'package:equatable/equatable.dart';

class UniqueParams extends Equatable {
  String name;
  String token;
  int? offset;
  int? pageSize;

  UniqueParams(
      {required this.name, required this.token, this.offset, this.pageSize});

  @override
  List<Object?> get props => [name, token];
}
