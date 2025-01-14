module hello_world;
import std::io;
import libc;
import c3qlite;
import std::collections::list;

struct Employee{
   String nameStr;
   ZString name;
   int age;
   ZString address;
   double salary;
}

fn int callback(void* whatever, int argc, ZString* argv, ZString* azColName)
{
   int i;
   //io::printfn("!!! NAME: %s !!!", ((Employee*)whatever).name);

   Employee* emp;
   if(whatever != null)
   {
      emp = (Employee*)whatever;
   }

   for(i = 0; i<argc; i++) {
      //io::printfn("AZCOLNAME: %s", azColName[i]);

      if(libc::strcmp(azColName[i], (ZString)"NAME") == 0) {
         //io::printfn("!!! NAME: %s !!!", argv[i]);
         //libc::s(emp.name, argv[i], ZString.len(argv[i]));
         emp.name = String.zstr_copy(ZString.str_view(argv[i]));// (ZString)"\0";
      }
      else if(libc::strcmp(azColName[i], (ZString)"AGE") == 0) {
         //io::printfn("!!! AGE: %s !!!", argv[i]);
         emp.age = libc::atoi(argv[i]);
      }
      else if(libc::strcmp(azColName[i], (ZString)"ADDRESS") == 0) {
         //io::printfn("!!! ADDRESS: %s !!!", argv[i]);
         emp.address = String.zstr_copy(ZString.str_view(argv[i]));
      }
      else if(libc::strcmp(azColName[i], (ZString)"SALARY") == 0) {
         //io::printfn("!!! SALARY: %s !!!", argv[i]);
         emp.salary = libc::atof(argv[i]);
      }
      //io::printf("%s = %s\n", azColName[i], argv[i] ? argv[i] : (ZString)"NULL");
   }
   //io::printfn("name: %s, age: %s, address: %s, salary: %s", emp.name, emp.age, emp.address, ep.salary);
   //io::printn(&emp.name);
   //io:: printf("\n ===================================== \n");
   return 0;
}

fn int callback2(void* whatever, int argc, ZString* argv, ZString* azColName)
{
   int i;
   //io::printfn("!!! NAME: %s !!!", ((Employee*)whatever).name);

   List(<Employee>)* employees = whatever;
   //employees.new_init();
   Employee emp = Employee{};
   for(i = 0; i<argc; i++) {
      //io::printfn("AZCOLNAME: %s", azColName[i]);
      if(libc::strcmp(azColName[i], (ZString)"NAME") == 0) {
         //io::printfn("!!! NAME: %s !!!", argv[i]);
         //libc::s(emp.name, argv[i], ZString.len(argv[i]));
         emp.name = String.zstr_copy(ZString.str_view(argv[i]));// (ZString)"\0";
      }
      else if(libc::strcmp(azColName[i], (ZString)"AGE") == 0) {
         //io::printfn("!!! AGE: %s !!!", argv[i]);
         emp.age = libc::atoi(argv[i]);
      }
      else if(libc::strcmp(azColName[i], (ZString)"ADDRESS") == 0) {
         //io::printfn("!!! ADDRESS: %s !!!", argv[i]);
         emp.address = String.zstr_copy(ZString.str_view(argv[i]));
      }
      else if(libc::strcmp(azColName[i], (ZString)"SALARY") == 0) {
         //io::printfn("!!! SALARY: %s !!!", argv[i]);
         emp.salary = libc::atof(argv[i]);
      }
      //io::printf("%s = %s\n", azColName[i], argv[i] ? argv[i] : (ZString)"NULL");
   }
         employees.push(emp);

   //io::printfn("name: %s, age: %s, address: %s, salary: %s", emp.name, emp.age, emp.address, ep.salary);
   //io::printn(&emp.name);
   //io:: printf("\n ===================================== \n");
   return 0;
}

fn void setName(Employee* emp, ZString name)
{
   emp.name = name;
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
    
   //io::printn(sql);
    //c3qlite::sqliteExec(db, sql, null, null, &errmsg);
    //io::printfn("!!! EXECUTION RETURNED AN ERROR: %s !!!", errmsg);

   //  sql = "INSERT INTO COMPANY (NAME,AGE,ADDRESS,SALARY) VALUES ('Paul', 32, 'California', 20000.00 ); ";
   //  c3qlite::sqliteExec(db, sql, null, null, &errmsg);
   //  io::printfn("!!! EXECUTION RETURNED AN ERROR: %s !!!", errmsg);

    sql = "SELECT * FROM COMPANY;";
   //  Employee* emp = mem::new(Employee);
   //  emp.name = (ZString)"xd";
   //  io::printn(emp.name);

   //  c3qlite::sqliteExec(db, sql, &callback, emp, &errmsg);

   // io::printfn("name: %s, age: %d, address: %s, salary: %s", emp.name, emp.age, emp.address, emp.salary);

   List(<Employee>) employees;
   employees.new_init();
   c3qlite::sqliteExec(db, sql, &callback2, &employees, &errmsg);

   int j = 0;
   foreach(emp2: employees){
   io::printfn("name: %s, age: %d, address: %s, salary: %s", emp2.name, emp2.age, emp2.address, emp2.salary);
   j++;
   }

   io::printfn("!!! EMPLOYEES LIST COUNT: %d !!!", j);

    //io::printfn("!!! EXECUTION RETURNED AN ERROR: %s !!!", errmsg);
    c3qlite::sqliteClose(db);
    //0x788899fc78


}