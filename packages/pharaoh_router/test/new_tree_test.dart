import 'package:pharaoh/pharaoh.dart';
import 'package:pharaoh_router/pharaoh_router.dart';
import 'package:pharaoh_router/src/tree_node.dart';
import 'package:test/test.dart';

import 'helpers/matchers.dart';

void main() {
  // test('parametric route, request.url contains dash', () {
  //   final config = const RadixRouterConfig(caseSensitive: false);
  //   final router = RadixRouter(config: config)
  //     ..on(HTTPMethod.GET, '/a/:param/b');

  //   final result = router.lookup(HTTPMethod.GET, '/a/foo-bar/b');
  //   expect(result?.value, {'param': 'foo-bar'});
  // });

  test('parametric route with fixed suffix', () async {
    final config = const RadixRouterConfig(caseSensitive: false);
    final router = RadixRouter(config: config)
      ..on(HTTPMethod.GET, '/user')
      ..on(HTTPMethod.GET, '/user/<userId>')
      ..on(HTTPMethod.GET, '/user/<userId>/details')
      ..on(HTTPMethod.GET, '/user/<file>.png/download')
      ..printTree();

    var node = router.lookup(HTTPMethod.GET, '/user');
    expect(node, hasStaticNode('user'));

    node = router.lookup(HTTPMethod.GET, '/user/24');
    expect(node, havingParameters({'userId': '24'}));

    node = router.lookup(HTTPMethod.GET, '/user/3948/details');
    expect(node, havingParameters({'userId': '3948'}));

    node = router.lookup(HTTPMethod.GET, '/user/aws-image.png/download');
    expect(node, havingParameters({'file': 'aws-image'}));
  });
}
