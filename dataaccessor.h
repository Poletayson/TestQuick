#ifndef DATAACCESSOR_H
#define DATAACCESSOR_H

//#include "recordlist.h"
#include <QtSql>
#include <QDebug>

class Plan
{
public:
    Plan (int idA, QString nameA, QString dateA);

    int getId() const;
    void setId(int value);

    QString getName() const;
    void setName(const QString &value);

    QString getDate() const;
    void setDate(const QString &value);

private:
    int id;
    QString name;
    QString date;
};

class Record
{
public:
    Record (int idA, int planIdA, QString nameA, bool isBoughtA);

    int getId() const;
    void setId(int value);

    int getPlanId() const;
    void setPlanId(int value);

    QString getName() const;
    void setName(const QString &value);

    bool getIsBought() const;
    void setIsBought(bool value);

private:
    int id;
    int planId;
    QString name;
    bool isBought;
};

class DataAccessor
{
public:
    DataAccessor();

    QList <Plan> getPlansList ();
    Plan insertPlan (const QString name, const QString date);
    bool deletePlan (int planId);
    int getRecordsCount (int planId, bool isBoughtProperty);

    QList <Record> getRecordsList (const int planId);
    Record insertRecord (const QString name, const bool isBought, const int planId);
    bool deleteRecord (int recordId);
    bool setRecordIsBought (bool isBought, int recordId);

private:
    QSqlDatabase dataBase;

    //bool deleteRecords (int planId);
};

#endif // DATAACCESSOR_H
