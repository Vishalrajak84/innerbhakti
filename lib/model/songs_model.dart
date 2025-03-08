class SongUiModel {
  String? id;
  String? songName;
  String? songImg;
  String? songUrl;
  String? about;

  SongUiModel({this.id, this.songName, this.songImg, this.songUrl, this.about});

  SongUiModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] is Map ? json['_id']['\$oid'] : json['_id'];
    songName = json['songName'];
    songImg = json['songImg'];
    songUrl = json['songUrl'];
    about = json['about'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = this.id;
    data['songName'] = this.songName;
    data['songImg'] = this.songImg;
    data['songUrl'] = this.songUrl;
    data['about'] = this.about;
    return data;
  }

  @override
  String toString() {
    return 'SongUiModel{id: $id, songName: $songName, songImg: $songImg, songUrl: $songUrl, about:$about}';
  }
}
