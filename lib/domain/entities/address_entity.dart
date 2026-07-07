class AddressEntity {
  final String cep;
  final String street;
  final String neighborhood;
  final String city;
  final String state;

  const AddressEntity({
    required this.cep,
    required this.street,
    required this.neighborhood,
    required this.city,
    required this.state,
  });
}