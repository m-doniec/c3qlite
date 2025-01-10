module c3qlite;

extern fn int sqliteOpen(ZString filename, SqliteDb* db) @extern("sqlite3_open"); 
extern fn int sqliteClose(SqliteDb) @extern("sqlite3_close");
extern fn int sqliteExec(SqliteDb db, ZString sql, Callback cb, void * whatever, ZString* errmsg) @extern("sqlite3_exec");

def Callback = fn int(void* whatever, int argc, ZString* argv, ZString* azColName);
def SqliteDb = void*;