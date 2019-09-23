#ifndef DATAACCESSOR_H
#define DATAACCESSOR_H

#include "recordlist.h"
#include <QtSql>


class DataAccessor
{
public:
    DataAccessor();
    void fillPlansList (Plans *recordLists);
private:
    QSqlDatabase dataBase;
};

#endif // DATAACCESSOR_H
