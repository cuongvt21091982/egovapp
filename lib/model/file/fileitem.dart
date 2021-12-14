class FileItem
{
  final String fileName;
  final String contentType;
  final int fileSize;
  final String fileKey;
  final String folder;
  final String fileType;


  FileItem({
    required this.fileName,
    required this.contentType,
    required this.fileSize,
    required this.fileKey,
    required this.folder,
    required this.fileType
  });
  factory FileItem.fromJson(Map<String, dynamic>? json) {
    return FileItem(
        fileName: json!=null && json['fileName'] != null? json['fileName']: '',
        contentType: json!=null && json['contentType'] != null? json['contentType']: '',
        fileSize: json!=null && json['fileSize'] != null? json['fileSize']: 0,
        fileKey: json!=null && json['fileKey'] != null? json['fileKey']: '',
        folder: json!=null && json['folder'] != null? json['folder']: '',
        fileType: json!=null && json['fileType'] != null? json['fileType']: ''
    );
  }
}
