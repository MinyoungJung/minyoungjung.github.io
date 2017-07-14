---
layout: post
title: 안드로이드 SQLite에 대량의 레코드 삽입하기
category: [안드로이드, 데이터베이스]
tags: [Android, SQLite, Java, Database]
---

# 사용씬
안드로이드의 로컬 저장소인 SQLite에 대용량의 레코드를 한번에 삽입하려 한다.  
`ArrayList<Data> data` 안에 4만개의 레코드가 있다.  


# 통상정인 방법
## SqliteOpenHelper 내 메소드
``` java
public long insertData(Data data) {
    ContentValues cv = new ContentValues();
    cv.put(COLUMN_A, dataA);
    cv.put(COLUMN_B, dataB);
    cv.put(COLUMN_B, dataC);

    return getWritableDatabase().insert(TABLE_A, null, cv);
}
```
하나의 레코드를 삽입하는 메소드를 정의했다.

## insertData 사용
``` java
for (int i=0; i<data.size(); i++) {
    dbHelper.insertData(data.get(i));
}
```
for 문을 돌려서 Data를 삽입한다.


# 문제점
만약 4만개의 레코드를 한번에 저장하려면 위의 방법으로는 대략 1분이 넘어간다.  

``` java
long startTime = System.nanoTime();
    for (int i=0; i<data.size(); i++) {
    dbHelper.insertData(data.get(i));
}
long finishTime = System.nanoTime();
Log.e(TAG, "Write to DB takes: "+ (finishTime-startTime)/1e9 +" seconds");
```
위와 같이 시간을 확인해 보았을 때, 94.216414초가 걸렸다.

# 원인
이는 SQlite가 하나의 레코드를 생성할때 Transaction을 수행하며 저널 파일을 생성하기 때문인데,  
위의 방법으로는 4만여개의 저널파일을 생성하며 DB의 삽입 속도가 느려지게 된다.

# 해결책
하나의 Transaction으로 처리해 4만여개의 레코드를 한번에 삽입하며 저널파일을 한번만 생성하게 되면 된다.  
``` java
public void insertAllDatas(ArrayList<Data> datas) {
SQLiteDatabase db = getWritableDatabase();
db.beginTransaction();
try {
    for (int i=0; i<datas.size(); i++ ){
        ContentValues cv = new ContentValues();
        cv.put(COLUMN_A, dataA);
        cv.put(COLUMN_B, dataB);
        cv.put(COLUMN_B, dataC);
        db.insert(TABLE_A, null, cv);
    }
    db.setTransactionSuccessful();
} finally {
    db.endTransaction();
}
```
위의 방법으로 4만개의 레코드를 삽입할 때에는 2.813887초가 걸렸다.


