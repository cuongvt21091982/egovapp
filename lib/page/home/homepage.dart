import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/menu/app-bar-action.dart';
import 'package:egovapp/menu/bottom-bar-action.dart';
import 'package:flutter/material.dart';
class EgovHomePage extends StatefulWidget  {
  const EgovHomePage({Key? key}) : super(key: key);
  @override
  _EgovHomePageState createState() => _EgovHomePageState();
}
class _EgovHomePageState extends State<EgovHomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: UIUtils.colorAppBar,
          title:  TextField(
          cursorColor: Colors.black,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20,19,0,0),
              hintText: Language.getText("vanbandenchogiaoxuly"),
              border: InputBorder.none,
              suffixIcon: IconButton(
                padding:  EdgeInsets.fromLTRB(0,12,0,0),
                icon: UIUtils.iconButtonSearch,
                color: UIUtils.colorButtonSearch,
                onPressed: () {},
              )),
          style: UIUtils.textStyleSearch,
        ),
            actions: [
                  AppBarAction()
            ],
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
              ListView(
              children: <Widget>[
                ListTile(
                  minLeadingWidth: 0,
                  contentPadding:UIUtils.paddingLite,
                    subtitle: Container(
                      padding: UIUtils.paddingLiteSubTitle,
                       child:
                           Column(
                              children: [
                                 Container(
                                 padding: UIUtils.paddingLiteContentSubTitle,
                                 child: UIUtils.setTextContentItem("in my implementation I put this inside a row and surrounded it with sized boxes on each side so that I have some space between my elements, why using expanded you may ask, well it's used to take as much space as possible so the text would look good in portrait or landscape mode")
                                 ),
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Row( children:[
                                         UIUtils.getIconCodeStatus(1),
                                         UIUtils.setTextFooterByStatusItem("VH1231231", 1)
                                       ]
                                       ),
                                       Row( children:[
                                         UIUtils.getIconCountStatus(1),
                                         UIUtils.setTextFooterByStatusItem("1234", 1)
                                       ]
                                       ),
                                       Row( children:[
                                         UIUtils.getIconStatus(1),
                                         UIUtils.getTextStatus(1),
                                       ]
                                       )

                                      ]
                                )
                              ],
                           ),
                       decoration: UIUtils.setBorderBox(),

                    ),
                    title: Row(
                        children: <Widget>[
                          Container(
                            padding:UIUtils.paddingLiteTitle,
                            child:  UIUtils.setCircleAvatarStatusItem("CUONG", 1),

                          ),
                     UIUtils.setTextHeaderItem("Văn phòng trung ương đảng cộng sản việt nam"),
                      Spacer(),
                      UIUtils.setTextDateHeaderItem("12/12/2021")
                    ]),

                    ),
                ListTile(
                  minLeadingWidth: 0,
                  contentPadding:UIUtils.paddingLite,
                  subtitle: Container(
                    padding: UIUtils.paddingLiteSubTitle,
                    child:
                    Column(
                      children: [
                        Container(
                            padding: UIUtils.paddingLiteContentSubTitle,
                            child: UIUtils.setTextContentItem("in my implementation I put this inside a row and surrounded it with sized boxes on each side so that I have some space between my elements, why using expanded you may ask, well it's used to take as much space as possible so the text would look good in portrait or landscape mode")
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row( children:[
                                UIUtils.getIconCodeStatus(1),
                                UIUtils.setTextFooterByStatusItem("VH1231231", 1)
                              ]
                              ),
                              Row( children:[
                                UIUtils.getIconCountStatus(1),
                                UIUtils.setTextFooterByStatusItem("1234", 1)
                              ]
                              ),
                              Row( children:[
                                UIUtils.getIconStatus(1),
                                UIUtils.getTextStatus(1),

                              ]
                              )

                            ]
                        )
                      ],
                    ),
                    decoration: UIUtils.setBorderBox(),

                  ),
                  title: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          padding:UIUtils.paddingLiteTitle,
                          child:  UIUtils.setCircleAvatarStatusItem("CUONG", 1),

                        ),
                    UIUtils.setTextHeaderItem("12345method options, such as visibility, parameters, and so on. You can also change a name of ")
                  ,
                        Spacer(),
                        UIUtils.setTextDateHeaderItem("12/12/2021")
                      ]),

                ),
                ListTile(
                  minLeadingWidth: 0,
                  contentPadding:UIUtils.paddingLite,
                  subtitle: Container(
                    padding: UIUtils.paddingLiteSubTitle,
                    child:
                    Column(
                      children: [
                        Container(
                            padding: UIUtils.paddingLiteContentSubTitle,
                            child: UIUtils.setTextContentItem("in my implementation I put this inside a row and surrounded it with sized boxes on each side so that I have some space between my elements, why using expanded you may ask, well it's used to take as much space as possible so the text would look good in portrait or landscape mode")
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row( children:[
                                UIUtils.getIconCodeStatus(1),
                                UIUtils.setTextFooterByStatusItem("VH1231231", 1)
                              ]
                              ),
                              Row( children:[
                                UIUtils.getIconCountStatus(1),
                                UIUtils.setTextFooterByStatusItem("1234", 1)
                              ]
                              ),
                              Row( children:[
                                UIUtils.getIconStatus(1),
                                UIUtils.getTextStatus(1),

                              ]
                              )

                            ]
                        )
                      ],
                    ),
                    decoration: UIUtils.setBorderBox(),

                  ),
                  title: Row(
                      children: <Widget>[
                        Container(
                          padding:UIUtils.paddingLiteTitle,
                          child:  UIUtils.setCircleAvatarStatusItem("CUONG", 1),

                        ),
                        UIUtils.setTextHeaderItem("Văn phòng trung ương đảng"),
                        Spacer(),
                        UIUtils.setTextDateHeaderItem("12/12/2021")
                      ]),

                ),
                ListTile(
                  minLeadingWidth: 0,
                  contentPadding:UIUtils.paddingLite,
                  subtitle: Container(
                    padding: UIUtils.paddingLiteSubTitle,
                    child:
                    Column(
                      children: [
                        Container(
                            padding: UIUtils.paddingLiteContentSubTitle,
                            child: UIUtils.setTextContentItem("in my implementation I put this inside a row and surrounded it with sized boxes on each side so that I have some space between my elements, why using expanded you may ask, well it's used to take as much space as possible so the text would look good in portrait or landscape mode")
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row( children:[
                                UIUtils.getIconCodeStatus(1),
                                UIUtils.setTextFooterByStatusItem("VH1231231", 1)
                              ]
                              ),
                              Row( children:[
                                UIUtils.getIconCountStatus(1),
                                UIUtils.setTextFooterByStatusItem("1234", 1)
                              ]
                              ),
                              Row( children:[
                                UIUtils.getIconStatus(1),
                                UIUtils.getTextStatus(1),

                              ]
                              )

                            ]
                        )
                      ],
                    ),
                    decoration: UIUtils.setBorderBox(),

                  ),
                  title: Row(
                      children: <Widget>[
                        Container(
                          padding:UIUtils.paddingLiteTitle,
                          child:  UIUtils.setCircleAvatarStatusItem("CUONG", 1),

                        ),
                        UIUtils.setTextHeaderItem("Văn phòng trung ương đảng"),
                        Spacer(),
                        UIUtils.setTextDateHeaderItem("12/12/2021")
                      ]),

                ),
              ],
            )

          ],
        ),
        bottomNavigationBar: BottomBarAction(),
      ),
    );
  }


}

