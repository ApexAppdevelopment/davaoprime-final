import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_timer.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CountdownWidget extends StatefulWidget {
  const CountdownWidget({Key? key}) : super(key: key);

  @override
  _CountdownWidgetState createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  int timerMilliseconds = 10000;
  String timerValue = StopWatchTimer.getDisplayTime(10000);
  StopWatchTimer timerController =
      StopWatchTimer(mode: StopWatchMode.countDown);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    timerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
      child: FlutterFlowTimer(
        initialTime: timerMilliseconds,
        getDisplayTime: (value) => StopWatchTimer.getDisplayTime(value),
        timer: timerController,
        updateStateInterval: Duration(milliseconds: 1000),
        onChanged: (value, displayTime, shouldUpdate) {
          timerMilliseconds = value;
          timerValue = displayTime;
          if (shouldUpdate) setState(() {});
        },
        textAlign: TextAlign.start,
        style: FlutterFlowTheme.of(context).bodyText1.override(
              fontFamily: FlutterFlowTheme.of(context).bodyText1Family,
              color: FlutterFlowTheme.of(context).primaryColor,
              fontSize: 18,
              useGoogleFonts: GoogleFonts.asMap()
                  .containsKey(FlutterFlowTheme.of(context).bodyText1Family),
            ),
      ),
    );
  }
}
