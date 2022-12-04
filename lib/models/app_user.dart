class AppUser {
  String? id;
  String? email;
  String? fname;
  String? lname;
  String? phoneNumber;
  bool? isMale;
  AppUser(
    this.id,
    this.fname, this.lname, this.phoneNumber, this.email);
  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "fName": fname,
      "lName": lname,
      "phone": phoneNumber,
      "isMale": isMale
    };
  }
}
