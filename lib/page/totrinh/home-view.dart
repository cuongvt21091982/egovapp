import 'package:egovapp/constants/enviroments.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/model/totrinh/totrinh.dart';
import 'package:egovapp/service/totrinh/service-totrinh.dart';
import 'package:flutter/material.dart';
class ToTrinhHome extends StatefulWidget
{
  const ToTrinhHome({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _ToTrinhHomeState createState() => _ToTrinhHomeState();
}
class _ToTrinhHomeState extends State<ToTrinhHome>
{
  int page = Enviroments.currentPage;
  int size= Enviroments.pageSize;
  int totalRecord = 0;
  List<ToTrinh> dataList= [];
  ScrollController controller= new ScrollController() ;
  @override
  void initState() {
    ServiceToTrinh().getCount('','1,2,3',UserAuthSession.staffId, -1, '','').then((value) {
      totalRecord = value;
    });
    controller = new ScrollController()..addListener(_scrollListener);
    super.initState();
  }
  _scrollListener() {

    if (controller.position.extentAfter <= 0) {
       page+=1;
       debugPrint(dataList.length.toString());
       if(dataList.length<= totalRecord)
         {
           setState(() { });
         }
    }
  }
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    debugPrint(arguments["id"].toString());
    var futureBuilder = FutureBuilder(
        future:  ServiceToTrinh().getPaging('','1,2,3',UserAuthSession.staffId, -1, '','', page, size),
        builder: (context ,AsyncSnapshot  snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else
              {
                if (snapshot.hasData == false) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  dataList.addAll(snapshot.data);

                  return  ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: dataList.length,
                      scrollDirection: Axis.vertical,
                      controller: controller,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            height: 50,
                            child: Text('${dataList[index].chuDe}')
                        );
                      });
                }
              }
          }
          return Text('NOT ITEM');
        }
    );

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: futureBuilder
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}
