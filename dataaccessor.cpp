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
    QSqlQuery query;
    if (!query.exec("PRAGMA foreign_keys=on"))
        qDebug()<<"Ошибка включения внешних ключей: " << query.lastError().text();

    if (!isDbExists) {

        QString strQuery = "CREATE TABLE plans ("
                "id_plan INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
                "plan_name TEXT, "
                "date TEXT"
                ");";
       if (!query.exec(strQuery))
           qDebug()<<"Ошибка созд: " << query.lastError().text();
       strQuery = "CREATE TABLE positions ("
                       "id_position INTEGER PRIMARY KEY  AUTOINCREMENT NOT NULL, "
                       "position_name TEXT, "
                       "is_bought INTEGER, "
                       "plan_id INTEGER NOT NULL, "
                       "FOREIGN KEY (plan_id) REFERENCES plans(id_plan) ON DELETE CASCADE"
                       ");";
       if (!query.exec(strQuery))
           qDebug()<<"Ошибка созд: " << query.lastError().text();
    }
}

QList<Plan> DataAccessor::getPlansList()
{
    QList <Plan> plans;
    QSqlQuery query ("SELECT *"
                     "FROM plans", dataBase);
    Plan planPtr;
    while (query.next()) {
        planPtr = Plan (query.value(0).toInt(), query.value(1).toString(), query.value(2).toString());
        planPtr.setCountAllRecords(getRecordsCount(planPtr.getId(), false) + getRecordsCount(planPtr.getId(), true));
        planPtr.setCountBoughtRecords(getRecordsCount(planPtr.getId(), true));
        plans.append(planPtr);
    }
    return plans;
}

Plan DataAccessor::insertPlan(const QString name, const QString date)
{
    QSqlQuery query;
    query.prepare("INSERT INTO plans (plan_name, date)"
                                  "VALUES (:name, :date)");
    query.bindValue(":name", name);
    query.bindValue(":date", date);
    Plan planPtr;
    if (query.exec()){
        planPtr = Plan (query.lastInsertId().toInt(), name, date);
        planPtr.setCountAllRecords(getRecordsCount(planPtr.getId(), false) + getRecordsCount(planPtr.getId(), true));
        planPtr.setCountBoughtRecords(getRecordsCount(planPtr.getId(), true));
        return planPtr;
    }
    else{
        return Plan (-1, "", "");
    }
}

bool DataAccessor::deletePlan(int planId)
{
    QSqlQuery query;
    query.prepare("DELETE FROM plans "
                  "WHERE id_plan = :plan_id");
    query.bindValue(":plan_id", planId);

    if (query.exec())
        return true;
    else {
        qDebug()<<"План не удален! Ошибка: " << query.lastError().text();
        return false;
    }
}

int DataAccessor::getRecordsCount(int planId, bool isBoughtProperty)
{
    QSqlQuery query;
    query.prepare("SELECT count (plan_id)"
                  "FROM positions "
                  "WHERE plan_id = :plid AND is_bought = :isBProperty");
    query.bindValue(":plid", planId);
    query.bindValue(":isBProperty", isBoughtProperty ? 1 : 0);
    if (!query.exec())
        qDebug()<<"Ошибка получения списка записей при подсчете: " << query.lastError().text();
    query.next();
    int count = query.value(0).toInt();
    //qDebug()<<"При значении " << isBoughtProperty << " получено " << count;
    return count;
}

QList<Record> DataAccessor::getRecordsList(const int planId)
{
    QList <Record> positions;

    QSqlQuery query;
    query.prepare("SELECT * "
                  "FROM positions "
                  "WHERE plan_id = :plid");
    query.bindValue(":plid", planId);
    if (!query.exec())
        qDebug()<<"Ошибка получения списка записей: " << query.lastError().text();
    while (query.next()) {
        positions.append(Record(query.value(0).toInt(), query.value(3).toInt(), query.value(1).toString(), query.value(2).toBool()));//recordLists->add(query.value(1).toString(), query.value(2).toString(), query.value(0).toInt());
    }
    return positions;
}

Record DataAccessor::insertRecord(const QString name, const bool isBought, const int planId)
{
    QSqlQuery query;
    query.prepare("INSERT INTO positions (position_name, is_bought, plan_id)"
                                  "VALUES (:position_name, :is_bought, :plan_id)");
    query.bindValue(":position_name", name);
    query.bindValue(":is_bought", isBought);
    query.bindValue(":plan_id", planId);
    //qDebug()<<"Параметры: " << query.boundValues().value(":position_name").toString() << " " << query.boundValues().value(":is_bought").toString() << " " <<query.boundValues().value(":plan_id").toString();
    if (query.exec())
        return Record (query.lastInsertId().toInt(), planId, name, isBought);
    else {
        qDebug()<<"Запись не добавлена! Ошибка: " << query.lastError().text();
        return Record (-1, -1, "", false);
    }
}

bool DataAccessor::deleteRecord(int recordId)
{
    QSqlQuery query;
    query.prepare("DELETE FROM positions "
                  "WHERE id_position = :pos_id");
    query.bindValue(":pos_id", recordId);

    if (query.exec())
        return true;
    else {
        qDebug()<<"Запись не удалена! Ошибка: " << query.lastError().text();
        return false;
    }
}

bool DataAccessor::setRecordIsBought(bool isBought, int recordId)
{
    QSqlQuery query;
    query.prepare("UPDATE positions "
                  "SET is_bought = :bought_param "
                  "WHERE id_position = :pos_id");
    query.bindValue(":bought_param", isBought ? 1 : 0);
    query.bindValue(":pos_id", recordId);

    if (query.exec())
        return true;
    else {
        qDebug()<<"Ошибка обновления: " << query.lastError().text();
        return false;
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

int Plan::getCountAllRecords() const
{
    return countAllRecords;
}

void Plan::setCountAllRecords(int value)
{
    countAllRecords = value;
}

int Plan::getCountBoughtRecords() const
{
    return countBoughtRecords;
}

void Plan::setCountBoughtRecords(int value)
{
    countBoughtRecords = value;
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
