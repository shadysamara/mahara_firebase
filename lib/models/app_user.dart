class AppUser {
  String? id;
  String? email;
  String? fname;
  String? lname;
  String? phoneNumber;
  String? imageUrl;
  bool? isMale;
  AppUser(
    this.id,
    this.fname,
    this.lname,
    this.phoneNumber,
    this.email, [
    this.imageUrl,
  ]);
  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "fName": fname,
      "lName": lname,
      "phone": phoneNumber,
      "isMale": isMale,
      "imageUrl": imageUrl
    };
  }

  AppUser.fromMap(Map<String, dynamic> map) {
    fname = map['fName'];
    lname = map['lName'];
    phoneNumber = map['phone'];
    email = map['email'];
    imageUrl = map['imageUrl'];
    isMale = map['isMale'];
  }
}
