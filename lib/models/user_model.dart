class User {
  final String name;
  final String city;
  final String state;
  final String email;
  final String phone;
  final String address;
  
  User({
    required this.name,
    required this.city,
    required this.state,
    required this.email,
    required this.phone,
    required this.address,
  });
  
  User copyWith({
    String? name,
    String? city,
    String? state,
    String? email,
    String? phone,
    String? address,
  }) {
    return User(
      name: name ?? this.name,
      city: city ?? this.city,
      state: state ?? this.state,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }
}