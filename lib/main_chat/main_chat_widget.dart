import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../chat_page/chat_page_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MainChatWidget extends StatefulWidget {
  MainChatWidget({Key key}) : super(key: key);

  @override
  _MainChatWidgetState createState() => _MainChatWidgetState();
}

class _MainChatWidgetState extends State<MainChatWidget> {
  TextEditingController textController;
  final pageViewController = PageController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.tertiaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Explore',
          style: FlutterFlowTheme.title1.override(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: InkWell(
              onTap: () async {
                await pageViewController.animateToPage(
                  0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              },
              child: Icon(
                Icons.add_rounded,
                color: FlutterFlowTheme.primaryColor,
                size: 26,
              ),
            ),
          )
        ],
        centerTitle: false,
        elevation: 2,
      ),
      backgroundColor: Color(0xFFF1F4F8),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 12, 0, 12),
                        child: Text(
                          'Lasted updates',
                          style: FlutterFlowTheme.bodyText2.override(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  StreamBuilder<List<MainChatRecord>>(
                    stream: queryMainChatRecord(
                      queryBuilder: (mainChatRecord) =>
                          mainChatRecord.orderBy('timestamp', descending: true),
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      List<MainChatRecord> listViewMainChatRecordList =
                          snapshot.data;
                      // Customize what your widget looks like with no query results.
                      if (snapshot.data.isEmpty) {
                        // return Container();
                        // For now, we'll just include some dummy data.
                        listViewMainChatRecordList =
                            createDummyMainChatRecord(count: 4);
                      }
                      return Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: listViewMainChatRecordList.length,
                          itemBuilder: (context, listViewIndex) {
                            final listViewMainChatRecord =
                                listViewMainChatRecordList[listViewIndex];
                            return StreamBuilder<UsersRecord>(
                              stream: UsersRecord.getDocument(
                                  listViewMainChatRecord.user),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                final cardEventUsersRecord = snapshot.data;
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(8, 0, 8, 0),
                                          child: Card(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            color:
                                                FlutterFlowTheme.tertiaryColor,
                                            elevation: 3,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      12, 4, 12, 4),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 4, 0, 0),
                                                        child: Text(
                                                          cardEventUsersRecord
                                                              .displayName,
                                                          style:
                                                              FlutterFlowTheme
                                                                  .bodyText2
                                                                  .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color:
                                                                FlutterFlowTheme
                                                                    .primaryColor,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.85,
                                                  height: 1,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFDBE2E7),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      12, 4, 12, 4),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          listViewMainChatRecord
                                                              .text,
                                                          textAlign:
                                                              TextAlign.end,
                                                          style:
                                                              FlutterFlowTheme
                                                                  .bodyText2
                                                                  .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      12, 4, 12, 8),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 0, 5, 0),
                                                        child: Icon(
                                                          Icons.schedule,
                                                          color:
                                                              FlutterFlowTheme
                                                                  .primaryColor,
                                                          size: 20,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                4, 0, 0, 0),
                                                        child: Text(
                                                          dateTimeFormat(
                                                              'jm',
                                                              listViewMainChatRecord
                                                                  .timestamp),
                                                          style:
                                                              FlutterFlowTheme
                                                                  .bodyText1
                                                                  .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color:
                                                                FlutterFlowTheme
                                                                    .primaryColor,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                100, 0, 0, 0),
                                                        child: Text(
                                                          'Start chat now',
                                                          style:
                                                              FlutterFlowTheme
                                                                  .bodyText1
                                                                  .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color:
                                                                FlutterFlowTheme
                                                                    .primaryColor,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                15, 0, 0, 4),
                                                        child: InkWell(
                                                          onTap: () async {
                                                            await Navigator
                                                                .push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ChatPageWidget(
                                                                  chatUser:
                                                                      cardEventUsersRecord,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: FaIcon(
                                                            FontAwesomeIcons
                                                                .chevronRight,
                                                            color:
                                                                FlutterFlowTheme
                                                                    .primaryColor,
                                                            size: 20,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 1),
            child: Container(
              width: double.infinity,
              height: 50,
              child: PageView(
                controller: pageViewController,
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment(0, 1),
                            child: TextFormField(
                              controller: textController,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Spread your toughts...',
                                hintStyle: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                filled: true,
                                fillColor: Color(0xFFF5F5F5),
                              ),
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            final text = textController.text;
                            final timestamp = getCurrentTimestamp;
                            final user = currentUserReference;

                            final mainChatRecordData = createMainChatRecordData(
                              text: text,
                              timestamp: timestamp,
                              user: user,
                            );

                            await MainChatRecord.collection
                                .doc()
                                .set(mainChatRecordData);
                            await pageViewController.animateToPage(
                              1,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          icon: Icon(
                            Icons.send,
                            color: Color(0xFF4B4848),
                            size: 26,
                          ),
                          iconSize: 26,
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
