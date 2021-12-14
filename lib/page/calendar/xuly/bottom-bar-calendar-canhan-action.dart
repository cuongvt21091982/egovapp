import 'package:flutter/material.dart';
class CalendarCaNhanBottomBarAction extends StatefulWidget {
  const CalendarCaNhanBottomBarAction({Key? key,
    required this.nextPage,
    required this.backPage,
    required this.showDanhSach,
    required this.showCalendar,
    required this.share
  }) : super(key: key);
  final VoidCallback nextPage;
  final VoidCallback backPage;
  final VoidCallback showDanhSach;
  final VoidCallback showCalendar;
  final VoidCallback share;
  @override
  _CalendarCaNhanBottomBarAction createState() => _CalendarCaNhanBottomBarAction();
}

class _CalendarCaNhanBottomBarAction extends State<CalendarCaNhanBottomBarAction> {
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
