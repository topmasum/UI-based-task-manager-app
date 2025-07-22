class Url {
  static const String baseurl = 'http://35.73.30.144:2005/api/v1';
  static const String registrationUrl = '$baseurl/Registration';
  static const String loginUrl = '$baseurl/Login';
  static const String taskUrl = '$baseurl/createTask';
  static const String taskListUrl = '$baseurl/listTaskByStatus/New';
  static const String progressListUrl = '$baseurl/listTaskByStatus/Progress';
  static const String completedListUrl = '$baseurl/listTaskByStatus/Completed';
  static const String canceledListUrl = '$baseurl/listTaskByStatus/Canceled';
  static const String taskstatuscountUrl = '$baseurl/taskStatusCount';

}
