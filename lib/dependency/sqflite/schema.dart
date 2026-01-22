class SqfliteSchema {
  static const _idType = 'TEXT PRIMARY KEY';
  static const _textType = 'TEXT';
  static const _boolType = 'INTEGER'; // 0: false, 1: true
  static const _realType = 'REAL'; // Dùng cho scroll offset (double)
  // static const _intType = 'INTEGER';

  /// *format time as String = isO8601String()*

  /// --------- Table Creation Queries --------- ///
  static const createConfigsTable = '''
      CREATE TABLE configs (
        id $_idType,
        fontFamily $_textType,
        fontSize $_realType,
        lineHeight $_realType,
        themeMode $_textType,
        timeStamp $_textType
      )
    ''';

  static const createSystemConfigsTable = '''
      CREATE TABLE system_configs (
        id $_idType,
        themeMode $_textType,
        typeListDisplay $_textType,
        locale $_textType,
        timeStamp $_textType 
      )
    ''';

  static const createChaptersTable = '''
      CREATE TABLE chapters (
        id $_idType,
        bookId $_textType,
        listChapterItemData $_textType,
        timeStamp $_textType,
        FOREIGN KEY (bookId) REFERENCES books (id) ON DELETE CASCADE
      )
    ''';

  static const createBooksTable = '''
      CREATE TABLE books (
        id $_idType, 
        storyData $_textType,
        currentChapterId $_textType,
        scrollOffset $_realType,
        isFavorite $_boolType,
        lastReadTime $_textType,
        isLocal $_boolType DEFAULT 0,
        timeStamp $_textType
      )
    ''';

  static const createRouterTable = '''
      CREATE TABLE routes (
        id $_idType,
        routeName $_textType,
        bookId $_textType,
        timeStamp $_textType,
        FOREIGN KEY (bookId) REFERENCES books (id) ON DELETE CASCADE
      )
    ''';

  static const addIsLocalToBooks = '''
    ALTER TABLE books ADD COLUMN isLocal $_boolType DEFAULT 0
  ''';

  static const createChapterContentsTable = '''
    CREATE TABLE chapter_contents (
      id $_idType,
      chapterId $_textType,
      content $_textType, 
      FOREIGN KEY (chapterId) REFERENCES chapters (id) ON DELETE CASCADE
    )
  ''';

  SqfliteSchema._();
}
