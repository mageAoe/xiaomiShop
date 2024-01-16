class UserModel {

  String? sid;
  String? username;
  String? tel;
  String? password;
  String? salt;
  int? gold;
  int? coupon;
  int? redPacket;
  int? quota;
  int? collect;
  int? footmark;
  int? follow;

  UserModel({
   this.sid,
   this.username,
   this.tel,
   this.password,
   this.salt,
   this.gold,
   this.coupon,
   this.redPacket,
   this.quota,
   this.collect,
   this.footmark,
   this.follow,
  });
  
  UserModel.fromJson(Map<String, dynamic> json){
    sid = json['_id'];
    username = json['username'];
    tel = json['tel'];
    password = json['password'];
    salt = json['salt'];
    gold = json['gold'];
    coupon = json['coupon'];
    redPacket = json['redPacket'];
    quota = json['quota'];
    collect = json['collect'];
    footmark = json['footmark'];
    follow = json['follow'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sid;
    data['username'] = username;
    data['tel'] = tel;
    data['password'] = password;
    data['salt'] = salt;
    data['gold'] = gold;
    data['coupon'] = coupon;
    data['redPacket'] = redPacket;
    data['quota'] = quota;
    data['collect'] = collect;
    data['footmark'] = footmark;
    data['follow'] = follow;
    return data;
  }
}