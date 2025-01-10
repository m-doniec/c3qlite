module hello_world;
import std::io;

extern fn int sqliteOpen(ZString filename, SqliteDb* db) @extern("sqlite3_open"); 
extern fn int sqliteClose(SqliteDb) @extern("sqlite3_close");
extern fn int sqliteExec(SqliteDb db, ZString sql, Callback cb, void * whatever, ZString* errmsg) @extern("sqlite3_exec");

def Callback = fn int(void* whatever, int argc, ZString* argv, ZString* azColName);
def SqliteDb = void*;

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
    int res = sqliteOpen("c:\\gitsNon\\c3qlite\\output\\hello_world.db", &db);
    io::printfn("!!! DB OPENING RESULT: %d !!!", res);

    ZString errmsg;
    ZString sql = "CREATE TABLE COMPANY("
    "NAME           TEXT    NOT NULL,"
    " AGE            INT     NOT NULL,"
    " ADDRESS        CHAR(50),"
    " SALARY         REAL, SALARY3         REAL );";
    
    io::printn(sql);
    sqliteExec(db, sql, &callback, null, &errmsg);
    io::printfn("!!! EXECUTION RETURNED AN ERROR: %s !!!", errmsg);

    sql = "INSERT INTO COMPANY (NAME,AGE,ADDRESS,SALARY) VALUES ('Paul', 32, 'California', 20000.00 ); ";
    sqliteExec(db, sql, &callback, null, &errmsg);
    io::printfn("!!! EXECUTION RETURNED AN ERROR: %s !!!", errmsg);

    sql = "SELECT * FROM COMPANY;";
    sqliteExec(db, sql, &callback, null, &errmsg);

    io::printfn("!!! EXECUTION RETURNED AN ERROR: %s !!!", errmsg);
    sqliteClose(db);
}