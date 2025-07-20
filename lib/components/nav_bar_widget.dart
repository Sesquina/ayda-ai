import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'nav_bar_model.dart';
export 'nav_bar_model.dart';

/// Create a bottom navigation bar for a mobile app with four icons and a
/// central floating action button (FAB).
///
/// The navigation bar should include the following items in this order from
/// left to right: Home icon which opens the main dashboard, Chat icon lwhich
/// opens the AI chatbot screen, a circular floating action button in the
/// center with a plus sign that opens the Upload screen for medical
/// documents, a Track icon that links to the Symptom and Medication Tracker
/// screen, and a Notes icon that links to the Medical Notes and Logs screen.
/// Use even spacing between items and ensure the FAB is elevated, visually
/// highlighted, and centered above the nav bar. Set all icons to be
/// ADA-accessible with large tap targets and high contrast. Ensure the nav
/// bar is reusable as a component across all app screens and compatible with
/// SafeArea and bottom padding for iOS and Android. The style should be calm,
/// clean, and mobile-first.
class NavBarWidget extends StatefulWidget {
  const NavBarWidget({super.key});

  @override
  State<NavBarWidget> createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  late NavBarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NavBarModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Container(
        width: double.infinity,
        height: 80.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 8.0,
              color: Color(0x33000000),
              offset: Offset(
                0.0,
                -2.0,
              ),
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12.0, 16.0, 12.0, 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 28.0,
                borderWidth: 0.0,
                buttonSize: 56.0,
                fillColor: Colors.transparent,
                icon: Icon(
                  Icons.home_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 28.0,
                ),
                onPressed: () {
                  print('IconButton pressed ...');
                },
              ),
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 28.0,
                borderWidth: 0.0,
                buttonSize: 56.0,
                fillColor: Colors.transparent,
                icon: Icon(
                  Icons.chat_bubble_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 28.0,
                ),
                onPressed: () {
                  print('IconButton pressed ...');
                },
              ),
              Material(
                color: Colors.transparent,
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: Container(
                  width: 64.0,
                  height: 64.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primary,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 12.0,
                        color: Color(0x4B39EF40),
                        offset: Offset(
                          0.0,
                          4.0,
                        ),
                        spreadRadius: 0.0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  child: FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 50.0,
                    borderWidth: 0.0,
                    buttonSize: 64.0,
                    fillColor: Colors.transparent,
                    hoverColor: FlutterFlowTheme.of(context).accent4,
                    icon: Icon(
                      Icons.upload,
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      size: 32.0,
                    ),
                    onPressed: () {
                      print('IconButton pressed ...');
                    },
                  ),
                ),
              ),
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 28.0,
                borderWidth: 0.0,
                buttonSize: 56.0,
                fillColor: Colors.transparent,
                icon: Icon(
                  Icons.timeline_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 28.0,
                ),
                onPressed: () {
                  print('IconButton pressed ...');
                },
              ),
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 28.0,
                borderWidth: 0.0,
                buttonSize: 56.0,
                fillColor: Colors.transparent,
                icon: Icon(
                  Icons.note_alt_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 28.0,
                ),
                onPressed: () {
                  print('IconButton pressed ...');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
