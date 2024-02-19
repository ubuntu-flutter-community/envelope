// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String,
      imapServer: json['imapServer'] as String,
      imapUsername: json['imapUsername'] as String,
      imapPassword: json['imapPassword'] as String,
      smtpServer: json['smtpServer'] as String,
      smtpUsername: json['smtpUsername'] as String,
      smtpPassword: json['smtpPassword'] as String,
      profileImage: json['profileImage'] as String?,
      googleToken: json['googleToken'] as String?,
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'imapServer': instance.imapServer,
      'imapUsername': instance.imapUsername,
      'imapPassword': instance.imapPassword,
      'smtpServer': instance.smtpServer,
      'smtpUsername': instance.smtpUsername,
      'smtpPassword': instance.smtpPassword,
      'profileImage': instance.profileImage,
      'googleToken': instance.googleToken,
    };
