// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs,  constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String Angle1ValueKey = 'angle1';
const String Angle2ValueKey = 'angle2';
const String Angle3ValueKey = 'angle3';
const String Angle4ValueKey = 'angle4';
const String Angle5ValueKey = 'angle5';

final Map<String, TextEditingController> _ConfigViewTextEditingControllers = {};

final Map<String, FocusNode> _ConfigViewFocusNodes = {};

final Map<String, String? Function(String?)?> _ConfigViewTextValidations = {
  Angle1ValueKey: null,
  Angle2ValueKey: null,
  Angle3ValueKey: null,
  Angle4ValueKey: null,
  Angle5ValueKey: null,
};

mixin $ConfigView on StatelessWidget {
  TextEditingController get angle1Controller =>
      _getFormTextEditingController(Angle1ValueKey);
  TextEditingController get angle2Controller =>
      _getFormTextEditingController(Angle2ValueKey);
  TextEditingController get angle3Controller =>
      _getFormTextEditingController(Angle3ValueKey);
  TextEditingController get angle4Controller =>
      _getFormTextEditingController(Angle4ValueKey);
  TextEditingController get angle5Controller =>
      _getFormTextEditingController(Angle5ValueKey);
  FocusNode get angle1FocusNode => _getFormFocusNode(Angle1ValueKey);
  FocusNode get angle2FocusNode => _getFormFocusNode(Angle2ValueKey);
  FocusNode get angle3FocusNode => _getFormFocusNode(Angle3ValueKey);
  FocusNode get angle4FocusNode => _getFormFocusNode(Angle4ValueKey);
  FocusNode get angle5FocusNode => _getFormFocusNode(Angle5ValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
    if (_ConfigViewTextEditingControllers.containsKey(key)) {
      return _ConfigViewTextEditingControllers[key]!;
    }
    _ConfigViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _ConfigViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_ConfigViewFocusNodes.containsKey(key)) {
      return _ConfigViewFocusNodes[key]!;
    }
    _ConfigViewFocusNodes[key] = FocusNode();
    return _ConfigViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    angle1Controller.addListener(() => _updateFormData(model));
    angle2Controller.addListener(() => _updateFormData(model));
    angle3Controller.addListener(() => _updateFormData(model));
    angle4Controller.addListener(() => _updateFormData(model));
    angle5Controller.addListener(() => _updateFormData(model));
  }

  final bool _autoTextFieldValidation = true;
  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          Angle1ValueKey: angle1Controller.text,
          Angle2ValueKey: angle2Controller.text,
          Angle3ValueKey: angle3Controller.text,
          Angle4ValueKey: angle4Controller.text,
          Angle5ValueKey: angle5Controller.text,
        }),
    );
    if (_autoTextFieldValidation || forceValidate) {
      _updateValidationData(model);
    }
  }

  /// Updates the fieldsValidationMessages on the FormViewModel
  void _updateValidationData(FormViewModel model) =>
      model.setValidationMessages({
        Angle1ValueKey: _getValidationMessage(Angle1ValueKey),
        Angle2ValueKey: _getValidationMessage(Angle2ValueKey),
        Angle3ValueKey: _getValidationMessage(Angle3ValueKey),
        Angle4ValueKey: _getValidationMessage(Angle4ValueKey),
        Angle5ValueKey: _getValidationMessage(Angle5ValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey = _ConfigViewTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey =
        validatorForKey(_ConfigViewTextEditingControllers[key]!.text);
    return validationMessageForKey;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _ConfigViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _ConfigViewFocusNodes.values) {
      focusNode.dispose();
    }

    _ConfigViewTextEditingControllers.clear();
    _ConfigViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get angle1Value => this.formValueMap[Angle1ValueKey] as String?;
  String? get angle2Value => this.formValueMap[Angle2ValueKey] as String?;
  String? get angle3Value => this.formValueMap[Angle3ValueKey] as String?;
  String? get angle4Value => this.formValueMap[Angle4ValueKey] as String?;
  String? get angle5Value => this.formValueMap[Angle5ValueKey] as String?;

  bool get hasAngle1 => this.formValueMap.containsKey(Angle1ValueKey);
  bool get hasAngle2 => this.formValueMap.containsKey(Angle2ValueKey);
  bool get hasAngle3 => this.formValueMap.containsKey(Angle3ValueKey);
  bool get hasAngle4 => this.formValueMap.containsKey(Angle4ValueKey);
  bool get hasAngle5 => this.formValueMap.containsKey(Angle5ValueKey);

  bool get hasAngle1ValidationMessage =>
      this.fieldsValidationMessages[Angle1ValueKey]?.isNotEmpty ?? false;
  bool get hasAngle2ValidationMessage =>
      this.fieldsValidationMessages[Angle2ValueKey]?.isNotEmpty ?? false;
  bool get hasAngle3ValidationMessage =>
      this.fieldsValidationMessages[Angle3ValueKey]?.isNotEmpty ?? false;
  bool get hasAngle4ValidationMessage =>
      this.fieldsValidationMessages[Angle4ValueKey]?.isNotEmpty ?? false;
  bool get hasAngle5ValidationMessage =>
      this.fieldsValidationMessages[Angle5ValueKey]?.isNotEmpty ?? false;

  String? get angle1ValidationMessage =>
      this.fieldsValidationMessages[Angle1ValueKey];
  String? get angle2ValidationMessage =>
      this.fieldsValidationMessages[Angle2ValueKey];
  String? get angle3ValidationMessage =>
      this.fieldsValidationMessages[Angle3ValueKey];
  String? get angle4ValidationMessage =>
      this.fieldsValidationMessages[Angle4ValueKey];
  String? get angle5ValidationMessage =>
      this.fieldsValidationMessages[Angle5ValueKey];
}

extension Methods on FormViewModel {
  setAngle1ValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[Angle1ValueKey] = validationMessage;
  setAngle2ValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[Angle2ValueKey] = validationMessage;
  setAngle3ValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[Angle3ValueKey] = validationMessage;
  setAngle4ValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[Angle4ValueKey] = validationMessage;
  setAngle5ValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[Angle5ValueKey] = validationMessage;
}
