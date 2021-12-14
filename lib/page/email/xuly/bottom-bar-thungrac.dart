
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/utils/shims/dart_ui.dart';
class BottomBarThungRacAction extends StatefulWidget {
  const BottomBarThungRacAction({Key? key,
    required this.restoreItem,
    required this.restoreAll,
    required this.deleteItem,
    required this.deleteAll
  }) : super(key: key);
  final VoidCallback restoreItem;
  final VoidCallback restoreAll;
  final VoidCallback deleteItem;
  final VoidCallback deleteAll;
  @override
  _BottomBarThungRacActionAction createState() => _BottomBarThungRacActionAction();
}
class _BottomBarThungRacActionAction extends State<BottomBarThungRacAction> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(this._selectedIndex == 0)
           this.widget.restoreItem();
      if(this._selectedIndex == 1)
        this.widget.restoreAll();
      if(this._selectedIndex == 2)
        this.widget.deleteItem();
      if(this._selectedIndex == 3)
        this.widget.deleteAll();
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
                icon: Icon(Icons.reset_tv),
                label: "Phục hồi"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.reset_tv_sharp),
                label: 'Phục hồi tất cả'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.delete),
              label: 'Xóa mục chọn',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.delete_forever_outlined),
              label: 'Xóa tất cả',
            )
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.pink,
          onTap: _onItemTapped,
        )
    );

  }


}
