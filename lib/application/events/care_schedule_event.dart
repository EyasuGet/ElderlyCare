abstract class CareScheduleEvent {}

class CareScheduleEventOnCarePlanChange extends CareScheduleEvent {
  final String carePlan;
  CareScheduleEventOnCarePlanChange(this.carePlan);
}

class CareScheduleEventOnFrequencyChange extends CareScheduleEvent {
  final String frequency;
  CareScheduleEventOnFrequencyChange(this.frequency);
}

class CareScheduleEventOnStartTimeChange extends CareScheduleEvent {
  final String startTime;
  CareScheduleEventOnStartTimeChange(this.startTime);
}

class CareScheduleEventOnEndTimeChange extends CareScheduleEvent {
  final String endTime;
  CareScheduleEventOnEndTimeChange(this.endTime);
}

class CareScheduleEventOnPostToChange extends CareScheduleEvent {
  final String postTo;
  CareScheduleEventOnPostToChange(this.postTo);
}

class CareScheduleEventOnSubmit extends CareScheduleEvent {}