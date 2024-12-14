import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

/// Global keys
GlobalKey<SliderDrawerState> kDrawerKey = GlobalKey<SliderDrawerState>();
List<GlobalKey<ExpansionTileCardState>> kHomePageExpansionKeys = [];
GlobalKey<NavigatorState> kNavigatorKey = GlobalKey<NavigatorState>();
GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
