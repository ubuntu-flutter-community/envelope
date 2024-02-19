import 'package:envelope/db/db.dart';
import 'package:envelope/db/models/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ubuntu_service/ubuntu_service.dart';
import 'package:yaru_icons/yaru_icons.dart';

class AccountPicker extends HookWidget {
  final int initialAccount;
  final Function(Account) setAccount;

  const AccountPicker(
      {super.key, required this.setAccount, required this.initialAccount});

  @override
  Widget build(BuildContext context) {
    final db = getService<DBService>();

    final accounts = useFuture(useMemoized(() => db.getAccounts()));
    final accountId = useState(initialAccount);
    final account = useMemoized(
        () => accounts.data
            ?.firstWhere((element) => element.id == accountId.value),
        [accountId]);
    useEffect(() => account != null ? setAccount(account) : [], [account]);

    return account?.profileImage != null
        ? Image.network(account!.profileImage!)
        : const Icon(YaruIcons.user);
  }
}
