import '../../styles/style.dart';

abstract class Validator {
  final String errorText;
  final List<Validator> _validators;

  Validator(this.errorText, List<Validator> children) : _validators = children;

  String? validate(String? value);

  @protected
  String? validateChildren(String? value) {
    for (final validator in _validators) {
      final error = validator.validate(value);
      if (error != null) {
        return error;
      }
    }
    return null;
  }

  static String? Function(String?) validateAll(List<Validator> validators) {
    return CompositeValidator(validators).validate;
  }
}

class CompositeValidator extends Validator {
  CompositeValidator(List<Validator> children) : super('', children);

  @override
  String? validate(String? value) {
    return validateChildren(value);
  }
}

class PhoneValidator extends Validator {
  PhoneValidator(String errorText) : super(errorText, []);

  @override
  String? validate(String? value) {
    if (value![0] != '0') {
      return errorText;
    }
    return null;
  }
}
