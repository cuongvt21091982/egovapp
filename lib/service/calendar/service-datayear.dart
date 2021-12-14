import 'package:egovapp/constants/language.dart';
import 'package:egovapp/model/calendar/data-year.dart';

class ServiceDataYear {

  List<DataYear> getAll()
  {
    List<DataYear> yearData=[];
    for(int i =2005;i<=DateTime.now().year;i++)
      yearData.add(new DataYear(year: i, title: Language.getText("year")+" "+i.toString()));
    return yearData;
  }

}