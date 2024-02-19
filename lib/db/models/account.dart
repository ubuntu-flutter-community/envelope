import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable()
class Account {
  final int? id;
  final String? name;
  final String email;
  final String imapServer;
  final String imapUsername;
  final String imapPassword;
  final String smtpServer;
  final String smtpUsername;
  final String smtpPassword;
  final String? profileImage;
  final String? googleToken;

  Account(
      {this.id,
      this.name,
      required this.email,
      required this.imapServer,
      required this.imapUsername,
      required this.imapPassword,
      required this.smtpServer,
      required this.smtpUsername,
      required this.smtpPassword,
      this.profileImage,
      this.googleToken});

  static const tableName = 'accounts';

  static const create = '''
      CREATE TABLE IF NOT EXISTS $tableName (
        id INTEGER PRIMARY KEY,
        name TEXT,
        email TEXT NOT NULL,
        imapServer TEXT NOT NULL,
        imapUsername TEXT NOT NULL,
        imapPassword TEXT NOT NULL,
        smtpServer TEXT NOT NULL,
        smtpUsername TEXT NOT NULL,
        smtpPassword TEXT NOT NULL,
        profileImage TEXT,
        googleToken TEXT
      );
      ''';

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
