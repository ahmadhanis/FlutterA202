mixin Validator {
  String validateString(String value) {
    if (value.isEmpty || value == '') {
      return 'The field must not be empty';
    }
    return null;
  }

  String validatePrice(String value) {
    double parsedValue = double.tryParse(value);
    if (value.isEmpty) {
      return 'The price must not be empty';
    }
    if (parsedValue != null && parsedValue <= 0) {
      return 'The price should be greater than 0';
    }
    return null;
  }

  String validateQuantity(String value) {
    int parsedValue = int.tryParse(value);
    if (value.isEmpty) {
      return 'The quantity must not be empty';
    }
    if (parsedValue != null && parsedValue <= 0) {
      return 'The quantity should be greater than 0';
    }
    if (parsedValue == null) {
      return 'The quantity should a whole number';
    }
    return null;
  }
}
