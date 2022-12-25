import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class Gcash1KWidget extends StatefulWidget {
  const Gcash1KWidget({
    Key? key,
    this.planprice,
  }) : super(key: key);

  final PlanRecord? planprice;

  @override
  _Gcash1KWidgetState createState() => _Gcash1KWidgetState();
}

class _Gcash1KWidgetState extends State<Gcash1KWidget>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF1E2429),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4B39EF), Color(0xFFEE8B60)],
            stops: [0, 1],
            begin: AlignmentDirectional(1, -1),
            end: AlignmentDirectional(-1, 1),
          ),
        ),
        child: FlutterFlowWebView(
          url: widget.planprice!.gcashUrl!,
          bypass: false,
          height: 812,
          verticalScroll: false,
          horizontalScroll: false,
        ),
      ),
    );
  }
}
