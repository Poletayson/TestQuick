#include "dataaccessor.h"

DataAccessor::DataAccessor()
{
    dataBase = QSqlDatabase::addDatabase("QSQLITE");
    dataBase.setDatabaseName("plans.sqlite");

//    sdb.setDatabaseName(qApp->applicationDirPath()
//                        + QDir::separator()
//                        + "lang.sqlite" );

    if (!dataBase.open()) {
        QSqlQuery query;
        QString strQuery = "CREATE TABLE plans ("
                "id_plan INTEGER PRIMARY KEY NOT NULL, "
                "plan_name TEXT, "
                "date TEXT"
                ");";
       query.exec(strQuery);
       strQuery = "CREATE TABLE positions ("
                       "id_position INTEGER PRIMARY KEY NOT NULL, "
                       "position_name TEXT, "
                       "is_bought TEXT,"
                       "plan_id INTEGER NOT NULL,"
                       "FOREIGN KEY (plan_id) REFERENCES plans(id_plan)"
                       ");";
       query.exec(strQuery);
    }
}

void DataAccessor::fillPlansList(Plans *recordLists)
{

    QSqlQuery query ("SELECT *"
                     "FROM plans", dataBase);
    while (query.next()) {
        recordLists.
             QString country = query.value(0).toString();
             do_something(country);
    }
//    QString strQuery = "SELECT *"
//                       "FROM plans";
//   query.exec(strQuery);
}
