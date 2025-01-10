module hello_world;
import std::io;
import c3qlite;

fn int callback(void* whatever, int argc, ZString* argv, ZString* azColName)
{
   int i;
   for(i = 0; i<argc; i++) {
      io::printf("%s = %s\n", azColName[i], argv[i] ? argv[i] : (ZString)"NULL");
   }
   io:: printf("\n");
   return 0;
}

fn void main()
{
    io::printn("Hello, world!");
    SqliteDb db;
    int res = c3qlite::sqliteOpen("c:\\gitsNon\\c3qlite\\output\\hello_world.db", &db);
    io::printfn("!!! DB OPENING RESULT: %d !!!", res);

    ZString errmsg;
    ZString sql = "CREATE TABLE COMPANY("
    "NAME           TEXT    NOT NULL,"
    " AGE            INT     NOT NULL,"
    " ADDRESS        CHAR(50),"
    " SALARY         REAL, SALARY3         REAL );";
    
    io::printn(sql);
    c3qlite::sqliteExec(db, sql, &callback, null, &errmsg);
    io::printfn("!!! EXECUTION RETURNED AN ERROR: %s !!!", errmsg);

    sql = "INSERT INTO COMPANY (NAME,AGE,ADDRESS,SALARY) VALUES ('Paul', 32, 'California', 20000.00 ); ";
    c3qlite::sqliteExec(db, sql, &callback, null, &errmsg);
    io::printfn("!!! EXECUTION RETURNED AN ERROR: %s !!!", errmsg);

    sql = "SELECT * FROM COMPANY;";
    c3qlite::sqliteExec(db, sql, &callback, null, &errmsg);

    io::printfn("!!! EXECUTION RETURNED AN ERROR: %s !!!", errmsg);
    c3qlite::sqliteClose(db);
}