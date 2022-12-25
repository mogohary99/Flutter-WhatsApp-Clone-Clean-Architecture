import 'package:equatable/equatable.dart';
import 'package:flutter/animation.dart';

class PopUpMenuItemModel extends Equatable{
  final String name;
  final VoidCallback onTap;

  const PopUpMenuItemModel({required this.name, required this.onTap,});

  @override
  List<Object?> get props => [name,onTap];
}