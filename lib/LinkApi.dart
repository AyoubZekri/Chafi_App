class Applink {
  static const String server = "http://192.168.221.133:8000/api";
  static const String image = "http://192.168.221.133:8000/Storage/";

  //  =============================Auth============================== //

  static const String logingoogle = "$server/google-login";
  static const String login = "$server/user/login";

  static const String updateuser = "$server/user/update";

  static const String logout = "$server/logout";

  static const String institutionShow = "$server/user/Institution/Show";
  static const String institutionShowNologin = "$server/institution/Show";
  static const String institutionShowisReade =
      "$server/isread/read_institutions";

  static const String taxAndAppShwo = "$server/user/TaxsAndApps/Show";
  static const String taxAndAppShwoNologin = "$server/TaxAndApp/Show";
  static const String taxAndAppShwoisReade =
      "$server/isread/read_taxs_and_apps";

  static const String differentShow = "$server/user/Different/Show";
  static const String differentShowNologin = "$server/Different/Show";
  static const String differentShowisReade = "$server/isread/read_differents";

  static const String activitysShwo = "$server/Activitys/Show";

  static const String nataireActivitysShwo = "$server/NataireActivitys/Show";

  static const String lawShow = "$server/Law/Show";

  static const String notificationUserShow = "$server/NotificationUser/Show";
  static const String notificationUserdelete =
      "$server/NotificationUser/Delete";
  static const String notificationUserIsRead =
      "$server/NotificationUser/IsRead";
  static const String mypathadd = "$server/Mypath/add";
  static const String mypathedit = "$server/Mypath/Edit";
  static const String mypathShow = "$server/Mypath/Show";
  static const String mypathdelete = "$server/Mypath/Delete";

  static const String institutionadd = "$server/institution/add";

  static const String nataireActivitysadd = "$server/NataireActivitys/add";

  static const String activitysadd = "$server/Activitys/add";

  static const String differentadd = "$server/Different/add";

  static const String appointmentsShow = "$server/Appointments/Show";
  static const String appointmentsadd = "$server/Appointments/add";

  static const String notificationShwo = "$server/Notification/Show";
  static const String notificationadd = "$server/Notification/add";

  static const String postShow = "$server/Post/Show";
  static const String postadd = "$server/Post/add";

  static const String categoryShow = "$server/Category/Show";
  static const String categoryadd = "$server/Category/add";

  static const String taxAndAppadd = "$server/TaxAndApp/add";
}
