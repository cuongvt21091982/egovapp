import 'package:flutter/material.dart';
class CalendarDepartBottomBarAction extends StatefulWidget {
  const CalendarDepartBottomBarAction({Key? key,
    required this.nextPage,
    required this.backPage,
    required this.yKien,
    required this.yKienTongHop,
    required this.showDanhSach,
    required this.showCalendar,
    required this.share
  }) : super(key: key);
  final VoidCallback nextPage;
  final VoidCallback backPage;
  final VoidCallback yKien;
  final VoidCallback yKienTongHop;
  final VoidCallback showDanhSach;
  final VoidCallback showCalendar;
  final VoidCallback share;
  @override
  _CalendarDepartBottomBarAction createState() => _CalendarDepartBottomBarAction();
}

class _CalendarDepartBottomBarAction extends State<CalendarDepartBottomBarAction> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(_selectedIndex == 0)
        this.widget.showDanhSach();
      if(_selectedIndex == 1)
        this.widget.showCalendar();
      if(_selectedIndex == 2)
        this.widget.backPage();
      if(_selectedIndex == 3)
        this.widget.nextPage();
      if(_selectedIndex == 4)
        this.widget.yKien();
      if(_selectedIndex == 5)
        this.widget.yKienTongHop();
      if(_selectedIndex == 6)
        this.widget.share();

    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child:
        BottomNavigationBar(
          unselectedItemColor: Colors.green,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined),
              label: "Danh sách",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_outlined),
                label: 'Dạng bảng'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.navigate_before),
              label: 'Tuần trước',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.navigate_next),
              label: 'Tuần sau',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit_location_alt),
              label: 'Ý kiến',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_reaction),
              label: 'Ý kiến tổng hợp',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.share),
              label: 'Chia sẽ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.print),
              label: "Xuất file excel",
            )
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.pink,
          onTap: _onItemTapped,
        )
    );

  }


}
