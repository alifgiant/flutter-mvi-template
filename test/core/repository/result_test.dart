import 'package:aset_ku/core/network/network_respose.dart';
import 'package:aset_ku/core/repository/repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_data/mock_data.dart';

main() {
  test('result state helper is correct', () {
    final res1 = Result.success(mockString());
    assert(res1.isSuccess);
    assert(!res1.isError);
    assert(!res1.isUnknown);

    final res2 = Result.error(Failure(mockString()));
    assert(!res2.isSuccess);
    assert(res2.isError);
    assert(!res2.isUnknown);

    final res3 = Result.internal(null, StringResponse(mockString()), null);
    assert(!res3.isSuccess);
    assert(!res3.isError);
    assert(res3.isUnknown);
  });
}
