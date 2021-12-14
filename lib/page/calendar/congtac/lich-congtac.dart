import 'package:dropdown_search/dropdown_search.dart';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/constants/enviroments.dart';
import 'package:egovapp/constants/format-util.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/model/calendar/calendarnews.dart';

import 'package:egovapp/model/calendar/calendarnewsfile.dart';
import 'package:egovapp/model/calendar/calendarnewsweek.dart';
import 'package:egovapp/model/calendar/data-week.dart';
import 'package:egovapp/model/calendar/event-calendar.dart';
import 'package:egovapp/page/calendar/congtac/detail.dart';
import 'package:egovapp/page/calendar/congtac/lich-congtac-edit.dart';
import 'package:egovapp/page/calendar/congtac/ykien.dart';
import 'package:egovapp/page/calendar/congtac/ykientonghop.dart';
import 'package:egovapp/page/calendar/xuly/bottom-bar-calendar-action.dart';
import 'package:egovapp/page/files/download-file.dart';
import 'package:egovapp/page/files/filelink.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/service/calendar/service-calendarnews.dart';
import 'package:egovapp/service/calendar/service-dataweek.dart';
import 'package:egovapp/service/calendar/service-datayear.dart';
import 'package:egovapp/service/calendar/service-eventcalendarsource.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
class LichCongTac extends StatefulWidget {
  const LichCongTac({Key? key}) : super(key: key);
  @override
  _LichCongTacState createState() => _LichCongTacState();
}
class _LichCongTacState extends State<LichCongTac> {
  final txtKeyword = TextEditingController();
  int page = Enviroments.currentPage;
  int size= Enviroments.pageSize;
  DataWeek? weekCurrent;
  int currentWeek = 0;
  int yearCurrent = DateTime.now().year;
  int status= ParamUtils.valueDefault;
  int suDung= ParamUtils.valueDefault;
  int staffId= ParamUtils.valueDefault;
  List<DataWeek> dataWeeks=[];
  int typeShow = 0;

  List<EventCalendar> eventCalendarList=[];
  int calendarMonthCurrent=DateTime.now().month;
  int calendarYearCurrent=DateTime.now().year;
  var _dataSource;
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    getDataSource();
    super.initState();
    ServiceDataWeek().getCurrentWeek().then((value) {
          setState(() {
            this.currentWeek = value;
          });
     loadWeekByYear();
    }).catchError((e) {
      UIUtils.showToastError(e.toString(), context);
    });


  }
  dynamic nextPage() async
  {
     int index= dataWeeks.indexWhere((element) => element.id == currentWeek +1);
     if(index!=-1)
       {
                  setState(() {
                    weekCurrent = dataWeeks[index];
                    currentWeek +=1;
                    searchCalendar();
                  });

       }
  }
  dynamic yKien() async
  {
    Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) =>
              YKienCalendarNews(
                  week: this.currentWeek, year: this.yearCurrent, title: Language.getText('ykienxuly')),
          fullscreenDialog: true,
        ));
  }
  dynamic yKienTongHop() async
  {
    Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => CalendarNewsYKienTongHopDialog(
              id: this.currentWeek,year:  this.yearCurrent, title: Language.getText("ykientonghop")),
          fullscreenDialog: true,
        ));
  }
  dynamic backPage() async
  {
    int index= dataWeeks.indexWhere((element) => element.id == currentWeek -1);
    if(index!=-1)
    {         setState(() {
                weekCurrent = dataWeeks[index];
                currentWeek -=1;
                searchCalendar();
                });


    }
  }
  dynamic showDS() async
  {
    setState(() {
      this.typeShow = 0;
    });

  }

  dynamic showCalendar() async
  {
    setState(() {
      this.typeShow = 1;
    });
  }
  final PagingController<int,CalendarNewsWeek> _pagingController = PagingController(firstPageKey: 0);
  Future<void> _fetchPage(int pageKey) async {
    ServiceCalendarNews().getDataByWeekYear(currentWeek, this.yearCurrent,this.staffId, this.status, this.suDung).then((value)
    {
      try {
        final isLastPage = value.length < size;
        if (isLastPage) {
          _pagingController.appendLastPage(value);
        } else {
          page +=1;
          final nextPageKey = pageKey + value.length;
          _pagingController.appendPage(value, nextPageKey);
        } } catch (error) {
        _pagingController.error = error;
      }
    }).catchError((e){
      UIUtils.showToastError(e.toString(), context);
    });
  }
  void _createCalendar() {

    Navigator.push(context, new MaterialPageRoute(builder: (context) => new EditLichCongTac(id: 0, title: Language.getText('create_calendar'), callBackRefresh: () =>
        setState((){  searchCalendar();}, )
      ,)), );
  }
  void searchCalendar() {
    _pagingController.refresh();
  }
  void loadWeekByYear() async
  {
    return ServiceDataWeek().getAllByYear(yearCurrent).then((value) {
      setState(() {
        this.dataWeeks = value;
        int index=this.dataWeeks.indexWhere((element) => element.id == currentWeek);
        if(index!=-1)
          this.weekCurrent = this.dataWeeks[index];
          searchCalendar();
      });
    })
    .catchError((e) {
      UIUtils.showToastError(e.toString(), context);
    });

  }
  void selectYear() async
  {
      loadWeekByYear();
  }
  void showYear()
  {
    var formEdit= Container(
        padding: UIUtils.paddingForm,
        child:   DropdownSearch<int>(
            mode: Mode.MENU,
            showSearchBox: true,
            showClearButton: false,
            selectedItem:  this.yearCurrent,
            items: ServiceDataYear().getAll().map((e) => e.year).toList(),
            dropdownSearchDecoration:  UIUtils.setInputAppBarDecoration(Language.getText('select_year'), Language.getText('select_year'),false),
            itemAsString: (int? u) => Language.getText("year")+" "+ u!.toString(),
            onChanged: (data) {
              this.yearCurrent = data!;
            })

    );
    new UICustomDialog(selectYear).show(context,Language.getText('select_year'),
        Language.getText('select_year'),formEdit);
  }
  void showFile(List<CalendarNewsFile> value)
  {
    List<FileLink> fileLinks=[];
    for(var item in value)
    {
      fileLinks.add(new FileLink(name: item.name,
          link: ApiUtils().getDownloadFileUrl(item.folder, item.fileKey, item.width, item.name)));
    }
    Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) =>
              DonwloadFileDialog( files: fileLinks),
          fullscreenDialog: true,
        ));

  }
  var _calendarController=new CalendarController();
  void viewChanged(ViewChangedDetails viewChangedDetails) {
    SchedulerBinding.instance!.addPostFrameCallback((Duration duration) {
      _calendarController.selectedDate = viewChangedDetails.visibleDates[0];
      debugPrint(_calendarController.selectedDate.toString());
    });
  }
  void showDetail(int id)
  {
    Navigator.push(context, new MaterialPageRoute(builder: (context) =>
    new LichCongTacDetail(id: id, chuDe: Language.getText("thongtinlichcongtac"), callBackRefresh: () =>
        setState((){  })
    )));
  }
  void getDataSource() async
  {
    List<EventCalendar> eventCalendarList=[];
    ServiceCalendarNews().findByMonth(this.calendarMonthCurrent, this.calendarYearCurrent, staffId, status, suDung).then((value) {
      for(CalendarNews item in value)
      {
        final DateTime fromDate=FormatUtils.convertDateTime(item.tuNgay!, item.tuGio);
        final DateTime toDate=FormatUtils.convertDateTime(item.denNgay!, item.denGio);
        eventCalendarList.add(new EventCalendar(item.id,
            item.chuTri+" - "+item.diaDiem,fromDate,toDate,
            FormatUtils.fromHex(item.bgColor), true));
      }
      _dataSource = new EventCalendarDataSource(eventCalendarList);

    }).catchError((e) {

      UIUtils.showToastError(e.toString(), context);
    });

  }
  void loadDataSource(int month, int year)
  {
    this.calendarMonthCurrent = month;
    this.calendarYearCurrent = year;
    getDataSource();
  }
  @override
  Widget build(BuildContext context) {

    var searchOption=DropdownSearch<DataWeek>(
        mode: Mode.MENU,
        showSearchBox: true,
        showClearButton: false,
        selectedItem: weekCurrent,
        items: dataWeeks,
        dropdownSearchDecoration:  UIUtils.setInputAppBarDecoration(Language.getText('select_week'), Language.getText('select_week'),false),
        itemAsString: (DataWeek? u) => Language.getText("week")+" "+ u!.id.toString()+"("+ u.title+")",
        onChanged: (data) {
          this.weekCurrent = data;
          this.currentWeek = data!.id;
          searchCalendar();
        });
    var contentPageCalendar=ListTile( minLeadingWidth: 0,
        contentPadding:UIUtils.paddingLite,
        subtitle: UICalendarEvent(eventCalendarDataSource: _dataSource,callMethodDetail: showDetail,
        loadDataSource: loadDataSource)

    );
    var pageDS=PagedListView<int, CalendarNewsWeek>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<CalendarNewsWeek>(
            noItemsFoundIndicatorBuilder: UIUtils.noFoundItem,
            itemBuilder: (context, item, index) =>  ListTile(
                minLeadingWidth: 0,
                contentPadding:UIUtils.paddingLite,
                subtitle:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Container(
                        child:  ListView.builder(
                            shrinkWrap: true,
                            itemCount: item.calendars.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile( minLeadingWidth: 0,
                                  contentPadding:UIUtils.paddingLite,
                                  subtitle:
                                  Container(
                                      child:UIUtils.setHtmlItem(item.calendars[index].noiDung)

                                  ),
                                  title: Column(
                                    children: [
                                      Container(
                                        padding: UIUtils.paddingListView,
                                        alignment: Alignment.topLeft,
                                        child: UIUtils.setNamePerson(Language.getText("nguoichutri")+": "+item.calendars[index].chuTri),
                                      ),
                                      Container(
                                        padding: UIUtils.paddingListView,
                                        alignment: Alignment.topLeft,
                                        child:  UIUtils.setNameDate(Language.getText("thoigian")+": Từ "+item.calendars[index].tuGio+" - "+item.calendars[index].denGio),
                                      ),Container(
                                        padding: UIUtils.paddingListView,
                                        alignment: Alignment.topLeft,
                                        child:  UIUtils.setTextLong(Language.getText("diadiem")+": "+item.calendars[index].diaDiem),
                                      ),Container(
                                        padding: UIUtils.paddingListView,
                                        alignment: Alignment.topLeft,
                                        child:  UIUtils.setTextLong(Language.getText("ghichu")+": "+item.calendars[index].ghiChu),
                                      ),
                                      if(item.calendars[index].calendarNewsFiles.length>0)
                                        Container(
                                            alignment: Alignment.topLeft,
                                            child:TextButton.icon(onPressed: () async {
                                              showFile(item.calendars[index].calendarNewsFiles);
                                            },
                                                style:UIUtils.setNoButtonAttachViewStyle(),
                                                icon: UIUtils.setNoButtonIcon(Icons.attach_file),
                                                label: UIUtils.setNoButtonText(item.calendars[index].calendarNewsFiles.length.toString()+" "+ Language.getText("filedinhkem")
                                                )
                                            )
                                        )
                                    ],
                                  )
                              );
                            }
                          )
                      ),
                  ]
                )
               ,
                title:Container(
                  decoration: UIUtils.setBorderBox(),
                  child:  UIUtils.setTextBoldWeekTitle(item.day, item.dateWeek),
                )
                ,
                onTap: (){


                  //Navigator.of(context).pushNamed("/totrinhguidetail", arguments: { 'id': item.id, 'title': item.chuDe});
                }

            )
        )
    );
    var contentPageDS=ListTile( minLeadingWidth: 0,
      contentPadding:UIUtils.paddingLite,
      subtitle:pageDS,
      title:searchOption);

    return new WillPopScope(child:  Scaffold(
        appBar: AppBar(
          backgroundColor: UIUtils.colorAppBar,
          title: TextField(
            cursorColor: Colors.black,
            controller: txtKeyword,
            decoration: InputDecoration(
                contentPadding: UIUtils.paddingSearhAppBar,
                hintText: Language.getText("lichcongtac").toUpperCase(),
                hintStyle: UIUtils.textStyleSearch,
                border: InputBorder.none,
                suffixIcon: IconButton(
                    padding:  UIUtils.paddingButtonSearchAppBar,
                    icon: UIUtils.iconButtonYear,
                    color: UIUtils.colorButtonSearch,
                    onPressed: () {
                      showYear();
                    }
                )),
            style: UIUtils.textStyleSearch,
          ),
        ),
        body: this.typeShow  == 0?contentPageDS: contentPageCalendar,
        floatingActionButton: FloatingActionButton(
          onPressed: _createCalendar,
          tooltip: Language.getText('create_calendar'),
          child: Icon(Icons.add),
        ), bottomNavigationBar: CalendarBottomBarAction(
      nextPage: this.nextPage,
      backPage: this.backPage,
      yKien: this.yKien,
      yKienTongHop: this.yKienTongHop,
      showDanhSach: this.showDS,
      showCalendar: this.showCalendar,
    )
      // This trailing comma makes auto-formatting nicer for build methods.
    ),
        onWillPop: () {
          return new Future.value(true);
        });

  }


}

