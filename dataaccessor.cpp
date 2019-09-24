#include "dataaccessor.h"

DataAccessor::DataAccessor()
{
    bool isDbExists = QFile::exists("plans.sqlite");
    dataBase = QSqlDatabase::addDatabase("QSQLITE");
    dataBase.setDatabaseName("plans.sqlite");
    dataBase.open();
//    sdb.setDatabaseName(qApp->applicationDirPath()
//                        + QDir::separator()
//                        + "lang.sqlite" );

    if (!isDbExists) {
        QSqlQuery query;
        QString strQuery = "CREATE TABLE plans ("
                "id_plan INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
                "plan_name TEXT, "
                "date TEXT"
                ");";
       query.exec(strQuery);
       qDebug()<<"Ошибка созд: " << query.lastError().text();
       strQuery = "CREATE TABLE positions ("
                       "id_position INTEGER PRIMARY KEY  AUTOINCREMENT NOT NULL, "
                       "position_name TEXT, "
                       "is_bought INTEGER, "
                       "plan_id INTEGER NOT NULL, "
                       "FOREIGN KEY (plan_id) REFERENCES plans(id_plan)"
                       ");";
       query.exec(strQuery);
       qDebug()<<"Ошибка созд: " << query.lastError().text();
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

QList<Record> DataAccessor::getRecordsList(const int planId)
{
    QList <Record> positions;
    QSqlQuery query (QString ("SELECT *"
                     "FROM positions"
                     "WHERE plan_id = %1").arg(planId), dataBase);
    while (query.next()) {
        positions.append(Record(query.value(0).toInt(), query.value(3).toInt(), query.value(1).toString(), query.value(2).toBool()));//recordLists->add(query.value(1).toString(), query.value(2).toString(), query.value(0).toInt());
    }
    return positions;
}

Record DataAccessor::insertRecord(const QString name, const bool isBought, const int planId)
{
    QSqlQuery query;
    query.prepare("INSERT INTO positions (position_name, is_bought, plan_id)"
                                  "VALUES (:position_name, :is_bought, :plan_id);");
    query.bindValue(":position_name", name);
    query.bindValue(":is_bought", isBought);
    query.bindValue(":plan_id", planId);
    qDebug()<<"Параметры: " << query.boundValues().value(":position_name").toString() << " " << query.boundValues().value(":is_bought").toString() << " " <<query.boundValues().value(":plan_id").toString();
    if (query.exec())
        return Record (query.lastInsertId().toInt(), planId, name, isBought);
    else {
        qDebug()<<"Запись не добавлена! Ошибка: " << query.lastError().text();
        return Record (-1, -1, "", false);
    }
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
