module hello_world;
import std::io;

extern fn int sqlite_open(ZString filename, SqliteDb* db) @extern("sqlite3_open"); 
extern fn int sqlite_close(SqliteDb) @extern("sqlite3_close");

extern fn int sqlite_exec(
  void*,                                  /* An open database */
  ZString sql,                           /* SQL to be evaluated */
  Callback,  /* Callback function */
  void *,                                    /* 1st argument to callback */
  ZString* errmsg                              /* Error msg written here */
) @extern("sqlite3_exec");

def Callback = fn int(SqliteDb, int argc, ZString* argv, ZString* azColName);

def SqliteDb = void*;

fn int callback(SqliteDb, int argc, ZString* argv, ZString* azColName)
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
    int res = sqlite_open("c:\\sh\\c3\\hello_world.db", &db);
    io::printfn("!!! DB OPENING RESULT: %d !!!", res);

    ZString errmsg;
    ZString sql = "CREATE TABLE COMPANY("
    "NAME           TEXT    NOT NULL,"
    " AGE            INT     NOT NULL,"
    " ADDRESS        CHAR(50),"
    " SALARY         REAL, SALARY3         REAL );";
    
    io::printn(sql);
    sqlite_exec(db, sql, &callback, null, &errmsg);
    io::printfn("!!! EXECUTION RETURNED AN ERROR: %s !!!", errmsg);

    sql = "INSERT INTO COMPANY (NAME,AGE,ADDRESS,SALARY) VALUES ('Paul', 32, 'California', 20000.00 ); ";
    sqlite_exec(db, sql, &callback, null, &errmsg);
        io::printfn("!!! EXECUTION RETURNED AN ERROR: %s !!!", errmsg);

    sql = "SELECT * FROM COMPANY;";
        sqlite_exec(db, sql, &callback, null, &errmsg);

            io::printfn("!!! EXECUTION RETURNED AN ERROR: %s !!!", errmsg);

    sqlite_close(db);
}