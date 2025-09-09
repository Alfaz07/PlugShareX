import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// Firebase messaging temporarily disabled
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  // Mock Firebase messaging instance
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    // Initialize local notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Request permissions
    await _requestPermissions();

    // Initialize Firebase messaging (temporarily disabled)
    // await _initializeFirebaseMessaging();
  }

  Future<void> _requestPermissions() async {
    // Request local notification permissions
    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    // Request Firebase messaging permissions (temporarily disabled)
    // await _firebaseMessaging.requestPermission(
    //   alert: true,
    //   badge: true,
    //   sound: true,
    // );
  }

  // Mock Firebase messaging initialization
  // Future<void> _initializeFirebaseMessaging() async {
  //   // Handle background messages
  //   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //   // Handle foreground messages
  //   FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

  //   // Handle notification taps when app is opened from background
  //   FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

  //   // Get initial message if app was opened from notification
  //   RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
  //   if (initialMessage != null) {
  //     _handleNotificationTap(initialMessage);
  //   }
  // }

  void _onNotificationTapped(NotificationResponse response) {
    // Handle local notification tap
    print('Local notification tapped: ${response.payload}');
  }

  // Mock foreground message handler
  // void _handleForegroundMessage(RemoteMessage message) {
  //   print('Foreground message received: ${message.data}');
  //   _showLocalNotification(
  //     title: message.notification?.title ?? 'New Message',
  //     body: message.notification?.body ?? '',
  //     payload: message.data.toString(),
  //   );
  // }

  // Mock notification tap handler
  // void _handleNotificationTap(RemoteMessage message) {
  //   print('Notification tapped: ${message.data}');
  //   // Navigate to appropriate screen based on message data
  // }

  Future<void> _showLocalNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'plugsharex_channel',
      'PlugShareX Notifications',
      channelDescription: 'Notifications for PlugShareX app',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _localNotifications.show(
      DateTime.now().millisecond,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    await _showLocalNotification(
      title: title,
      body: body,
      payload: payload,
    );
  }

  Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'plugsharex_scheduled_channel',
      'PlugShareX Scheduled Notifications',
      channelDescription: 'Scheduled notifications for PlugShareX app',
      importance: Importance.high,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _localNotifications.zonedSchedule(
      DateTime.now().millisecond,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
    );
  }

  Future<void> cancelAllNotifications() async {
    await _localNotifications.cancelAll();
  }

  Future<void> cancelNotification(int id) async {
    await _localNotifications.cancel(id);
  }

  // Mock Firebase messaging background handler
  // static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //   print('Background message received: ${message.data}');
  // }

  // Mock method to get FCM token
  Future<String?> getFCMToken() async {
    // Mock implementation
    await Future.delayed(const Duration(seconds: 1));
    return 'mock-fcm-token-${DateTime.now().millisecondsSinceEpoch}';
  }

  // Mock method to subscribe to topic
  Future<void> subscribeToTopic(String topic) async {
    // Mock implementation
    await Future.delayed(const Duration(seconds: 1));
    print('Subscribed to topic: $topic');
  }

  // Mock method to unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    // Mock implementation
    await Future.delayed(const Duration(seconds: 1));
    print('Unsubscribed from topic: $topic');
  }
}

// Background message handler (must be top-level function)
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // Handle background messages
//   print('Handling background message: ${message.messageId}');
// }

enum NotificationType {
  general,
  bookingConfirmed,
  bookingCancelled,
  bookingReminder,
  chargingStarted,
  chargingCompleted,
  chargingError,
  paymentProcessed,
  paymentFailed,
  hostRequest,
  hostApproved,
  messageReceived,
  promotional,
}
