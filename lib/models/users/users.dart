
class pharmappUser {

  final String id;
  final String fullname;
  final String email;
  final String password;
  final String profile_pic_url;
  //final List<String> addresses;
  //final List<String> fav_pharms;
  //final List<String> pre_orders;

  pharmappUser({required this.id, required this.fullname, required this.email, required this.password, required this.profile_pic_url});//, required this.addresses, required this.fav_pharms, required this.pre_orders});

  /*@override
  String toString () {
    return id + ' ' + addresses.isEmpty.toString() + ' '; 
  }*/

  /*pharmappUser initial() {
    return pharmappUser(id:'', fullname: '', email: '', password: '', profile_pic_url: "", addresses: [], fav_pharms: [],pre_orders: []);
  }*/
}