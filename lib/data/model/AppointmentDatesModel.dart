class AppointmentDatesModel {
  final int id;
  final int appointmentId;
  final String? appointmentDate;
  final String? alertDate;

  AppointmentDatesModel({
    required this.id,
    required this.appointmentId,
    this.appointmentDate,
    this.alertDate,
  });

  factory AppointmentDatesModel.fromJson(Map<String, dynamic> json) {
    return AppointmentDatesModel(
      id: json['id'],
      appointmentId: json['appointment_id'],
      appointmentDate: json['appointment_date'],
      alertDate: json['alert_date'],
    );
  }
}
