import 'package:flutter/material.dart';

import '../../../../core/utils/constants/strings_manager.dart';
import '../../controllers/auth_cubit/auth_cubit.dart';
import '../calls/calls_page.dart';
import '../contacts_chat/contacts_chat_page.dart';
import '../status/status_page.dart';
import 'components/fab.dart';
import 'components/sliver_appbar_actions.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  //with WidgetsBindingObserver to check online and offline mode
  // TickerProviderStateMixin to make tabBar
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(changeActions);
    WidgetsBinding.instance
        .addObserver(this); // to check online and offline mode
  }

  void changeActions() {
    buildMainLayoutSliverAppBarActions(
      context,
      index: _tabController.index,
    );
    setState(() {});
  }
// to check online and offline mode
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        AuthCubit.get(context).setUserState(true);
        break;
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        AuthCubit.get(context).setUserState(false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        body: NestedScrollView(
          body: TabBarView(
            controller: _tabController,
            children: const <Widget>[
              ContactsChatPage(),
              StatusPage(),
              CallsPage(),
            ],
          ),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: const Text(AppStrings.appName),
                pinned: true,
                //automaticallyImplyLeading to remove back button
                automaticallyImplyLeading: false,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                actions: buildMainLayoutSliverAppBarActions(
                  context,
                  index: _tabController.index,
                ),
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  indicatorWeight: 4,
                  tabs:  <Tab>[
                    Tab(text: AppStrings.chats.toUpperCase()),
                    Tab(text: AppStrings.status.toUpperCase()),
                    Tab(text: AppStrings.calls.toUpperCase()),
                  ],
                  controller: _tabController,
                ),
              ),
            ];
          },
        ),
        floatingActionButton:  FAB(index: _tabController.index),
      );
    },);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}
