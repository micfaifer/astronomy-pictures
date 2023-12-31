// Mocks generated by Mockito 5.4.2 from annotations
// in astronomy_pictures/test/viewmodel/apod_viewmodel_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:astronomy_pictures/data/data_manager.dart' as _i2;
import 'package:astronomy_pictures/models/apod.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [DataManager].
///
/// See the documentation for Mockito's code generation for more information.
class MockDataManager extends _i1.Mock implements _i2.DataManager {
  @override
  _i3.Future<List<_i4.Apod>> getAstronomyPictures(
    DateTime? startDate,
    DateTime? endDate,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAstronomyPictures,
          [
            startDate,
            endDate,
          ],
        ),
        returnValue: _i3.Future<List<_i4.Apod>>.value(<_i4.Apod>[]),
        returnValueForMissingStub:
            _i3.Future<List<_i4.Apod>>.value(<_i4.Apod>[]),
      ) as _i3.Future<List<_i4.Apod>>);
  @override
  _i3.Future<List<_i4.Apod>> getLocalAstronomyPictures() => (super.noSuchMethod(
        Invocation.method(
          #getLocalAstronomyPictures,
          [],
        ),
        returnValue: _i3.Future<List<_i4.Apod>>.value(<_i4.Apod>[]),
        returnValueForMissingStub:
            _i3.Future<List<_i4.Apod>>.value(<_i4.Apod>[]),
      ) as _i3.Future<List<_i4.Apod>>);
}
