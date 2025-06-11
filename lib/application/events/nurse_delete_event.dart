abstract class NurseDeleteEvent {
  NurseDeleteEvent(elderId);
}

class DeleteUser extends NurseDeleteEvent {
  final String userId;
  DeleteUser(this.userId) : super(userId);
}