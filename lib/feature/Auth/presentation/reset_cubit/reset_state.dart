abstract class ResetState {}

class ResetInitial extends ResetState {}
class ResetLoading extends ResetState {}
class ResetSuccess extends ResetState {}
class ResetLinkSent extends ResetState {}
class PasswordChanged extends ResetState {}


class ResetError extends ResetState {
  final String message;
  ResetError(this.message);
}
