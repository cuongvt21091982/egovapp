class HoSoFileXuLy
{
  final int id;
  final String name;
  final int size;
  final int fileTypeID;
  final int maVB;
  final String fileKey;
  final String width;
  final String fileType;
  final String folder;

  HoSoFileXuLy({
    required this.id,
    required this.name,
    required this.size,
    required this.fileTypeID,
    required this.maVB,
    required this.fileKey,
    required this.width,
    required this.fileType,
    required this.folder
  });
  factory HoSoFileXuLy.fromJson(Map<String, dynamic>? json) {
    return HoSoFileXuLy(
        id: json!=null && json['id'] != null? json['id']: 0,
        name: json!=null && json['name'] != null? json['name']: '',
        size: json!=null && json['size'] != null? json['size']: 0,
        fileTypeID: json!=null && json['fileTypeID'] != null? json['fileTypeID']: 0,
        maVB: json!=null && json['maVB'] != null? json['maVB']: 0,
        fileKey: json!=null && json['fileKey'] != null? json['fileKey']: '',
        width: json!=null && json['width'] != null? json['width']: '',
        fileType: json!=null && json['fileType'] != null? json['fileType']: 0,
        folder: json!=null && json['folder'] != null? json['folder']: ''
    );
  }
}
