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

QList<Plan> DataAccessor::getPlansList()
{
    QList <Plan> plans;
    QSqlQuery query ("SELECT *"
                     "FROM plans", dataBase);
    while (query.next()) {
        plans.append(Plan(query.value(0).toInt(), query.value(1).toString(), query.value(2).toString()));//recordLists->add(query.value(1).toString(), query.value(2).toString(), query.value(0).toInt());
    }
    return plans;
}

Plan DataAccessor::insertPlan(const QString name, const QString date)
{
    QSqlQuery query;
    query.prepare("INSERT INTO plans (plan_name, date)"
                                  "VALUES (:name, :date);");
    query.bindValue(":name", name);
    query.bindValue(":date", date);
    if (query.exec())
        return Plan (query.lastInsertId().toInt(), name, date);
    else
        return Plan (-1, "", "");
}

Plan::Plan(int idA, QString nameA, QString dateA)
{
    id = idA;
    name = nameA;
    date = dateA;
}

int Plan::getId() const
{
    return id;
}

void Plan::setId(int value)
{
    id = value;
}

QString Plan::getName() const
{
    return name;
}

void Plan::setName(const QString &value)
{
    name = value;
}

QString Plan::getDate() const
{
    return date;
}

void Plan::setDate(const QString &value)
{
    date = value;
}

Record::Record(int idA, int planIdA, QString nameA, bool isBoughtA)
{
    id = idA;
    planId = planIdA;
    name = nameA;
    isBought = isBoughtA;
}

int Record::getId() const
{
    return id;
}

void Record::setId(int value)
{
    id = value;
}

int Record::getPlanId() const
{
    return planId;
}

void Record::setPlanId(int value)
{
    planId = value;
}

QString Record::getName() const
{
    return name;
}

void Record::setName(const QString &value)
{
    name = value;
}

bool Record::getIsBought() const
{
    return isBought;
}

void Record::setIsBought(bool value)
{
    isBought = value;
}
