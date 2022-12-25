import 'package:flutter/material.dart';

import '../../../../../core/functions/navigator.dart';
import '../../../../../core/utils/routes/routes_manager.dart';

class FAB extends StatelessWidget {
  final int index;
  const FAB({
  super.key, required this.index,
  });

  @override
  Widget build(BuildContext context) {
    switch(index){
      case 0:
        return const ChatsFAB();
      case 1:
        return const StatusTwoFAB();
      case 2:
        return const CallsFAB();
      default:
        return const ChatsFAB();
    }

  }
}

class CallsFAB extends StatelessWidget {
  const CallsFAB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.add_ic_call_rounded),
    );
  }
}

class ChatsFAB extends StatelessWidget {
  const ChatsFAB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        navigateTo(context, Routes.selectContactRoute);
      },
      child: const Icon(Icons.message),
    );
  }
}

class StatusTwoFAB extends StatelessWidget {
  const StatusTwoFAB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 45,
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: const Color(0XFFE9EDEF),
            child: const Icon(Icons.edit,color: Colors.black54,),
          ),
        ),
        const SizedBox(height: 10),
        FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.camera_alt_rounded),
        ),
      ],
    );
  }
}