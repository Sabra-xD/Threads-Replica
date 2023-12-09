// ignore: file_names
String timeStamp(String createdAtTimeStamp) {
  DateTime createdAt = DateTime.parse(createdAtTimeStamp);
  // Current time
  DateTime currentTime = DateTime.now();

  // Calculate the difference between current time and createdAt time
  Duration difference = currentTime.difference(createdAt);

  if (difference.inDays > 0) {
    print('${difference.inDays} days ago');
    return '${difference.inDays} days ago';
  } else if (difference.inHours > 0) {
    print('${difference.inHours} hours ago');
    return '${difference.inHours} hours ago';
  } else if (difference.inMinutes > 0) {
    print('${difference.inMinutes} minutes ago');
    return '${difference.inMinutes} minutes ago';
  } else {
    print('Just now');
    return "Just Now";
  }
}
