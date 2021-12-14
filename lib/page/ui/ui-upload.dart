import 'package:egovapp/constants/language.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UIUploadWidget extends StatefulWidget
{
  const UIUploadWidget({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _UIUploadWidgetState createState() => _UIUploadWidgetState();
}
class _UIUploadWidgetState extends State<UIUploadWidget>
{
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var contentPage= Container(
        child:TextButton.icon(onPressed: () async {
          FilePickerResult? files= await FilePicker.platform.pickFiles(type: FileType.custom,
            allowedExtensions: ['jpg', 'pdf', 'doc'],);
          for(var p in files!.paths)
          {
            debugPrint("PATH FILE:"+p!);
            // ServiceToTrinhFile().add(1, p!);
          }

        },
            icon: Icon( Icons.attach_file, color: Colors.blue, size: 25),
            label: Text(Language.getText("filedinhkem"))
        )
    );

    return Scaffold(
      body: contentPage
    );
  }
}