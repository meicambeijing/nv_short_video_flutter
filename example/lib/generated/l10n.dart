// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  String get draft {
    return Intl.message(
      'Draft',
      name: 'draft',
      desc: '',
      args: [],
    );
  }

  String get appHomeTitle {
    return Intl.message(
      'Video Edit Home Page',
      name: 'appHomeTitle',
      desc: '',
      args: [],
    );
  }

  String get setting_item_dual {
    return Intl.message(
      'Dual',
      name: 'setting_item_dual',
      desc: '',
      args: [],
    );
  }

  String get setting_item_edit {
    return Intl.message(
      'Edit',
      name: 'setting_item_edit',
      desc: '',
      args: [],
    );
  }

  String get setting_item_capture {
    return Intl.message(
      'Capture',
      name: 'setting_item_capture',
      desc: '',
      args: [],
    );
  }

  String get Generating {
    return Intl.message(
      'Generating',
      name: 'Generating',
      desc: '',
      args: [],
    );
  }

  String get Publish {
    return Intl.message(
      'Publish',
      name: 'Publish',
      desc: '',
      args: [],
    );
  }

  String get Publish_Info {
    return Intl.message(
      'Write a headline and use the right topic to reach more people',
      name: 'Publish_Info',
      desc: '',
      args: [],
    );
  }

  String get add_description {
    return Intl.message(
      'Please add description ~',
      name: 'add_description',
      desc: '',
      args: [],
    );
  }

  String get compile_cancel {
    return Intl.message(
      'compile canceled',
      name: 'compile_cancel',
      desc: '',
      args: [],
    );
  }

  String get compile_fail {
    return Intl.message(
      'compile failure',
      name: 'compile_fail',
      desc: '',
      args: [],
    );
  }

  String get compile_suc {
    return Intl.message(
      'compile succeed',
      name: 'compile_suc',
      desc: '',
      args: [],
    );
  }

  String get Select_Cover {
    return Intl.message(
      'Select_Cover',
      name: 'Select_Cover',
      desc: '',
      args: [],
    );
  }

  String get save_draft {
    return Intl.message(
      'Save draft',
      name: 'save_draft',
      desc: '',
      args: [],
    );
  }

  String get Save_Image {
    return Intl.message(
      'Save Image',
      name: 'Save_Image',
      desc: '',
      args: [],
    );
  }

  String get save_suc {
    return Intl.message(
      'save_suc',
      name: 'save_suc',
      desc: '',
      args: [],
    );
  }

  String get save_failed {
    return Intl.message(
      'save_failed',
      name: 'save_failed',
      desc: '',
      args: [],
    );
  }

  String get Export {
    return Intl.message(
      'Export',
      name: 'Export',
      desc: '',
      args: [],
    );
  }

  String get right_delete {
    return Intl.message(
      'Right to delete',
      name: 'right_delete',
      desc: '',
      args: [],
    );
  }

  String get left_delete {
    return Intl.message(
      'Left to delete',
      name: 'left_delete',
      desc: '',
      args: [],
    );
  }

  String get text_placeholder {
    return Intl.message(
      'Write a headline and use the right topic to reach more people',
      name: 'text_placeholder',
      desc: '',
      args: [],
    );
  }

  String get new_materials {
    return Intl.message(
      'New Materials',
      name: 'new_materials',
      desc: '',
      args: [],
    );
  }

  String get select_function_noti {
    return Intl.message(
      'Please Select the Function You Need',
      name: 'select_function_noti',
      desc: '',
      args: [],
    );
  }

  String get function_list {
    return Intl.message(
      'Function List',
      name: 'function_list',
      desc: '',
      args: [],
    );
  }

  String get draft_noti {
    return Intl.message(
      'Reminder: Drafts will be deleted if the app is uninstalled',
      name: 'draft_noti',
      desc: '',
      args: [],
    );
  }

  String get Preview {
    return Intl.message(
      'Preview',
      name: 'Preview',
      desc: '',
      args: [],
    );
  }

  String get TryAgin {
    return Intl.message(
      'Retry',
      name: 'TryAgin',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
