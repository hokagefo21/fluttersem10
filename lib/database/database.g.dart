// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class Users extends Table with TableInfo<Users, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Users(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'PRIMARY KEY AUTOINCREMENT',
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (length(trim(name)) > 0)',
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL COLLATE NOCASE UNIQUE CHECK (length(trim(email)) > 0)',
  );
  static const VerificationMeta _registeredMeta = const VerificationMeta(
    'registered',
  );
  late final GeneratedColumn<String> registered = GeneratedColumn<String>(
    'registered',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, email, registered];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('registered')) {
      context.handle(
        _registeredMeta,
        registered.isAcceptableOrUnknown(data['registered']!, _registeredMeta),
      );
    } else if (isInserting) {
      context.missing(_registeredMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      registered: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}registered'],
      )!,
    );
  }

  @override
  Users createAlias(String alias) {
    return Users(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String name;
  final String email;
  final String registered;
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.registered,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    map['registered'] = Variable<String>(registered);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: Value(name),
      email: Value(email),
      registered: Value(registered),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      registered: serializer.fromJson<String>(json['registered']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'registered': serializer.toJson<String>(registered),
    };
  }

  User copyWith({int? id, String? name, String? email, String? registered}) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        registered: registered ?? this.registered,
      );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      registered: data.registered.present
          ? data.registered.value
          : this.registered,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('registered: $registered')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, email, registered);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.registered == this.registered);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> email;
  final Value<String> registered;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.registered = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String email,
    required String registered,
  }) : name = Value(name),
       email = Value(email),
       registered = Value(registered);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? registered,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (registered != null) 'registered': registered,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? email,
    Value<String>? registered,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      registered: registered ?? this.registered,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (registered.present) {
      map['registered'] = Variable<String>(registered.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('registered: $registered')
          ..write(')'))
        .toString();
  }
}

class Projects extends Table with TableInfo<Projects, Project> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Projects(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'PRIMARY KEY AUTOINCREMENT',
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (length(trim(name)) > 0)',
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _createdMeta = const VerificationMeta(
    'created',
  );
  late final GeneratedColumn<String> created = GeneratedColumn<String>(
    'created',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _finishMeta = const VerificationMeta('finish');
  late final GeneratedColumn<String> finish = GeneratedColumn<String>(
    'finish',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'CHECK (finish IS NULL OR finish >= created)',
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (status IN (\'active\', \'completed\', \'archived\'))',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    created,
    finish,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'projects';
  @override
  VerificationContext validateIntegrity(
    Insertable<Project> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('created')) {
      context.handle(
        _createdMeta,
        created.isAcceptableOrUnknown(data['created']!, _createdMeta),
      );
    } else if (isInserting) {
      context.missing(_createdMeta);
    }
    if (data.containsKey('finish')) {
      context.handle(
        _finishMeta,
        finish.isAcceptableOrUnknown(data['finish']!, _finishMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Project map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Project(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      created: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created'],
      )!,
      finish: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}finish'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  Projects createAlias(String alias) {
    return Projects(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Project extends DataClass implements Insertable<Project> {
  final int id;
  final String name;
  final String description;
  final String created;
  final String? finish;
  final String status;
  const Project({
    required this.id,
    required this.name,
    required this.description,
    required this.created,
    this.finish,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['created'] = Variable<String>(created);
    if (!nullToAbsent || finish != null) {
      map['finish'] = Variable<String>(finish);
    }
    map['status'] = Variable<String>(status);
    return map;
  }

  ProjectsCompanion toCompanion(bool nullToAbsent) {
    return ProjectsCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      created: Value(created),
      finish: finish == null && nullToAbsent
          ? const Value.absent()
          : Value(finish),
      status: Value(status),
    );
  }

  factory Project.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Project(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      created: serializer.fromJson<String>(json['created']),
      finish: serializer.fromJson<String?>(json['finish']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'created': serializer.toJson<String>(created),
      'finish': serializer.toJson<String?>(finish),
      'status': serializer.toJson<String>(status),
    };
  }

  Project copyWith({
    int? id,
    String? name,
    String? description,
    String? created,
    Value<String?> finish = const Value.absent(),
    String? status,
  }) => Project(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    created: created ?? this.created,
    finish: finish.present ? finish.value : this.finish,
    status: status ?? this.status,
  );
  Project copyWithCompanion(ProjectsCompanion data) {
    return Project(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      created: data.created.present ? data.created.value : this.created,
      finish: data.finish.present ? data.finish.value : this.finish,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Project(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('created: $created, ')
          ..write('finish: $finish, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, created, finish, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Project &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.created == this.created &&
          other.finish == this.finish &&
          other.status == this.status);
}

class ProjectsCompanion extends UpdateCompanion<Project> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String> created;
  final Value<String?> finish;
  final Value<String> status;
  const ProjectsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.created = const Value.absent(),
    this.finish = const Value.absent(),
    this.status = const Value.absent(),
  });
  ProjectsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String description,
    required String created,
    this.finish = const Value.absent(),
    required String status,
  }) : name = Value(name),
       description = Value(description),
       created = Value(created),
       status = Value(status);
  static Insertable<Project> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? created,
    Expression<String>? finish,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (created != null) 'created': created,
      if (finish != null) 'finish': finish,
      if (status != null) 'status': status,
    });
  }

  ProjectsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? description,
    Value<String>? created,
    Value<String?>? finish,
    Value<String>? status,
  }) {
    return ProjectsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      created: created ?? this.created,
      finish: finish ?? this.finish,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (created.present) {
      map['created'] = Variable<String>(created.value);
    }
    if (finish.present) {
      map['finish'] = Variable<String>(finish.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('created: $created, ')
          ..write('finish: $finish, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class ProjectMembers extends Table
    with TableInfo<ProjectMembers, ProjectMember> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ProjectMembers(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  late final GeneratedColumn<int> projectId = GeneratedColumn<int>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES projects(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES users(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (role IN (\'Owner\', \'Admin\', \'Member\'))',
  );
  @override
  List<GeneratedColumn> get $columns => [projectId, userId, role];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'project_members';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProjectMember> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {projectId, userId};
  @override
  ProjectMember map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProjectMember(
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}project_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
    );
  }

  @override
  ProjectMembers createAlias(String alias) {
    return ProjectMembers(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(project_id, user_id)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class ProjectMember extends DataClass implements Insertable<ProjectMember> {
  final int projectId;
  final int userId;
  final String role;
  const ProjectMember({
    required this.projectId,
    required this.userId,
    required this.role,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['project_id'] = Variable<int>(projectId);
    map['user_id'] = Variable<int>(userId);
    map['role'] = Variable<String>(role);
    return map;
  }

  ProjectMembersCompanion toCompanion(bool nullToAbsent) {
    return ProjectMembersCompanion(
      projectId: Value(projectId),
      userId: Value(userId),
      role: Value(role),
    );
  }

  factory ProjectMember.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProjectMember(
      projectId: serializer.fromJson<int>(json['project_id']),
      userId: serializer.fromJson<int>(json['user_id']),
      role: serializer.fromJson<String>(json['role']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'project_id': serializer.toJson<int>(projectId),
      'user_id': serializer.toJson<int>(userId),
      'role': serializer.toJson<String>(role),
    };
  }

  ProjectMember copyWith({int? projectId, int? userId, String? role}) =>
      ProjectMember(
        projectId: projectId ?? this.projectId,
        userId: userId ?? this.userId,
        role: role ?? this.role,
      );
  ProjectMember copyWithCompanion(ProjectMembersCompanion data) {
    return ProjectMember(
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      userId: data.userId.present ? data.userId.value : this.userId,
      role: data.role.present ? data.role.value : this.role,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProjectMember(')
          ..write('projectId: $projectId, ')
          ..write('userId: $userId, ')
          ..write('role: $role')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(projectId, userId, role);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProjectMember &&
          other.projectId == this.projectId &&
          other.userId == this.userId &&
          other.role == this.role);
}

class ProjectMembersCompanion extends UpdateCompanion<ProjectMember> {
  final Value<int> projectId;
  final Value<int> userId;
  final Value<String> role;
  final Value<int> rowid;
  const ProjectMembersCompanion({
    this.projectId = const Value.absent(),
    this.userId = const Value.absent(),
    this.role = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProjectMembersCompanion.insert({
    required int projectId,
    required int userId,
    required String role,
    this.rowid = const Value.absent(),
  }) : projectId = Value(projectId),
       userId = Value(userId),
       role = Value(role);
  static Insertable<ProjectMember> custom({
    Expression<int>? projectId,
    Expression<int>? userId,
    Expression<String>? role,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (projectId != null) 'project_id': projectId,
      if (userId != null) 'user_id': userId,
      if (role != null) 'role': role,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProjectMembersCompanion copyWith({
    Value<int>? projectId,
    Value<int>? userId,
    Value<String>? role,
    Value<int>? rowid,
  }) {
    return ProjectMembersCompanion(
      projectId: projectId ?? this.projectId,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (projectId.present) {
      map['project_id'] = Variable<int>(projectId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectMembersCompanion(')
          ..write('projectId: $projectId, ')
          ..write('userId: $userId, ')
          ..write('role: $role, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Tasks extends Table with TableInfo<Tasks, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Tasks(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'PRIMARY KEY AUTOINCREMENT',
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (length(trim(title)) > 0)',
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  late final GeneratedColumn<int> projectId = GeneratedColumn<int>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES projects(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _assigneeMeta = const VerificationMeta(
    'assignee',
  );
  late final GeneratedColumn<int> assignee = GeneratedColumn<int>(
    'assignee',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES users(id)ON DELETE SET NULL',
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (status IN (\'todo\', \'inProgress\', \'done\', \'cancelled\'))',
  );
  static const VerificationMeta _deadlineMeta = const VerificationMeta(
    'deadline',
  );
  late final GeneratedColumn<String> deadline = GeneratedColumn<String>(
    'deadline',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _createdMeta = const VerificationMeta(
    'created',
  );
  late final GeneratedColumn<int> created = GeneratedColumn<int>(
    'created',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _updatedMeta = const VerificationMeta(
    'updated',
  );
  late final GeneratedColumn<int> updated = GeneratedColumn<int>(
    'updated',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT \'medium\' CHECK (priority IN (\'low\', \'medium\', \'high\', \'critical\'))',
    defaultValue: const CustomExpression('\'medium\''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    projectId,
    assignee,
    status,
    deadline,
    created,
    updated,
    deletedAt,
    priority,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Task> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('assignee')) {
      context.handle(
        _assigneeMeta,
        assignee.isAcceptableOrUnknown(data['assignee']!, _assigneeMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('deadline')) {
      context.handle(
        _deadlineMeta,
        deadline.isAcceptableOrUnknown(data['deadline']!, _deadlineMeta),
      );
    } else if (isInserting) {
      context.missing(_deadlineMeta);
    }
    if (data.containsKey('created')) {
      context.handle(
        _createdMeta,
        created.isAcceptableOrUnknown(data['created']!, _createdMeta),
      );
    } else if (isInserting) {
      context.missing(_createdMeta);
    }
    if (data.containsKey('updated')) {
      context.handle(
        _updatedMeta,
        updated.isAcceptableOrUnknown(data['updated']!, _updatedMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}project_id'],
      )!,
      assignee: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}assignee'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      deadline: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deadline'],
      )!,
      created: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created'],
      )!,
      updated: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}priority'],
      )!,
    );
  }

  @override
  Tasks createAlias(String alias) {
    return Tasks(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Task extends DataClass implements Insertable<Task> {
  final int id;
  final String title;
  final String description;
  final int projectId;
  final int? assignee;
  final String status;
  final String deadline;
  final int created;
  final int updated;
  final int? deletedAt;
  final String priority;
  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.projectId,
    this.assignee,
    required this.status,
    required this.deadline,
    required this.created,
    required this.updated,
    this.deletedAt,
    required this.priority,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['project_id'] = Variable<int>(projectId);
    if (!nullToAbsent || assignee != null) {
      map['assignee'] = Variable<int>(assignee);
    }
    map['status'] = Variable<String>(status);
    map['deadline'] = Variable<String>(deadline);
    map['created'] = Variable<int>(created);
    map['updated'] = Variable<int>(updated);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    map['priority'] = Variable<String>(priority);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      projectId: Value(projectId),
      assignee: assignee == null && nullToAbsent
          ? const Value.absent()
          : Value(assignee),
      status: Value(status),
      deadline: Value(deadline),
      created: Value(created),
      updated: Value(updated),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      priority: Value(priority),
    );
  }

  factory Task.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      projectId: serializer.fromJson<int>(json['project_id']),
      assignee: serializer.fromJson<int?>(json['assignee']),
      status: serializer.fromJson<String>(json['status']),
      deadline: serializer.fromJson<String>(json['deadline']),
      created: serializer.fromJson<int>(json['created']),
      updated: serializer.fromJson<int>(json['updated']),
      deletedAt: serializer.fromJson<int?>(json['deleted_at']),
      priority: serializer.fromJson<String>(json['priority']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'project_id': serializer.toJson<int>(projectId),
      'assignee': serializer.toJson<int?>(assignee),
      'status': serializer.toJson<String>(status),
      'deadline': serializer.toJson<String>(deadline),
      'created': serializer.toJson<int>(created),
      'updated': serializer.toJson<int>(updated),
      'deleted_at': serializer.toJson<int?>(deletedAt),
      'priority': serializer.toJson<String>(priority),
    };
  }

  Task copyWith({
    int? id,
    String? title,
    String? description,
    int? projectId,
    Value<int?> assignee = const Value.absent(),
    String? status,
    String? deadline,
    int? created,
    int? updated,
    Value<int?> deletedAt = const Value.absent(),
    String? priority,
  }) => Task(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    projectId: projectId ?? this.projectId,
    assignee: assignee.present ? assignee.value : this.assignee,
    status: status ?? this.status,
    deadline: deadline ?? this.deadline,
    created: created ?? this.created,
    updated: updated ?? this.updated,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    priority: priority ?? this.priority,
  );
  Task copyWithCompanion(TasksCompanion data) {
    return Task(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      assignee: data.assignee.present ? data.assignee.value : this.assignee,
      status: data.status.present ? data.status.value : this.status,
      deadline: data.deadline.present ? data.deadline.value : this.deadline,
      created: data.created.present ? data.created.value : this.created,
      updated: data.updated.present ? data.updated.value : this.updated,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      priority: data.priority.present ? data.priority.value : this.priority,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('projectId: $projectId, ')
          ..write('assignee: $assignee, ')
          ..write('status: $status, ')
          ..write('deadline: $deadline, ')
          ..write('created: $created, ')
          ..write('updated: $updated, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('priority: $priority')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    projectId,
    assignee,
    status,
    deadline,
    created,
    updated,
    deletedAt,
    priority,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.projectId == this.projectId &&
          other.assignee == this.assignee &&
          other.status == this.status &&
          other.deadline == this.deadline &&
          other.created == this.created &&
          other.updated == this.updated &&
          other.deletedAt == this.deletedAt &&
          other.priority == this.priority);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> description;
  final Value<int> projectId;
  final Value<int?> assignee;
  final Value<String> status;
  final Value<String> deadline;
  final Value<int> created;
  final Value<int> updated;
  final Value<int?> deletedAt;
  final Value<String> priority;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.projectId = const Value.absent(),
    this.assignee = const Value.absent(),
    this.status = const Value.absent(),
    this.deadline = const Value.absent(),
    this.created = const Value.absent(),
    this.updated = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.priority = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String description,
    required int projectId,
    this.assignee = const Value.absent(),
    required String status,
    required String deadline,
    required int created,
    required int updated,
    this.deletedAt = const Value.absent(),
    this.priority = const Value.absent(),
  }) : title = Value(title),
       description = Value(description),
       projectId = Value(projectId),
       status = Value(status),
       deadline = Value(deadline),
       created = Value(created),
       updated = Value(updated);
  static Insertable<Task> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<int>? projectId,
    Expression<int>? assignee,
    Expression<String>? status,
    Expression<String>? deadline,
    Expression<int>? created,
    Expression<int>? updated,
    Expression<int>? deletedAt,
    Expression<String>? priority,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (projectId != null) 'project_id': projectId,
      if (assignee != null) 'assignee': assignee,
      if (status != null) 'status': status,
      if (deadline != null) 'deadline': deadline,
      if (created != null) 'created': created,
      if (updated != null) 'updated': updated,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (priority != null) 'priority': priority,
    });
  }

  TasksCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? description,
    Value<int>? projectId,
    Value<int?>? assignee,
    Value<String>? status,
    Value<String>? deadline,
    Value<int>? created,
    Value<int>? updated,
    Value<int?>? deletedAt,
    Value<String>? priority,
  }) {
    return TasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      projectId: projectId ?? this.projectId,
      assignee: assignee ?? this.assignee,
      status: status ?? this.status,
      deadline: deadline ?? this.deadline,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      deletedAt: deletedAt ?? this.deletedAt,
      priority: priority ?? this.priority,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<int>(projectId.value);
    }
    if (assignee.present) {
      map['assignee'] = Variable<int>(assignee.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (deadline.present) {
      map['deadline'] = Variable<String>(deadline.value);
    }
    if (created.present) {
      map['created'] = Variable<int>(created.value);
    }
    if (updated.present) {
      map['updated'] = Variable<int>(updated.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('projectId: $projectId, ')
          ..write('assignee: $assignee, ')
          ..write('status: $status, ')
          ..write('deadline: $deadline, ')
          ..write('created: $created, ')
          ..write('updated: $updated, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('priority: $priority')
          ..write(')'))
        .toString();
  }
}

class Comments extends Table with TableInfo<Comments, Comment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Comments(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'PRIMARY KEY AUTOINCREMENT',
  );
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  late final GeneratedColumn<int> taskId = GeneratedColumn<int>(
    'task_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES tasks(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  late final GeneratedColumn<int> author = GeneratedColumn<int>(
    'author',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES users(id)ON DELETE SET NULL',
  );
  static const VerificationMeta _authorNameMeta = const VerificationMeta(
    'authorName',
  );
  late final GeneratedColumn<String> authorName = GeneratedColumn<String>(
    'author_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (length(trim(body)) > 0)',
  );
  static const VerificationMeta _createdMeta = const VerificationMeta(
    'created',
  );
  late final GeneratedColumn<int> created = GeneratedColumn<int>(
    'created',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    taskId,
    author,
    authorName,
    body,
    created,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'comments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Comment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('task_id')) {
      context.handle(
        _taskIdMeta,
        taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta),
      );
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    }
    if (data.containsKey('author_name')) {
      context.handle(
        _authorNameMeta,
        authorName.isAcceptableOrUnknown(data['author_name']!, _authorNameMeta),
      );
    } else if (isInserting) {
      context.missing(_authorNameMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('created')) {
      context.handle(
        _createdMeta,
        created.isAcceptableOrUnknown(data['created']!, _createdMeta),
      );
    } else if (isInserting) {
      context.missing(_createdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Comment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Comment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      taskId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}task_id'],
      )!,
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}author'],
      ),
      authorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author_name'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      created: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created'],
      )!,
    );
  }

  @override
  Comments createAlias(String alias) {
    return Comments(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Comment extends DataClass implements Insertable<Comment> {
  final int id;
  final int taskId;
  final int? author;
  final String authorName;
  final String body;
  final int created;
  const Comment({
    required this.id,
    required this.taskId,
    this.author,
    required this.authorName,
    required this.body,
    required this.created,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['task_id'] = Variable<int>(taskId);
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<int>(author);
    }
    map['author_name'] = Variable<String>(authorName);
    map['body'] = Variable<String>(body);
    map['created'] = Variable<int>(created);
    return map;
  }

  CommentsCompanion toCompanion(bool nullToAbsent) {
    return CommentsCompanion(
      id: Value(id),
      taskId: Value(taskId),
      author: author == null && nullToAbsent
          ? const Value.absent()
          : Value(author),
      authorName: Value(authorName),
      body: Value(body),
      created: Value(created),
    );
  }

  factory Comment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Comment(
      id: serializer.fromJson<int>(json['id']),
      taskId: serializer.fromJson<int>(json['task_id']),
      author: serializer.fromJson<int?>(json['author']),
      authorName: serializer.fromJson<String>(json['author_name']),
      body: serializer.fromJson<String>(json['body']),
      created: serializer.fromJson<int>(json['created']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'task_id': serializer.toJson<int>(taskId),
      'author': serializer.toJson<int?>(author),
      'author_name': serializer.toJson<String>(authorName),
      'body': serializer.toJson<String>(body),
      'created': serializer.toJson<int>(created),
    };
  }

  Comment copyWith({
    int? id,
    int? taskId,
    Value<int?> author = const Value.absent(),
    String? authorName,
    String? body,
    int? created,
  }) => Comment(
    id: id ?? this.id,
    taskId: taskId ?? this.taskId,
    author: author.present ? author.value : this.author,
    authorName: authorName ?? this.authorName,
    body: body ?? this.body,
    created: created ?? this.created,
  );
  Comment copyWithCompanion(CommentsCompanion data) {
    return Comment(
      id: data.id.present ? data.id.value : this.id,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      author: data.author.present ? data.author.value : this.author,
      authorName: data.authorName.present
          ? data.authorName.value
          : this.authorName,
      body: data.body.present ? data.body.value : this.body,
      created: data.created.present ? data.created.value : this.created,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Comment(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('author: $author, ')
          ..write('authorName: $authorName, ')
          ..write('body: $body, ')
          ..write('created: $created')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, taskId, author, authorName, body, created);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Comment &&
          other.id == this.id &&
          other.taskId == this.taskId &&
          other.author == this.author &&
          other.authorName == this.authorName &&
          other.body == this.body &&
          other.created == this.created);
}

class CommentsCompanion extends UpdateCompanion<Comment> {
  final Value<int> id;
  final Value<int> taskId;
  final Value<int?> author;
  final Value<String> authorName;
  final Value<String> body;
  final Value<int> created;
  const CommentsCompanion({
    this.id = const Value.absent(),
    this.taskId = const Value.absent(),
    this.author = const Value.absent(),
    this.authorName = const Value.absent(),
    this.body = const Value.absent(),
    this.created = const Value.absent(),
  });
  CommentsCompanion.insert({
    this.id = const Value.absent(),
    required int taskId,
    this.author = const Value.absent(),
    required String authorName,
    required String body,
    required int created,
  }) : taskId = Value(taskId),
       authorName = Value(authorName),
       body = Value(body),
       created = Value(created);
  static Insertable<Comment> custom({
    Expression<int>? id,
    Expression<int>? taskId,
    Expression<int>? author,
    Expression<String>? authorName,
    Expression<String>? body,
    Expression<int>? created,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskId != null) 'task_id': taskId,
      if (author != null) 'author': author,
      if (authorName != null) 'author_name': authorName,
      if (body != null) 'body': body,
      if (created != null) 'created': created,
    });
  }

  CommentsCompanion copyWith({
    Value<int>? id,
    Value<int>? taskId,
    Value<int?>? author,
    Value<String>? authorName,
    Value<String>? body,
    Value<int>? created,
  }) {
    return CommentsCompanion(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      author: author ?? this.author,
      authorName: authorName ?? this.authorName,
      body: body ?? this.body,
      created: created ?? this.created,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<int>(taskId.value);
    }
    if (author.present) {
      map['author'] = Variable<int>(author.value);
    }
    if (authorName.present) {
      map['author_name'] = Variable<String>(authorName.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (created.present) {
      map['created'] = Variable<int>(created.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommentsCompanion(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('author: $author, ')
          ..write('authorName: $authorName, ')
          ..write('body: $body, ')
          ..write('created: $created')
          ..write(')'))
        .toString();
  }
}

class Attachments extends Table with TableInfo<Attachments, Attachment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Attachments(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'PRIMARY KEY AUTOINCREMENT',
  );
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  late final GeneratedColumn<int> taskId = GeneratedColumn<int>(
    'task_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES tasks(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
    'path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL UNIQUE',
  );
  static const VerificationMeta _createdMeta = const VerificationMeta(
    'created',
  );
  late final GeneratedColumn<int> created = GeneratedColumn<int>(
    'created',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [id, taskId, name, path, created];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attachments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Attachment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('task_id')) {
      context.handle(
        _taskIdMeta,
        taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta),
      );
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
        _pathMeta,
        path.isAcceptableOrUnknown(data['path']!, _pathMeta),
      );
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('created')) {
      context.handle(
        _createdMeta,
        created.isAcceptableOrUnknown(data['created']!, _createdMeta),
      );
    } else if (isInserting) {
      context.missing(_createdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Attachment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Attachment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      taskId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}task_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      path: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}path'],
      )!,
      created: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created'],
      )!,
    );
  }

  @override
  Attachments createAlias(String alias) {
    return Attachments(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Attachment extends DataClass implements Insertable<Attachment> {
  final int id;
  final int taskId;
  final String name;
  final String path;
  final int created;
  const Attachment({
    required this.id,
    required this.taskId,
    required this.name,
    required this.path,
    required this.created,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['task_id'] = Variable<int>(taskId);
    map['name'] = Variable<String>(name);
    map['path'] = Variable<String>(path);
    map['created'] = Variable<int>(created);
    return map;
  }

  AttachmentsCompanion toCompanion(bool nullToAbsent) {
    return AttachmentsCompanion(
      id: Value(id),
      taskId: Value(taskId),
      name: Value(name),
      path: Value(path),
      created: Value(created),
    );
  }

  factory Attachment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Attachment(
      id: serializer.fromJson<int>(json['id']),
      taskId: serializer.fromJson<int>(json['task_id']),
      name: serializer.fromJson<String>(json['name']),
      path: serializer.fromJson<String>(json['path']),
      created: serializer.fromJson<int>(json['created']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'task_id': serializer.toJson<int>(taskId),
      'name': serializer.toJson<String>(name),
      'path': serializer.toJson<String>(path),
      'created': serializer.toJson<int>(created),
    };
  }

  Attachment copyWith({
    int? id,
    int? taskId,
    String? name,
    String? path,
    int? created,
  }) => Attachment(
    id: id ?? this.id,
    taskId: taskId ?? this.taskId,
    name: name ?? this.name,
    path: path ?? this.path,
    created: created ?? this.created,
  );
  Attachment copyWithCompanion(AttachmentsCompanion data) {
    return Attachment(
      id: data.id.present ? data.id.value : this.id,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      name: data.name.present ? data.name.value : this.name,
      path: data.path.present ? data.path.value : this.path,
      created: data.created.present ? data.created.value : this.created,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Attachment(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('name: $name, ')
          ..write('path: $path, ')
          ..write('created: $created')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, taskId, name, path, created);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Attachment &&
          other.id == this.id &&
          other.taskId == this.taskId &&
          other.name == this.name &&
          other.path == this.path &&
          other.created == this.created);
}

class AttachmentsCompanion extends UpdateCompanion<Attachment> {
  final Value<int> id;
  final Value<int> taskId;
  final Value<String> name;
  final Value<String> path;
  final Value<int> created;
  const AttachmentsCompanion({
    this.id = const Value.absent(),
    this.taskId = const Value.absent(),
    this.name = const Value.absent(),
    this.path = const Value.absent(),
    this.created = const Value.absent(),
  });
  AttachmentsCompanion.insert({
    this.id = const Value.absent(),
    required int taskId,
    required String name,
    required String path,
    required int created,
  }) : taskId = Value(taskId),
       name = Value(name),
       path = Value(path),
       created = Value(created);
  static Insertable<Attachment> custom({
    Expression<int>? id,
    Expression<int>? taskId,
    Expression<String>? name,
    Expression<String>? path,
    Expression<int>? created,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskId != null) 'task_id': taskId,
      if (name != null) 'name': name,
      if (path != null) 'path': path,
      if (created != null) 'created': created,
    });
  }

  AttachmentsCompanion copyWith({
    Value<int>? id,
    Value<int>? taskId,
    Value<String>? name,
    Value<String>? path,
    Value<int>? created,
  }) {
    return AttachmentsCompanion(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      name: name ?? this.name,
      path: path ?? this.path,
      created: created ?? this.created,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<int>(taskId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (created.present) {
      map['created'] = Variable<int>(created.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttachmentsCompanion(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('name: $name, ')
          ..write('path: $path, ')
          ..write('created: $created')
          ..write(')'))
        .toString();
  }
}

class TaskHistory extends Table with TableInfo<TaskHistory, TaskHistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  TaskHistory(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'PRIMARY KEY AUTOINCREMENT',
  );
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  late final GeneratedColumn<int> taskId = GeneratedColumn<int>(
    'task_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES tasks(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (kind IN (\'created\', \'status\', \'assignee\', \'undo\'))',
  );
  static const VerificationMeta _oldStatusMeta = const VerificationMeta(
    'oldStatus',
  );
  late final GeneratedColumn<String> oldStatus = GeneratedColumn<String>(
    'old_status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _newStatusMeta = const VerificationMeta(
    'newStatus',
  );
  late final GeneratedColumn<String> newStatus = GeneratedColumn<String>(
    'new_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _actorMeta = const VerificationMeta('actor');
  late final GeneratedColumn<int> actor = GeneratedColumn<int>(
    'actor',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES users(id)ON DELETE SET NULL',
  );
  static const VerificationMeta _actorNameMeta = const VerificationMeta(
    'actorName',
  );
  late final GeneratedColumn<String> actorName = GeneratedColumn<String>(
    'actor_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _oldAssigneeMeta = const VerificationMeta(
    'oldAssignee',
  );
  late final GeneratedColumn<String> oldAssignee = GeneratedColumn<String>(
    'old_assignee',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _newAssigneeMeta = const VerificationMeta(
    'newAssignee',
  );
  late final GeneratedColumn<String> newAssignee = GeneratedColumn<String>(
    'new_assignee',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _undoOfMeta = const VerificationMeta('undoOf');
  late final GeneratedColumn<int> undoOf = GeneratedColumn<int>(
    'undo_of',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'UNIQUE REFERENCES task_history(id)ON DELETE CASCADE',
  );
  static const VerificationMeta _createdMeta = const VerificationMeta(
    'created',
  );
  late final GeneratedColumn<int> created = GeneratedColumn<int>(
    'created',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    taskId,
    kind,
    oldStatus,
    newStatus,
    actor,
    actorName,
    oldAssignee,
    newAssignee,
    undoOf,
    created,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'task_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<TaskHistoryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('task_id')) {
      context.handle(
        _taskIdMeta,
        taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta),
      );
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('old_status')) {
      context.handle(
        _oldStatusMeta,
        oldStatus.isAcceptableOrUnknown(data['old_status']!, _oldStatusMeta),
      );
    }
    if (data.containsKey('new_status')) {
      context.handle(
        _newStatusMeta,
        newStatus.isAcceptableOrUnknown(data['new_status']!, _newStatusMeta),
      );
    } else if (isInserting) {
      context.missing(_newStatusMeta);
    }
    if (data.containsKey('actor')) {
      context.handle(
        _actorMeta,
        actor.isAcceptableOrUnknown(data['actor']!, _actorMeta),
      );
    }
    if (data.containsKey('actor_name')) {
      context.handle(
        _actorNameMeta,
        actorName.isAcceptableOrUnknown(data['actor_name']!, _actorNameMeta),
      );
    } else if (isInserting) {
      context.missing(_actorNameMeta);
    }
    if (data.containsKey('old_assignee')) {
      context.handle(
        _oldAssigneeMeta,
        oldAssignee.isAcceptableOrUnknown(
          data['old_assignee']!,
          _oldAssigneeMeta,
        ),
      );
    }
    if (data.containsKey('new_assignee')) {
      context.handle(
        _newAssigneeMeta,
        newAssignee.isAcceptableOrUnknown(
          data['new_assignee']!,
          _newAssigneeMeta,
        ),
      );
    }
    if (data.containsKey('undo_of')) {
      context.handle(
        _undoOfMeta,
        undoOf.isAcceptableOrUnknown(data['undo_of']!, _undoOfMeta),
      );
    }
    if (data.containsKey('created')) {
      context.handle(
        _createdMeta,
        created.isAcceptableOrUnknown(data['created']!, _createdMeta),
      );
    } else if (isInserting) {
      context.missing(_createdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskHistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskHistoryData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      taskId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}task_id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      oldStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}old_status'],
      ),
      newStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}new_status'],
      )!,
      actor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}actor'],
      ),
      actorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}actor_name'],
      )!,
      oldAssignee: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}old_assignee'],
      ),
      newAssignee: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}new_assignee'],
      ),
      undoOf: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}undo_of'],
      ),
      created: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created'],
      )!,
    );
  }

  @override
  TaskHistory createAlias(String alias) {
    return TaskHistory(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class TaskHistoryData extends DataClass implements Insertable<TaskHistoryData> {
  final int id;
  final int taskId;
  final String kind;
  final String? oldStatus;
  final String newStatus;
  final int? actor;
  final String actorName;
  final String? oldAssignee;
  final String? newAssignee;
  final int? undoOf;
  final int created;
  const TaskHistoryData({
    required this.id,
    required this.taskId,
    required this.kind,
    this.oldStatus,
    required this.newStatus,
    this.actor,
    required this.actorName,
    this.oldAssignee,
    this.newAssignee,
    this.undoOf,
    required this.created,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['task_id'] = Variable<int>(taskId);
    map['kind'] = Variable<String>(kind);
    if (!nullToAbsent || oldStatus != null) {
      map['old_status'] = Variable<String>(oldStatus);
    }
    map['new_status'] = Variable<String>(newStatus);
    if (!nullToAbsent || actor != null) {
      map['actor'] = Variable<int>(actor);
    }
    map['actor_name'] = Variable<String>(actorName);
    if (!nullToAbsent || oldAssignee != null) {
      map['old_assignee'] = Variable<String>(oldAssignee);
    }
    if (!nullToAbsent || newAssignee != null) {
      map['new_assignee'] = Variable<String>(newAssignee);
    }
    if (!nullToAbsent || undoOf != null) {
      map['undo_of'] = Variable<int>(undoOf);
    }
    map['created'] = Variable<int>(created);
    return map;
  }

  TaskHistoryCompanion toCompanion(bool nullToAbsent) {
    return TaskHistoryCompanion(
      id: Value(id),
      taskId: Value(taskId),
      kind: Value(kind),
      oldStatus: oldStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(oldStatus),
      newStatus: Value(newStatus),
      actor: actor == null && nullToAbsent
          ? const Value.absent()
          : Value(actor),
      actorName: Value(actorName),
      oldAssignee: oldAssignee == null && nullToAbsent
          ? const Value.absent()
          : Value(oldAssignee),
      newAssignee: newAssignee == null && nullToAbsent
          ? const Value.absent()
          : Value(newAssignee),
      undoOf: undoOf == null && nullToAbsent
          ? const Value.absent()
          : Value(undoOf),
      created: Value(created),
    );
  }

  factory TaskHistoryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskHistoryData(
      id: serializer.fromJson<int>(json['id']),
      taskId: serializer.fromJson<int>(json['task_id']),
      kind: serializer.fromJson<String>(json['kind']),
      oldStatus: serializer.fromJson<String?>(json['old_status']),
      newStatus: serializer.fromJson<String>(json['new_status']),
      actor: serializer.fromJson<int?>(json['actor']),
      actorName: serializer.fromJson<String>(json['actor_name']),
      oldAssignee: serializer.fromJson<String?>(json['old_assignee']),
      newAssignee: serializer.fromJson<String?>(json['new_assignee']),
      undoOf: serializer.fromJson<int?>(json['undo_of']),
      created: serializer.fromJson<int>(json['created']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'task_id': serializer.toJson<int>(taskId),
      'kind': serializer.toJson<String>(kind),
      'old_status': serializer.toJson<String?>(oldStatus),
      'new_status': serializer.toJson<String>(newStatus),
      'actor': serializer.toJson<int?>(actor),
      'actor_name': serializer.toJson<String>(actorName),
      'old_assignee': serializer.toJson<String?>(oldAssignee),
      'new_assignee': serializer.toJson<String?>(newAssignee),
      'undo_of': serializer.toJson<int?>(undoOf),
      'created': serializer.toJson<int>(created),
    };
  }

  TaskHistoryData copyWith({
    int? id,
    int? taskId,
    String? kind,
    Value<String?> oldStatus = const Value.absent(),
    String? newStatus,
    Value<int?> actor = const Value.absent(),
    String? actorName,
    Value<String?> oldAssignee = const Value.absent(),
    Value<String?> newAssignee = const Value.absent(),
    Value<int?> undoOf = const Value.absent(),
    int? created,
  }) => TaskHistoryData(
    id: id ?? this.id,
    taskId: taskId ?? this.taskId,
    kind: kind ?? this.kind,
    oldStatus: oldStatus.present ? oldStatus.value : this.oldStatus,
    newStatus: newStatus ?? this.newStatus,
    actor: actor.present ? actor.value : this.actor,
    actorName: actorName ?? this.actorName,
    oldAssignee: oldAssignee.present ? oldAssignee.value : this.oldAssignee,
    newAssignee: newAssignee.present ? newAssignee.value : this.newAssignee,
    undoOf: undoOf.present ? undoOf.value : this.undoOf,
    created: created ?? this.created,
  );
  TaskHistoryData copyWithCompanion(TaskHistoryCompanion data) {
    return TaskHistoryData(
      id: data.id.present ? data.id.value : this.id,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      kind: data.kind.present ? data.kind.value : this.kind,
      oldStatus: data.oldStatus.present ? data.oldStatus.value : this.oldStatus,
      newStatus: data.newStatus.present ? data.newStatus.value : this.newStatus,
      actor: data.actor.present ? data.actor.value : this.actor,
      actorName: data.actorName.present ? data.actorName.value : this.actorName,
      oldAssignee: data.oldAssignee.present
          ? data.oldAssignee.value
          : this.oldAssignee,
      newAssignee: data.newAssignee.present
          ? data.newAssignee.value
          : this.newAssignee,
      undoOf: data.undoOf.present ? data.undoOf.value : this.undoOf,
      created: data.created.present ? data.created.value : this.created,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskHistoryData(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('kind: $kind, ')
          ..write('oldStatus: $oldStatus, ')
          ..write('newStatus: $newStatus, ')
          ..write('actor: $actor, ')
          ..write('actorName: $actorName, ')
          ..write('oldAssignee: $oldAssignee, ')
          ..write('newAssignee: $newAssignee, ')
          ..write('undoOf: $undoOf, ')
          ..write('created: $created')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    taskId,
    kind,
    oldStatus,
    newStatus,
    actor,
    actorName,
    oldAssignee,
    newAssignee,
    undoOf,
    created,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskHistoryData &&
          other.id == this.id &&
          other.taskId == this.taskId &&
          other.kind == this.kind &&
          other.oldStatus == this.oldStatus &&
          other.newStatus == this.newStatus &&
          other.actor == this.actor &&
          other.actorName == this.actorName &&
          other.oldAssignee == this.oldAssignee &&
          other.newAssignee == this.newAssignee &&
          other.undoOf == this.undoOf &&
          other.created == this.created);
}

class TaskHistoryCompanion extends UpdateCompanion<TaskHistoryData> {
  final Value<int> id;
  final Value<int> taskId;
  final Value<String> kind;
  final Value<String?> oldStatus;
  final Value<String> newStatus;
  final Value<int?> actor;
  final Value<String> actorName;
  final Value<String?> oldAssignee;
  final Value<String?> newAssignee;
  final Value<int?> undoOf;
  final Value<int> created;
  const TaskHistoryCompanion({
    this.id = const Value.absent(),
    this.taskId = const Value.absent(),
    this.kind = const Value.absent(),
    this.oldStatus = const Value.absent(),
    this.newStatus = const Value.absent(),
    this.actor = const Value.absent(),
    this.actorName = const Value.absent(),
    this.oldAssignee = const Value.absent(),
    this.newAssignee = const Value.absent(),
    this.undoOf = const Value.absent(),
    this.created = const Value.absent(),
  });
  TaskHistoryCompanion.insert({
    this.id = const Value.absent(),
    required int taskId,
    required String kind,
    this.oldStatus = const Value.absent(),
    required String newStatus,
    this.actor = const Value.absent(),
    required String actorName,
    this.oldAssignee = const Value.absent(),
    this.newAssignee = const Value.absent(),
    this.undoOf = const Value.absent(),
    required int created,
  }) : taskId = Value(taskId),
       kind = Value(kind),
       newStatus = Value(newStatus),
       actorName = Value(actorName),
       created = Value(created);
  static Insertable<TaskHistoryData> custom({
    Expression<int>? id,
    Expression<int>? taskId,
    Expression<String>? kind,
    Expression<String>? oldStatus,
    Expression<String>? newStatus,
    Expression<int>? actor,
    Expression<String>? actorName,
    Expression<String>? oldAssignee,
    Expression<String>? newAssignee,
    Expression<int>? undoOf,
    Expression<int>? created,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskId != null) 'task_id': taskId,
      if (kind != null) 'kind': kind,
      if (oldStatus != null) 'old_status': oldStatus,
      if (newStatus != null) 'new_status': newStatus,
      if (actor != null) 'actor': actor,
      if (actorName != null) 'actor_name': actorName,
      if (oldAssignee != null) 'old_assignee': oldAssignee,
      if (newAssignee != null) 'new_assignee': newAssignee,
      if (undoOf != null) 'undo_of': undoOf,
      if (created != null) 'created': created,
    });
  }

  TaskHistoryCompanion copyWith({
    Value<int>? id,
    Value<int>? taskId,
    Value<String>? kind,
    Value<String?>? oldStatus,
    Value<String>? newStatus,
    Value<int?>? actor,
    Value<String>? actorName,
    Value<String?>? oldAssignee,
    Value<String?>? newAssignee,
    Value<int?>? undoOf,
    Value<int>? created,
  }) {
    return TaskHistoryCompanion(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      kind: kind ?? this.kind,
      oldStatus: oldStatus ?? this.oldStatus,
      newStatus: newStatus ?? this.newStatus,
      actor: actor ?? this.actor,
      actorName: actorName ?? this.actorName,
      oldAssignee: oldAssignee ?? this.oldAssignee,
      newAssignee: newAssignee ?? this.newAssignee,
      undoOf: undoOf ?? this.undoOf,
      created: created ?? this.created,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<int>(taskId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (oldStatus.present) {
      map['old_status'] = Variable<String>(oldStatus.value);
    }
    if (newStatus.present) {
      map['new_status'] = Variable<String>(newStatus.value);
    }
    if (actor.present) {
      map['actor'] = Variable<int>(actor.value);
    }
    if (actorName.present) {
      map['actor_name'] = Variable<String>(actorName.value);
    }
    if (oldAssignee.present) {
      map['old_assignee'] = Variable<String>(oldAssignee.value);
    }
    if (newAssignee.present) {
      map['new_assignee'] = Variable<String>(newAssignee.value);
    }
    if (undoOf.present) {
      map['undo_of'] = Variable<int>(undoOf.value);
    }
    if (created.present) {
      map['created'] = Variable<int>(created.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskHistoryCompanion(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('kind: $kind, ')
          ..write('oldStatus: $oldStatus, ')
          ..write('newStatus: $newStatus, ')
          ..write('actor: $actor, ')
          ..write('actorName: $actorName, ')
          ..write('oldAssignee: $oldAssignee, ')
          ..write('newAssignee: $newAssignee, ')
          ..write('undoOf: $undoOf, ')
          ..write('created: $created')
          ..write(')'))
        .toString();
  }
}

abstract class _$TaskDatabase extends GeneratedDatabase {
  _$TaskDatabase(QueryExecutor e) : super(e);
  $TaskDatabaseManager get managers => $TaskDatabaseManager(this);
  late final Users users = Users(this);
  late final Projects projects = Projects(this);
  late final ProjectMembers projectMembers = ProjectMembers(this);
  late final Tasks tasks = Tasks(this);
  late final Comments comments = Comments(this);
  late final Attachments attachments = Attachments(this);
  late final TaskHistory taskHistory = TaskHistory(this);
  late final Index taskProjectDue = Index(
    'task_project_due',
    'CREATE INDEX task_project_due ON tasks (project_id, deadline, id) WHERE deleted_at IS NULL',
  );
  late final Index taskAssigneeDue = Index(
    'task_assignee_due',
    'CREATE INDEX task_assignee_due ON tasks (assignee, deadline, status) WHERE deleted_at IS NULL',
  );
  late final Index taskPriorityDue = Index(
    'task_priority_due',
    'CREATE INDEX task_priority_due ON tasks (priority, deadline, id) WHERE deleted_at IS NULL',
  );
  late final Index taskStatusDue = Index(
    'task_status_due',
    'CREATE INDEX task_status_due ON tasks (status, deadline, id) WHERE deleted_at IS NULL',
  );
  late final Index taskCreated = Index(
    'task_created',
    'CREATE INDEX task_created ON tasks (created, id) WHERE deleted_at IS NULL',
  );
  late final Index taskDue = Index(
    'task_due',
    'CREATE INDEX task_due ON tasks (deadline, id) WHERE deleted_at IS NULL',
  );
  late final Index commentTask = Index(
    'comment_task',
    'CREATE INDEX comment_task ON comments (task_id, id)',
  );
  late final Index attachmentTask = Index(
    'attachment_task',
    'CREATE INDEX attachment_task ON attachments (task_id, id)',
  );
  late final Index historyTask = Index(
    'history_task',
    'CREATE INDEX history_task ON task_history (task_id, id)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    projects,
    projectMembers,
    tasks,
    comments,
    attachments,
    taskHistory,
    taskProjectDue,
    taskAssigneeDue,
    taskPriorityDue,
    taskStatusDue,
    taskCreated,
    taskDue,
    commentTask,
    attachmentTask,
    historyTask,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'projects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('project_members', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('project_members', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'projects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tasks', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tasks', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tasks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('comments', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('comments', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tasks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('attachments', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tasks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('task_history', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('task_history', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $UsersCreateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      required String name,
      required String email,
      required String registered,
    });
typedef $UsersUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> email,
      Value<String> registered,
    });

final class $UsersReferences
    extends BaseReferences<_$TaskDatabase, Users, User> {
  $UsersReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<ProjectMembers, List<ProjectMember>>
  _projectMembersRefsTable(_$TaskDatabase db) => MultiTypedResultKey.fromTable(
    db.projectMembers,
    aliasName: $_aliasNameGenerator(db.users.id, db.projectMembers.userId),
  );

  $ProjectMembersProcessedTableManager get projectMembersRefs {
    final manager = $ProjectMembersTableManager(
      $_db,
      $_db.projectMembers,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_projectMembersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<Tasks, List<Task>> _tasksRefsTable(
    _$TaskDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.tasks,
    aliasName: $_aliasNameGenerator(db.users.id, db.tasks.assignee),
  );

  $TasksProcessedTableManager get tasksRefs {
    final manager = $TasksTableManager(
      $_db,
      $_db.tasks,
    ).filter((f) => f.assignee.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_tasksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<Comments, List<Comment>> _commentsRefsTable(
    _$TaskDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.comments,
    aliasName: $_aliasNameGenerator(db.users.id, db.comments.author),
  );

  $CommentsProcessedTableManager get commentsRefs {
    final manager = $CommentsTableManager(
      $_db,
      $_db.comments,
    ).filter((f) => f.author.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_commentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<TaskHistory, List<TaskHistoryData>>
  _taskHistoryRefsTable(_$TaskDatabase db) => MultiTypedResultKey.fromTable(
    db.taskHistory,
    aliasName: $_aliasNameGenerator(db.users.id, db.taskHistory.actor),
  );

  $TaskHistoryProcessedTableManager get taskHistoryRefs {
    final manager = $TaskHistoryTableManager(
      $_db,
      $_db.taskHistory,
    ).filter((f) => f.actor.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_taskHistoryRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $UsersFilterComposer extends Composer<_$TaskDatabase, Users> {
  $UsersFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get registered => $composableBuilder(
    column: $table.registered,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> projectMembersRefs(
    Expression<bool> Function($ProjectMembersFilterComposer f) f,
  ) {
    final $ProjectMembersFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.projectMembers,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProjectMembersFilterComposer(
            $db: $db,
            $table: $db.projectMembers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> tasksRefs(
    Expression<bool> Function($TasksFilterComposer f) f,
  ) {
    final $TasksFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.assignee,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TasksFilterComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> commentsRefs(
    Expression<bool> Function($CommentsFilterComposer f) f,
  ) {
    final $CommentsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.comments,
      getReferencedColumn: (t) => t.author,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CommentsFilterComposer(
            $db: $db,
            $table: $db.comments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> taskHistoryRefs(
    Expression<bool> Function($TaskHistoryFilterComposer f) f,
  ) {
    final $TaskHistoryFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.taskHistory,
      getReferencedColumn: (t) => t.actor,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TaskHistoryFilterComposer(
            $db: $db,
            $table: $db.taskHistory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $UsersOrderingComposer extends Composer<_$TaskDatabase, Users> {
  $UsersOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get registered => $composableBuilder(
    column: $table.registered,
    builder: (column) => ColumnOrderings(column),
  );
}

class $UsersAnnotationComposer extends Composer<_$TaskDatabase, Users> {
  $UsersAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get registered => $composableBuilder(
    column: $table.registered,
    builder: (column) => column,
  );

  Expression<T> projectMembersRefs<T extends Object>(
    Expression<T> Function($ProjectMembersAnnotationComposer a) f,
  ) {
    final $ProjectMembersAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.projectMembers,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProjectMembersAnnotationComposer(
            $db: $db,
            $table: $db.projectMembers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> tasksRefs<T extends Object>(
    Expression<T> Function($TasksAnnotationComposer a) f,
  ) {
    final $TasksAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.assignee,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TasksAnnotationComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> commentsRefs<T extends Object>(
    Expression<T> Function($CommentsAnnotationComposer a) f,
  ) {
    final $CommentsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.comments,
      getReferencedColumn: (t) => t.author,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CommentsAnnotationComposer(
            $db: $db,
            $table: $db.comments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> taskHistoryRefs<T extends Object>(
    Expression<T> Function($TaskHistoryAnnotationComposer a) f,
  ) {
    final $TaskHistoryAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.taskHistory,
      getReferencedColumn: (t) => t.actor,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TaskHistoryAnnotationComposer(
            $db: $db,
            $table: $db.taskHistory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $UsersTableManager
    extends
        RootTableManager<
          _$TaskDatabase,
          Users,
          User,
          $UsersFilterComposer,
          $UsersOrderingComposer,
          $UsersAnnotationComposer,
          $UsersCreateCompanionBuilder,
          $UsersUpdateCompanionBuilder,
          (User, $UsersReferences),
          User,
          PrefetchHooks Function({
            bool projectMembersRefs,
            bool tasksRefs,
            bool commentsRefs,
            bool taskHistoryRefs,
          })
        > {
  $UsersTableManager(_$TaskDatabase db, Users table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $UsersFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $UsersOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $UsersAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> registered = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                name: name,
                email: email,
                registered: registered,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String email,
                required String registered,
              }) => UsersCompanion.insert(
                id: id,
                name: name,
                email: email,
                registered: registered,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), $UsersReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback:
              ({
                projectMembersRefs = false,
                tasksRefs = false,
                commentsRefs = false,
                taskHistoryRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (projectMembersRefs) db.projectMembers,
                    if (tasksRefs) db.tasks,
                    if (commentsRefs) db.comments,
                    if (taskHistoryRefs) db.taskHistory,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (projectMembersRefs)
                        await $_getPrefetchedData<User, Users, ProjectMember>(
                          currentTable: table,
                          referencedTable: $UsersReferences
                              ._projectMembersRefsTable(db),
                          managerFromTypedResult: (p0) => $UsersReferences(
                            db,
                            table,
                            p0,
                          ).projectMembersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (tasksRefs)
                        await $_getPrefetchedData<User, Users, Task>(
                          currentTable: table,
                          referencedTable: $UsersReferences._tasksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $UsersReferences(db, table, p0).tasksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.assignee == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (commentsRefs)
                        await $_getPrefetchedData<User, Users, Comment>(
                          currentTable: table,
                          referencedTable: $UsersReferences._commentsRefsTable(
                            db,
                          ),
                          managerFromTypedResult: (p0) =>
                              $UsersReferences(db, table, p0).commentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.author == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (taskHistoryRefs)
                        await $_getPrefetchedData<User, Users, TaskHistoryData>(
                          currentTable: table,
                          referencedTable: $UsersReferences
                              ._taskHistoryRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $UsersReferences(db, table, p0).taskHistoryRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.actor == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $UsersProcessedTableManager =
    ProcessedTableManager<
      _$TaskDatabase,
      Users,
      User,
      $UsersFilterComposer,
      $UsersOrderingComposer,
      $UsersAnnotationComposer,
      $UsersCreateCompanionBuilder,
      $UsersUpdateCompanionBuilder,
      (User, $UsersReferences),
      User,
      PrefetchHooks Function({
        bool projectMembersRefs,
        bool tasksRefs,
        bool commentsRefs,
        bool taskHistoryRefs,
      })
    >;
typedef $ProjectsCreateCompanionBuilder =
    ProjectsCompanion Function({
      Value<int> id,
      required String name,
      required String description,
      required String created,
      Value<String?> finish,
      required String status,
    });
typedef $ProjectsUpdateCompanionBuilder =
    ProjectsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> description,
      Value<String> created,
      Value<String?> finish,
      Value<String> status,
    });

final class $ProjectsReferences
    extends BaseReferences<_$TaskDatabase, Projects, Project> {
  $ProjectsReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<ProjectMembers, List<ProjectMember>>
  _projectMembersRefsTable(_$TaskDatabase db) => MultiTypedResultKey.fromTable(
    db.projectMembers,
    aliasName: $_aliasNameGenerator(
      db.projects.id,
      db.projectMembers.projectId,
    ),
  );

  $ProjectMembersProcessedTableManager get projectMembersRefs {
    final manager = $ProjectMembersTableManager(
      $_db,
      $_db.projectMembers,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_projectMembersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<Tasks, List<Task>> _tasksRefsTable(
    _$TaskDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.tasks,
    aliasName: $_aliasNameGenerator(db.projects.id, db.tasks.projectId),
  );

  $TasksProcessedTableManager get tasksRefs {
    final manager = $TasksTableManager(
      $_db,
      $_db.tasks,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_tasksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $ProjectsFilterComposer extends Composer<_$TaskDatabase, Projects> {
  $ProjectsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get finish => $composableBuilder(
    column: $table.finish,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> projectMembersRefs(
    Expression<bool> Function($ProjectMembersFilterComposer f) f,
  ) {
    final $ProjectMembersFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.projectMembers,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProjectMembersFilterComposer(
            $db: $db,
            $table: $db.projectMembers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> tasksRefs(
    Expression<bool> Function($TasksFilterComposer f) f,
  ) {
    final $TasksFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TasksFilterComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $ProjectsOrderingComposer extends Composer<_$TaskDatabase, Projects> {
  $ProjectsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get finish => $composableBuilder(
    column: $table.finish,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $ProjectsAnnotationComposer extends Composer<_$TaskDatabase, Projects> {
  $ProjectsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get created =>
      $composableBuilder(column: $table.created, builder: (column) => column);

  GeneratedColumn<String> get finish =>
      $composableBuilder(column: $table.finish, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  Expression<T> projectMembersRefs<T extends Object>(
    Expression<T> Function($ProjectMembersAnnotationComposer a) f,
  ) {
    final $ProjectMembersAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.projectMembers,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProjectMembersAnnotationComposer(
            $db: $db,
            $table: $db.projectMembers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> tasksRefs<T extends Object>(
    Expression<T> Function($TasksAnnotationComposer a) f,
  ) {
    final $TasksAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TasksAnnotationComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $ProjectsTableManager
    extends
        RootTableManager<
          _$TaskDatabase,
          Projects,
          Project,
          $ProjectsFilterComposer,
          $ProjectsOrderingComposer,
          $ProjectsAnnotationComposer,
          $ProjectsCreateCompanionBuilder,
          $ProjectsUpdateCompanionBuilder,
          (Project, $ProjectsReferences),
          Project,
          PrefetchHooks Function({bool projectMembersRefs, bool tasksRefs})
        > {
  $ProjectsTableManager(_$TaskDatabase db, Projects table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $ProjectsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $ProjectsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $ProjectsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> created = const Value.absent(),
                Value<String?> finish = const Value.absent(),
                Value<String> status = const Value.absent(),
              }) => ProjectsCompanion(
                id: id,
                name: name,
                description: description,
                created: created,
                finish: finish,
                status: status,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String description,
                required String created,
                Value<String?> finish = const Value.absent(),
                required String status,
              }) => ProjectsCompanion.insert(
                id: id,
                name: name,
                description: description,
                created: created,
                finish: finish,
                status: status,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (e.readTable(table), $ProjectsReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({projectMembersRefs = false, tasksRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (projectMembersRefs) db.projectMembers,
                    if (tasksRefs) db.tasks,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (projectMembersRefs)
                        await $_getPrefetchedData<
                          Project,
                          Projects,
                          ProjectMember
                        >(
                          currentTable: table,
                          referencedTable: $ProjectsReferences
                              ._projectMembersRefsTable(db),
                          managerFromTypedResult: (p0) => $ProjectsReferences(
                            db,
                            table,
                            p0,
                          ).projectMembersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.projectId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (tasksRefs)
                        await $_getPrefetchedData<Project, Projects, Task>(
                          currentTable: table,
                          referencedTable: $ProjectsReferences._tasksRefsTable(
                            db,
                          ),
                          managerFromTypedResult: (p0) =>
                              $ProjectsReferences(db, table, p0).tasksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.projectId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $ProjectsProcessedTableManager =
    ProcessedTableManager<
      _$TaskDatabase,
      Projects,
      Project,
      $ProjectsFilterComposer,
      $ProjectsOrderingComposer,
      $ProjectsAnnotationComposer,
      $ProjectsCreateCompanionBuilder,
      $ProjectsUpdateCompanionBuilder,
      (Project, $ProjectsReferences),
      Project,
      PrefetchHooks Function({bool projectMembersRefs, bool tasksRefs})
    >;
typedef $ProjectMembersCreateCompanionBuilder =
    ProjectMembersCompanion Function({
      required int projectId,
      required int userId,
      required String role,
      Value<int> rowid,
    });
typedef $ProjectMembersUpdateCompanionBuilder =
    ProjectMembersCompanion Function({
      Value<int> projectId,
      Value<int> userId,
      Value<String> role,
      Value<int> rowid,
    });

final class $ProjectMembersReferences
    extends BaseReferences<_$TaskDatabase, ProjectMembers, ProjectMember> {
  $ProjectMembersReferences(super.$_db, super.$_table, super.$_typedResult);

  static Projects _projectIdTable(_$TaskDatabase db) => db.projects.createAlias(
    $_aliasNameGenerator(db.projectMembers.projectId, db.projects.id),
  );

  $ProjectsProcessedTableManager get projectId {
    final $_column = $_itemColumn<int>('project_id')!;

    final manager = $ProjectsTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static Users _userIdTable(_$TaskDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.projectMembers.userId, db.users.id),
  );

  $UsersProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $UsersTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $ProjectMembersFilterComposer
    extends Composer<_$TaskDatabase, ProjectMembers> {
  $ProjectMembersFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  $ProjectsFilterComposer get projectId {
    final $ProjectsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProjectsFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $UsersFilterComposer get userId {
    final $UsersFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $ProjectMembersOrderingComposer
    extends Composer<_$TaskDatabase, ProjectMembers> {
  $ProjectMembersOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  $ProjectsOrderingComposer get projectId {
    final $ProjectsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProjectsOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $UsersOrderingComposer get userId {
    final $UsersOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $ProjectMembersAnnotationComposer
    extends Composer<_$TaskDatabase, ProjectMembers> {
  $ProjectMembersAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  $ProjectsAnnotationComposer get projectId {
    final $ProjectsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProjectsAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $UsersAnnotationComposer get userId {
    final $UsersAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $ProjectMembersTableManager
    extends
        RootTableManager<
          _$TaskDatabase,
          ProjectMembers,
          ProjectMember,
          $ProjectMembersFilterComposer,
          $ProjectMembersOrderingComposer,
          $ProjectMembersAnnotationComposer,
          $ProjectMembersCreateCompanionBuilder,
          $ProjectMembersUpdateCompanionBuilder,
          (ProjectMember, $ProjectMembersReferences),
          ProjectMember,
          PrefetchHooks Function({bool projectId, bool userId})
        > {
  $ProjectMembersTableManager(_$TaskDatabase db, ProjectMembers table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $ProjectMembersFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $ProjectMembersOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $ProjectMembersAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> projectId = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProjectMembersCompanion(
                projectId: projectId,
                userId: userId,
                role: role,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int projectId,
                required int userId,
                required String role,
                Value<int> rowid = const Value.absent(),
              }) => ProjectMembersCompanion.insert(
                projectId: projectId,
                userId: userId,
                role: role,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $ProjectMembersReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({projectId = false, userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (projectId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.projectId,
                                referencedTable: $ProjectMembersReferences
                                    ._projectIdTable(db),
                                referencedColumn: $ProjectMembersReferences
                                    ._projectIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (userId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userId,
                                referencedTable: $ProjectMembersReferences
                                    ._userIdTable(db),
                                referencedColumn: $ProjectMembersReferences
                                    ._userIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $ProjectMembersProcessedTableManager =
    ProcessedTableManager<
      _$TaskDatabase,
      ProjectMembers,
      ProjectMember,
      $ProjectMembersFilterComposer,
      $ProjectMembersOrderingComposer,
      $ProjectMembersAnnotationComposer,
      $ProjectMembersCreateCompanionBuilder,
      $ProjectMembersUpdateCompanionBuilder,
      (ProjectMember, $ProjectMembersReferences),
      ProjectMember,
      PrefetchHooks Function({bool projectId, bool userId})
    >;
typedef $TasksCreateCompanionBuilder =
    TasksCompanion Function({
      Value<int> id,
      required String title,
      required String description,
      required int projectId,
      Value<int?> assignee,
      required String status,
      required String deadline,
      required int created,
      required int updated,
      Value<int?> deletedAt,
      Value<String> priority,
    });
typedef $TasksUpdateCompanionBuilder =
    TasksCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> description,
      Value<int> projectId,
      Value<int?> assignee,
      Value<String> status,
      Value<String> deadline,
      Value<int> created,
      Value<int> updated,
      Value<int?> deletedAt,
      Value<String> priority,
    });

final class $TasksReferences
    extends BaseReferences<_$TaskDatabase, Tasks, Task> {
  $TasksReferences(super.$_db, super.$_table, super.$_typedResult);

  static Projects _projectIdTable(_$TaskDatabase db) => db.projects.createAlias(
    $_aliasNameGenerator(db.tasks.projectId, db.projects.id),
  );

  $ProjectsProcessedTableManager get projectId {
    final $_column = $_itemColumn<int>('project_id')!;

    final manager = $ProjectsTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static Users _assigneeTable(_$TaskDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.tasks.assignee, db.users.id),
  );

  $UsersProcessedTableManager? get assignee {
    final $_column = $_itemColumn<int>('assignee');
    if ($_column == null) return null;
    final manager = $UsersTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_assigneeTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<Comments, List<Comment>> _commentsRefsTable(
    _$TaskDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.comments,
    aliasName: $_aliasNameGenerator(db.tasks.id, db.comments.taskId),
  );

  $CommentsProcessedTableManager get commentsRefs {
    final manager = $CommentsTableManager(
      $_db,
      $_db.comments,
    ).filter((f) => f.taskId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_commentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<Attachments, List<Attachment>>
  _attachmentsRefsTable(_$TaskDatabase db) => MultiTypedResultKey.fromTable(
    db.attachments,
    aliasName: $_aliasNameGenerator(db.tasks.id, db.attachments.taskId),
  );

  $AttachmentsProcessedTableManager get attachmentsRefs {
    final manager = $AttachmentsTableManager(
      $_db,
      $_db.attachments,
    ).filter((f) => f.taskId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_attachmentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<TaskHistory, List<TaskHistoryData>>
  _taskHistoryRefsTable(_$TaskDatabase db) => MultiTypedResultKey.fromTable(
    db.taskHistory,
    aliasName: $_aliasNameGenerator(db.tasks.id, db.taskHistory.taskId),
  );

  $TaskHistoryProcessedTableManager get taskHistoryRefs {
    final manager = $TaskHistoryTableManager(
      $_db,
      $_db.taskHistory,
    ).filter((f) => f.taskId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_taskHistoryRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $TasksFilterComposer extends Composer<_$TaskDatabase, Tasks> {
  $TasksFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deadline => $composableBuilder(
    column: $table.deadline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updated => $composableBuilder(
    column: $table.updated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  $ProjectsFilterComposer get projectId {
    final $ProjectsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProjectsFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $UsersFilterComposer get assignee {
    final $UsersFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.assignee,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> commentsRefs(
    Expression<bool> Function($CommentsFilterComposer f) f,
  ) {
    final $CommentsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.comments,
      getReferencedColumn: (t) => t.taskId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CommentsFilterComposer(
            $db: $db,
            $table: $db.comments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> attachmentsRefs(
    Expression<bool> Function($AttachmentsFilterComposer f) f,
  ) {
    final $AttachmentsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.attachments,
      getReferencedColumn: (t) => t.taskId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $AttachmentsFilterComposer(
            $db: $db,
            $table: $db.attachments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> taskHistoryRefs(
    Expression<bool> Function($TaskHistoryFilterComposer f) f,
  ) {
    final $TaskHistoryFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.taskHistory,
      getReferencedColumn: (t) => t.taskId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TaskHistoryFilterComposer(
            $db: $db,
            $table: $db.taskHistory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $TasksOrderingComposer extends Composer<_$TaskDatabase, Tasks> {
  $TasksOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deadline => $composableBuilder(
    column: $table.deadline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updated => $composableBuilder(
    column: $table.updated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  $ProjectsOrderingComposer get projectId {
    final $ProjectsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProjectsOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $UsersOrderingComposer get assignee {
    final $UsersOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.assignee,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $TasksAnnotationComposer extends Composer<_$TaskDatabase, Tasks> {
  $TasksAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get deadline =>
      $composableBuilder(column: $table.deadline, builder: (column) => column);

  GeneratedColumn<int> get created =>
      $composableBuilder(column: $table.created, builder: (column) => column);

  GeneratedColumn<int> get updated =>
      $composableBuilder(column: $table.updated, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  $ProjectsAnnotationComposer get projectId {
    final $ProjectsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ProjectsAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $UsersAnnotationComposer get assignee {
    final $UsersAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.assignee,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> commentsRefs<T extends Object>(
    Expression<T> Function($CommentsAnnotationComposer a) f,
  ) {
    final $CommentsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.comments,
      getReferencedColumn: (t) => t.taskId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CommentsAnnotationComposer(
            $db: $db,
            $table: $db.comments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> attachmentsRefs<T extends Object>(
    Expression<T> Function($AttachmentsAnnotationComposer a) f,
  ) {
    final $AttachmentsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.attachments,
      getReferencedColumn: (t) => t.taskId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $AttachmentsAnnotationComposer(
            $db: $db,
            $table: $db.attachments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> taskHistoryRefs<T extends Object>(
    Expression<T> Function($TaskHistoryAnnotationComposer a) f,
  ) {
    final $TaskHistoryAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.taskHistory,
      getReferencedColumn: (t) => t.taskId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TaskHistoryAnnotationComposer(
            $db: $db,
            $table: $db.taskHistory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $TasksTableManager
    extends
        RootTableManager<
          _$TaskDatabase,
          Tasks,
          Task,
          $TasksFilterComposer,
          $TasksOrderingComposer,
          $TasksAnnotationComposer,
          $TasksCreateCompanionBuilder,
          $TasksUpdateCompanionBuilder,
          (Task, $TasksReferences),
          Task,
          PrefetchHooks Function({
            bool projectId,
            bool assignee,
            bool commentsRefs,
            bool attachmentsRefs,
            bool taskHistoryRefs,
          })
        > {
  $TasksTableManager(_$TaskDatabase db, Tasks table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $TasksFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $TasksOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $TasksAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> projectId = const Value.absent(),
                Value<int?> assignee = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> deadline = const Value.absent(),
                Value<int> created = const Value.absent(),
                Value<int> updated = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<String> priority = const Value.absent(),
              }) => TasksCompanion(
                id: id,
                title: title,
                description: description,
                projectId: projectId,
                assignee: assignee,
                status: status,
                deadline: deadline,
                created: created,
                updated: updated,
                deletedAt: deletedAt,
                priority: priority,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String description,
                required int projectId,
                Value<int?> assignee = const Value.absent(),
                required String status,
                required String deadline,
                required int created,
                required int updated,
                Value<int?> deletedAt = const Value.absent(),
                Value<String> priority = const Value.absent(),
              }) => TasksCompanion.insert(
                id: id,
                title: title,
                description: description,
                projectId: projectId,
                assignee: assignee,
                status: status,
                deadline: deadline,
                created: created,
                updated: updated,
                deletedAt: deletedAt,
                priority: priority,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), $TasksReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback:
              ({
                projectId = false,
                assignee = false,
                commentsRefs = false,
                attachmentsRefs = false,
                taskHistoryRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (commentsRefs) db.comments,
                    if (attachmentsRefs) db.attachments,
                    if (taskHistoryRefs) db.taskHistory,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (projectId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.projectId,
                                    referencedTable: $TasksReferences
                                        ._projectIdTable(db),
                                    referencedColumn: $TasksReferences
                                        ._projectIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (assignee) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.assignee,
                                    referencedTable: $TasksReferences
                                        ._assigneeTable(db),
                                    referencedColumn: $TasksReferences
                                        ._assigneeTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (commentsRefs)
                        await $_getPrefetchedData<Task, Tasks, Comment>(
                          currentTable: table,
                          referencedTable: $TasksReferences._commentsRefsTable(
                            db,
                          ),
                          managerFromTypedResult: (p0) =>
                              $TasksReferences(db, table, p0).commentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.taskId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (attachmentsRefs)
                        await $_getPrefetchedData<Task, Tasks, Attachment>(
                          currentTable: table,
                          referencedTable: $TasksReferences
                              ._attachmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $TasksReferences(db, table, p0).attachmentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.taskId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (taskHistoryRefs)
                        await $_getPrefetchedData<Task, Tasks, TaskHistoryData>(
                          currentTable: table,
                          referencedTable: $TasksReferences
                              ._taskHistoryRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $TasksReferences(db, table, p0).taskHistoryRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.taskId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $TasksProcessedTableManager =
    ProcessedTableManager<
      _$TaskDatabase,
      Tasks,
      Task,
      $TasksFilterComposer,
      $TasksOrderingComposer,
      $TasksAnnotationComposer,
      $TasksCreateCompanionBuilder,
      $TasksUpdateCompanionBuilder,
      (Task, $TasksReferences),
      Task,
      PrefetchHooks Function({
        bool projectId,
        bool assignee,
        bool commentsRefs,
        bool attachmentsRefs,
        bool taskHistoryRefs,
      })
    >;
typedef $CommentsCreateCompanionBuilder =
    CommentsCompanion Function({
      Value<int> id,
      required int taskId,
      Value<int?> author,
      required String authorName,
      required String body,
      required int created,
    });
typedef $CommentsUpdateCompanionBuilder =
    CommentsCompanion Function({
      Value<int> id,
      Value<int> taskId,
      Value<int?> author,
      Value<String> authorName,
      Value<String> body,
      Value<int> created,
    });

final class $CommentsReferences
    extends BaseReferences<_$TaskDatabase, Comments, Comment> {
  $CommentsReferences(super.$_db, super.$_table, super.$_typedResult);

  static Tasks _taskIdTable(_$TaskDatabase db) => db.tasks.createAlias(
    $_aliasNameGenerator(db.comments.taskId, db.tasks.id),
  );

  $TasksProcessedTableManager get taskId {
    final $_column = $_itemColumn<int>('task_id')!;

    final manager = $TasksTableManager(
      $_db,
      $_db.tasks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_taskIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static Users _authorTable(_$TaskDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.comments.author, db.users.id),
  );

  $UsersProcessedTableManager? get author {
    final $_column = $_itemColumn<int>('author');
    if ($_column == null) return null;
    final manager = $UsersTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_authorTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $CommentsFilterComposer extends Composer<_$TaskDatabase, Comments> {
  $CommentsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authorName => $composableBuilder(
    column: $table.authorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnFilters(column),
  );

  $TasksFilterComposer get taskId {
    final $TasksFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TasksFilterComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $UsersFilterComposer get author {
    final $UsersFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.author,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $CommentsOrderingComposer extends Composer<_$TaskDatabase, Comments> {
  $CommentsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authorName => $composableBuilder(
    column: $table.authorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnOrderings(column),
  );

  $TasksOrderingComposer get taskId {
    final $TasksOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TasksOrderingComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $UsersOrderingComposer get author {
    final $UsersOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.author,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $CommentsAnnotationComposer extends Composer<_$TaskDatabase, Comments> {
  $CommentsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get authorName => $composableBuilder(
    column: $table.authorName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<int> get created =>
      $composableBuilder(column: $table.created, builder: (column) => column);

  $TasksAnnotationComposer get taskId {
    final $TasksAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TasksAnnotationComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $UsersAnnotationComposer get author {
    final $UsersAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.author,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $CommentsTableManager
    extends
        RootTableManager<
          _$TaskDatabase,
          Comments,
          Comment,
          $CommentsFilterComposer,
          $CommentsOrderingComposer,
          $CommentsAnnotationComposer,
          $CommentsCreateCompanionBuilder,
          $CommentsUpdateCompanionBuilder,
          (Comment, $CommentsReferences),
          Comment,
          PrefetchHooks Function({bool taskId, bool author})
        > {
  $CommentsTableManager(_$TaskDatabase db, Comments table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $CommentsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $CommentsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $CommentsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> taskId = const Value.absent(),
                Value<int?> author = const Value.absent(),
                Value<String> authorName = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<int> created = const Value.absent(),
              }) => CommentsCompanion(
                id: id,
                taskId: taskId,
                author: author,
                authorName: authorName,
                body: body,
                created: created,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int taskId,
                Value<int?> author = const Value.absent(),
                required String authorName,
                required String body,
                required int created,
              }) => CommentsCompanion.insert(
                id: id,
                taskId: taskId,
                author: author,
                authorName: authorName,
                body: body,
                created: created,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (e.readTable(table), $CommentsReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({taskId = false, author = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (taskId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.taskId,
                                referencedTable: $CommentsReferences
                                    ._taskIdTable(db),
                                referencedColumn: $CommentsReferences
                                    ._taskIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (author) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.author,
                                referencedTable: $CommentsReferences
                                    ._authorTable(db),
                                referencedColumn: $CommentsReferences
                                    ._authorTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $CommentsProcessedTableManager =
    ProcessedTableManager<
      _$TaskDatabase,
      Comments,
      Comment,
      $CommentsFilterComposer,
      $CommentsOrderingComposer,
      $CommentsAnnotationComposer,
      $CommentsCreateCompanionBuilder,
      $CommentsUpdateCompanionBuilder,
      (Comment, $CommentsReferences),
      Comment,
      PrefetchHooks Function({bool taskId, bool author})
    >;
typedef $AttachmentsCreateCompanionBuilder =
    AttachmentsCompanion Function({
      Value<int> id,
      required int taskId,
      required String name,
      required String path,
      required int created,
    });
typedef $AttachmentsUpdateCompanionBuilder =
    AttachmentsCompanion Function({
      Value<int> id,
      Value<int> taskId,
      Value<String> name,
      Value<String> path,
      Value<int> created,
    });

final class $AttachmentsReferences
    extends BaseReferences<_$TaskDatabase, Attachments, Attachment> {
  $AttachmentsReferences(super.$_db, super.$_table, super.$_typedResult);

  static Tasks _taskIdTable(_$TaskDatabase db) => db.tasks.createAlias(
    $_aliasNameGenerator(db.attachments.taskId, db.tasks.id),
  );

  $TasksProcessedTableManager get taskId {
    final $_column = $_itemColumn<int>('task_id')!;

    final manager = $TasksTableManager(
      $_db,
      $_db.tasks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_taskIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $AttachmentsFilterComposer extends Composer<_$TaskDatabase, Attachments> {
  $AttachmentsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnFilters(column),
  );

  $TasksFilterComposer get taskId {
    final $TasksFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TasksFilterComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $AttachmentsOrderingComposer
    extends Composer<_$TaskDatabase, Attachments> {
  $AttachmentsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnOrderings(column),
  );

  $TasksOrderingComposer get taskId {
    final $TasksOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TasksOrderingComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $AttachmentsAnnotationComposer
    extends Composer<_$TaskDatabase, Attachments> {
  $AttachmentsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<int> get created =>
      $composableBuilder(column: $table.created, builder: (column) => column);

  $TasksAnnotationComposer get taskId {
    final $TasksAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TasksAnnotationComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $AttachmentsTableManager
    extends
        RootTableManager<
          _$TaskDatabase,
          Attachments,
          Attachment,
          $AttachmentsFilterComposer,
          $AttachmentsOrderingComposer,
          $AttachmentsAnnotationComposer,
          $AttachmentsCreateCompanionBuilder,
          $AttachmentsUpdateCompanionBuilder,
          (Attachment, $AttachmentsReferences),
          Attachment,
          PrefetchHooks Function({bool taskId})
        > {
  $AttachmentsTableManager(_$TaskDatabase db, Attachments table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $AttachmentsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $AttachmentsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $AttachmentsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> taskId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> path = const Value.absent(),
                Value<int> created = const Value.absent(),
              }) => AttachmentsCompanion(
                id: id,
                taskId: taskId,
                name: name,
                path: path,
                created: created,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int taskId,
                required String name,
                required String path,
                required int created,
              }) => AttachmentsCompanion.insert(
                id: id,
                taskId: taskId,
                name: name,
                path: path,
                created: created,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $AttachmentsReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({taskId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (taskId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.taskId,
                                referencedTable: $AttachmentsReferences
                                    ._taskIdTable(db),
                                referencedColumn: $AttachmentsReferences
                                    ._taskIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $AttachmentsProcessedTableManager =
    ProcessedTableManager<
      _$TaskDatabase,
      Attachments,
      Attachment,
      $AttachmentsFilterComposer,
      $AttachmentsOrderingComposer,
      $AttachmentsAnnotationComposer,
      $AttachmentsCreateCompanionBuilder,
      $AttachmentsUpdateCompanionBuilder,
      (Attachment, $AttachmentsReferences),
      Attachment,
      PrefetchHooks Function({bool taskId})
    >;
typedef $TaskHistoryCreateCompanionBuilder =
    TaskHistoryCompanion Function({
      Value<int> id,
      required int taskId,
      required String kind,
      Value<String?> oldStatus,
      required String newStatus,
      Value<int?> actor,
      required String actorName,
      Value<String?> oldAssignee,
      Value<String?> newAssignee,
      Value<int?> undoOf,
      required int created,
    });
typedef $TaskHistoryUpdateCompanionBuilder =
    TaskHistoryCompanion Function({
      Value<int> id,
      Value<int> taskId,
      Value<String> kind,
      Value<String?> oldStatus,
      Value<String> newStatus,
      Value<int?> actor,
      Value<String> actorName,
      Value<String?> oldAssignee,
      Value<String?> newAssignee,
      Value<int?> undoOf,
      Value<int> created,
    });

final class $TaskHistoryReferences
    extends BaseReferences<_$TaskDatabase, TaskHistory, TaskHistoryData> {
  $TaskHistoryReferences(super.$_db, super.$_table, super.$_typedResult);

  static Tasks _taskIdTable(_$TaskDatabase db) => db.tasks.createAlias(
    $_aliasNameGenerator(db.taskHistory.taskId, db.tasks.id),
  );

  $TasksProcessedTableManager get taskId {
    final $_column = $_itemColumn<int>('task_id')!;

    final manager = $TasksTableManager(
      $_db,
      $_db.tasks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_taskIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static Users _actorTable(_$TaskDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.taskHistory.actor, db.users.id),
  );

  $UsersProcessedTableManager? get actor {
    final $_column = $_itemColumn<int>('actor');
    if ($_column == null) return null;
    final manager = $UsersTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_actorTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $TaskHistoryFilterComposer extends Composer<_$TaskDatabase, TaskHistory> {
  $TaskHistoryFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get oldStatus => $composableBuilder(
    column: $table.oldStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get newStatus => $composableBuilder(
    column: $table.newStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actorName => $composableBuilder(
    column: $table.actorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get oldAssignee => $composableBuilder(
    column: $table.oldAssignee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get newAssignee => $composableBuilder(
    column: $table.newAssignee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get undoOf => $composableBuilder(
    column: $table.undoOf,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnFilters(column),
  );

  $TasksFilterComposer get taskId {
    final $TasksFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TasksFilterComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $UsersFilterComposer get actor {
    final $UsersFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.actor,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $TaskHistoryOrderingComposer
    extends Composer<_$TaskDatabase, TaskHistory> {
  $TaskHistoryOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get oldStatus => $composableBuilder(
    column: $table.oldStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get newStatus => $composableBuilder(
    column: $table.newStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actorName => $composableBuilder(
    column: $table.actorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get oldAssignee => $composableBuilder(
    column: $table.oldAssignee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get newAssignee => $composableBuilder(
    column: $table.newAssignee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get undoOf => $composableBuilder(
    column: $table.undoOf,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnOrderings(column),
  );

  $TasksOrderingComposer get taskId {
    final $TasksOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TasksOrderingComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $UsersOrderingComposer get actor {
    final $UsersOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.actor,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $TaskHistoryAnnotationComposer
    extends Composer<_$TaskDatabase, TaskHistory> {
  $TaskHistoryAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get oldStatus =>
      $composableBuilder(column: $table.oldStatus, builder: (column) => column);

  GeneratedColumn<String> get newStatus =>
      $composableBuilder(column: $table.newStatus, builder: (column) => column);

  GeneratedColumn<String> get actorName =>
      $composableBuilder(column: $table.actorName, builder: (column) => column);

  GeneratedColumn<String> get oldAssignee => $composableBuilder(
    column: $table.oldAssignee,
    builder: (column) => column,
  );

  GeneratedColumn<String> get newAssignee => $composableBuilder(
    column: $table.newAssignee,
    builder: (column) => column,
  );

  GeneratedColumn<int> get undoOf =>
      $composableBuilder(column: $table.undoOf, builder: (column) => column);

  GeneratedColumn<int> get created =>
      $composableBuilder(column: $table.created, builder: (column) => column);

  $TasksAnnotationComposer get taskId {
    final $TasksAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $TasksAnnotationComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $UsersAnnotationComposer get actor {
    final $UsersAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.actor,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $UsersAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $TaskHistoryTableManager
    extends
        RootTableManager<
          _$TaskDatabase,
          TaskHistory,
          TaskHistoryData,
          $TaskHistoryFilterComposer,
          $TaskHistoryOrderingComposer,
          $TaskHistoryAnnotationComposer,
          $TaskHistoryCreateCompanionBuilder,
          $TaskHistoryUpdateCompanionBuilder,
          (TaskHistoryData, $TaskHistoryReferences),
          TaskHistoryData,
          PrefetchHooks Function({bool taskId, bool actor})
        > {
  $TaskHistoryTableManager(_$TaskDatabase db, TaskHistory table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $TaskHistoryFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $TaskHistoryOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $TaskHistoryAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> taskId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String?> oldStatus = const Value.absent(),
                Value<String> newStatus = const Value.absent(),
                Value<int?> actor = const Value.absent(),
                Value<String> actorName = const Value.absent(),
                Value<String?> oldAssignee = const Value.absent(),
                Value<String?> newAssignee = const Value.absent(),
                Value<int?> undoOf = const Value.absent(),
                Value<int> created = const Value.absent(),
              }) => TaskHistoryCompanion(
                id: id,
                taskId: taskId,
                kind: kind,
                oldStatus: oldStatus,
                newStatus: newStatus,
                actor: actor,
                actorName: actorName,
                oldAssignee: oldAssignee,
                newAssignee: newAssignee,
                undoOf: undoOf,
                created: created,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int taskId,
                required String kind,
                Value<String?> oldStatus = const Value.absent(),
                required String newStatus,
                Value<int?> actor = const Value.absent(),
                required String actorName,
                Value<String?> oldAssignee = const Value.absent(),
                Value<String?> newAssignee = const Value.absent(),
                Value<int?> undoOf = const Value.absent(),
                required int created,
              }) => TaskHistoryCompanion.insert(
                id: id,
                taskId: taskId,
                kind: kind,
                oldStatus: oldStatus,
                newStatus: newStatus,
                actor: actor,
                actorName: actorName,
                oldAssignee: oldAssignee,
                newAssignee: newAssignee,
                undoOf: undoOf,
                created: created,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $TaskHistoryReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({taskId = false, actor = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (taskId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.taskId,
                                referencedTable: $TaskHistoryReferences
                                    ._taskIdTable(db),
                                referencedColumn: $TaskHistoryReferences
                                    ._taskIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (actor) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.actor,
                                referencedTable: $TaskHistoryReferences
                                    ._actorTable(db),
                                referencedColumn: $TaskHistoryReferences
                                    ._actorTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $TaskHistoryProcessedTableManager =
    ProcessedTableManager<
      _$TaskDatabase,
      TaskHistory,
      TaskHistoryData,
      $TaskHistoryFilterComposer,
      $TaskHistoryOrderingComposer,
      $TaskHistoryAnnotationComposer,
      $TaskHistoryCreateCompanionBuilder,
      $TaskHistoryUpdateCompanionBuilder,
      (TaskHistoryData, $TaskHistoryReferences),
      TaskHistoryData,
      PrefetchHooks Function({bool taskId, bool actor})
    >;

class $TaskDatabaseManager {
  final _$TaskDatabase _db;
  $TaskDatabaseManager(this._db);
  $UsersTableManager get users => $UsersTableManager(_db, _db.users);
  $ProjectsTableManager get projects =>
      $ProjectsTableManager(_db, _db.projects);
  $ProjectMembersTableManager get projectMembers =>
      $ProjectMembersTableManager(_db, _db.projectMembers);
  $TasksTableManager get tasks => $TasksTableManager(_db, _db.tasks);
  $CommentsTableManager get comments =>
      $CommentsTableManager(_db, _db.comments);
  $AttachmentsTableManager get attachments =>
      $AttachmentsTableManager(_db, _db.attachments);
  $TaskHistoryTableManager get taskHistory =>
      $TaskHistoryTableManager(_db, _db.taskHistory);
}
