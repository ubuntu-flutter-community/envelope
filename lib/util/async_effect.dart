// https://github.com/rrousselGit/flutter_hooks/issues/153#issuecomment-866818706
import 'package:flutter_hooks/flutter_hooks.dart';

void useAsyncEffect(Future<Dispose?> Function() effect, [List<Object?>? keys]) {
  useEffect(() {
    final disposeFuture = Future.microtask(effect);
    return () => disposeFuture.then((dispose) => dispose?.call());
  }, keys);
}