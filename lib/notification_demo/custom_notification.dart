import 'package:flutter/material.dart';

class CustomNotification extends Notification{
  CustomNotification(this.type);
  ScrollNotificationType type;
}

enum ScrollNotificationType {
  show,
  hide
}