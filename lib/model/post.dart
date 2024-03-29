class Post {
  String? id;
  String? image;
  String? video;
  String? desc;
  String? ownerImage;
  String? ownerName;
  String? ownerId;
  String? date;
  String? mediaId;

  Post(
      {required this.id,
      required this.image,
      required this.video,
      required this.desc,
      required this.ownerName,
      required this.ownerImage,
      required this.ownerId,
      required this.date,
        required this.mediaId
      });

  Post.fromJson(Map<Object?, Object?> json)
      : id = json['id'].toString(),
        image = json['image'].toString(),
        video = json['video'].toString(),
        desc = json['desc'].toString(),
        ownerName = json['owner_name'].toString(),
        ownerImage = json['owner_image'].toString(),
        ownerId = json['owner_id'].toString(),
        date = json['desc'].toString(),
        mediaId = json['media_id'].toString();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'video': video,
      'desc': desc,
      'owner_name': ownerName,
      'owner_image': ownerImage,
      'owner_id': ownerId,
      'date': date,
      'media_id': mediaId,
    };
  }
}
