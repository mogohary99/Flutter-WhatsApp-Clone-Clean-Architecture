import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp_flutter_clone/core/functions/navigator.dart';
import 'package:whatsapp_flutter_clone/core/utils/routes/routes_manager.dart';
import 'package:whatsapp_flutter_clone/features/data/models/call_model.dart';
import 'package:whatsapp_flutter_clone/features/domain/entities/call.dart';
import 'package:whatsapp_flutter_clone/features/presentation/controllers/call_cubit/call_cubit.dart';

class CallPickupScreen extends StatelessWidget {
  final Widget scaffold;

  const CallPickupScreen({super.key, required this.scaffold});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return StreamBuilder<DocumentSnapshot>(
      stream: CallCubit.get(context).callStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.data() != null) {
          Call call =
              CallModel.fromMap(snapshot.data!.data()! as Map<String, dynamic>);
          if (!call.hasDialled) {
            return Scaffold(
              body: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Incoming call...',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(call.callerPic),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      call.callerName,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 75,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.call_end,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        IconButton(
                          onPressed: () {
                            navigateTo(
                              context,
                              Routes.callRoute,
                              arguments: {
                                'call': call,
                                'channelId': call.callId,
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.call,
                            color: Colors.green,
                            size: 40,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        }
        return scaffold;
      },
    );
  }
}
