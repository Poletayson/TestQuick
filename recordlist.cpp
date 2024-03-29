#include "recordlist.h"

RecordsList::RecordsList(DataAccessor *daA, QObject *parent) : QAbstractListModel(parent)
{
    roles = QAbstractListModel::roleNames();
    roles[PlanRole] = "plan";
    roles[NameRole] = "name";
    roles[IdRole] = "id";
    roles[IsBougtRole] = "isBought";

    da = daA;
}

int RecordsList::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED (parent)
    return records.count();
}

QVariant RecordsList::data(const QModelIndex &index, int role) const
{
    if (!index.isValid()) {
        return QVariant();
    }

    switch (role) {
    case IdRole:
        return records.at(index.row()).getId();
    case NameRole:
        return records.at(index.row()).getName();
    case PlanRole:
        return records.at(index.row()).getPlanId();
    case IsBougtRole:
        return records.at(index.row()).getIsBought();
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> RecordsList::roleNames() const
{
    return roles;
}

bool RecordsList::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!index.isValid()){
        return false;
    }

    switch (role) {
    case IdRole:
        return false;   // This property can not be set
    case PlanRole:
        records[index.row()].setPlanId(value.toInt());
        break;
    case NameRole:
        records[index.row()].setName(value.toString());
        break;
    case IsBougtRole:
        if (da->setRecordIsBought(value.toBool(), records[index.row()].getId()))
            records[index.row()].setIsBought(value.toBool());
        else
            return false;
        break;
    default:
        return false;
    }

    emit dataChanged(index, index, QVector<int>() << role);

    return true;
}



void RecordsList::fillRecords(int planId)
{
    beginRemoveRows(QModelIndex(), 0, records.size() - 1);
    endRemoveRows();
    records = da->getRecordsList(planId);
    beginInsertRows(QModelIndex(), 0, records.size() - 1);
    endInsertRows();
}

Qt::ItemFlags RecordsList::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::ItemIsEnabled;

    return QAbstractListModel::flags(index) | Qt::ItemIsEditable;
}


void RecordsList::add(const QString name, int planId)
{
    Record record = da->insertRecord(name, false, planId);

    if (record.getId() != -1)
    {
        beginInsertRows(QModelIndex(), records.size(), records.size());
        records.append(record);
        endInsertRows();

        QModelIndex index = createIndex(0, 0, static_cast<void *>(nullptr));
        emit dataChanged(index, createIndex(records.size()-1, 0, static_cast<void *>(nullptr)));
    }
}

bool RecordsList::removeRows(int row, int count, const QModelIndex &parent)
{
    Q_UNUSED (parent)
    if (row + count <= records.count()) {
        beginRemoveRows(QModelIndex(), row, row + count - 1);
        for (int i = row; i < row + count; ++i)
            if (da->deleteRecord(records[i].getId()))
                records.removeAt(i);
        endRemoveRows();
        return true;
    }

    return false;
}

PlansList::PlansList(DataAccessor *daA, QObject *parent) : QAbstractListModel(parent)
{
    roles = QAbstractListModel::roleNames();
    roles[NameRole] = "name";
    roles[DateRole] = "date";
    roles[IdRole] = "id";
    roles[CountAllRecords] = "countAllRecords";
    roles[CountBoughtRecords] = "countBoughtRecords";

    da = daA;
}

int PlansList::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return plans.count();
}

QVariant PlansList::data(const QModelIndex &index, int role) const
{
    if (!index.isValid()) {
        return QVariant();
    }

    switch (role) {
    case IdRole:
        return plans[index.row()].getId();
    case NameRole:
        return plans[index.row()].getName();
    case DateRole:
        return plans[index.row()].getDate();
    case CountAllRecords:
        return plans.at(index.row()).getCountAllRecords();
    case CountBoughtRecords:
        return plans.at(index.row()).getCountBoughtRecords();
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> PlansList::roleNames() const
{
    return roles;
}

bool PlansList::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!index.isValid()){
        return false;
    }

    switch (role) {
    case IdRole:
        return false;   // This property can not be set
    case NameRole:
        plans[index.row()].setName(value.toString());
        break;
    case DateRole:
        plans[index.row()].setDate(value.toString());
        break;
    default:
        return false;
    }

    emit dataChanged(index, index, QVector<int>() << role);

    return true;
}

Qt::ItemFlags PlansList::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::ItemIsEnabled;

    return QAbstractListModel::flags(index) | Qt::ItemIsEditable;
}

void PlansList::add(const QString name, const QString date)
{
    Plan plan = da->insertPlan(name, date);


    if (plan.getId() != -1)
    {
        beginInsertRows(QModelIndex(), plans.size(), plans.size());
        plans.append(plan);
        endInsertRows();

        QModelIndex index = createIndex(0, 0, static_cast<void *>(nullptr));
        emit dataChanged(index, createIndex(plans.size()-1, 0, static_cast<void *>(nullptr)));
    }
}

bool PlansList::removeRow(int row, const QModelIndex &parent)
{
    Q_UNUSED (parent)
    if (row < plans.count()){
        if (da->deletePlan(plans[row].getId())) {
            beginRemoveRows(QModelIndex(), row, row);
            plans.removeAt(row);
            endRemoveRows();
            return true;
        }
    }

    return false;
}

void PlansList::fillPlans()
{
    plans = da->getPlansList();
    beginInsertRows(QModelIndex(), 0, plans.size() - 1);
    endInsertRows();
}

int PlansList::getRecordsCount(int row, bool isBoughtProperty)
{
    return da->getRecordsCount(row, isBoughtProperty);
}

bool PlansList::refreshCounts(const int index)
{
   QModelIndex indexPlan = createIndex(index, 0, static_cast<void *>(nullptr));
    if (!indexPlan.isValid()){
        return false;
    }

    plans[index].setCountAllRecords(da->getRecordsCount(plans[index].getId(), false) + da->getRecordsCount(plans[index].getId(), true));
    plans[index].setCountBoughtRecords(da->getRecordsCount(plans[index].getId(), true));

    emit dataChanged(indexPlan, indexPlan, QVector<int>() << CountAllRecords << CountBoughtRecords);

    return true;
}


