class StoryModel {
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? storyId;
  String? caption;
  String? storyImage;
  StoryModel({
    this.name,
    this.uId,
    this.image,
    this.dateTime,
    this.storyId,
    this.storyImage,
    this.caption,
  });
  StoryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    storyId = json['storyId'];
    storyImage = json['storyImage'];
    caption = json['caption'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'storyId': storyId,
      'storyImage': storyImage,
      'caption': caption,
    };
  }
}
