#include "recordlist.h"

RecordsList::RecordsList(DataAccessor *daA, QObject *parent) : QAbstractListModel(parent)
{
    roles = QAbstractListModel::roleNames();
    roles[PlanRole] = "plan";
    roles[NameRole] = "name";
    roles[IdRole] = "id";
    roles[IsBougtRole] = "isBougt";

    da = daA;
//    names.append("Test");
//    isBoughtMarks.append(false);
//    lists.append(0);
}

int RecordsList::rowCount(const QModelIndex &parent) const
{
//    if (!parent.isValid())
//        return 0;
    return records.count();//names.size();
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
//    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
//    roles[NameRole] = "position";
//    roles[PlanRole] = "listShoping";
//    roles[IsBougtRole] = "isBought";

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
        records[index.row()].setIsBought(value.toBool());
        break;
    default:
        return false;
    }

    emit dataChanged(index, index, QVector<int>() << role);

    return true;
}

bool RecordsList::removeRow(int row, const QModelIndex &parent)
{
    if (row < records.count()){
        beginRemoveRows(QModelIndex(), row, row);
        records.removeAt(row);
        endRemoveRows();
        return true;
    }

    return false;
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

        QModelIndex index = createIndex(0, 0, static_cast<void *>(0));
        emit dataChanged(index, createIndex(records.size()-1, 0, static_cast<void *>(0)));
    }
}

PlansList::PlansList(DataAccessor *daA, QObject *parent) : QAbstractListModel(parent)
{
    roles = QAbstractListModel::roleNames();
    roles[NameRole] = "name";
    roles[DateRole] = "date";
    roles[IdRole] = "id";

    da = daA;
}

int PlansList::rowCount(const QModelIndex &parent) const
{
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

        QModelIndex index = createIndex(0, 0, static_cast<void *>(0));
        emit dataChanged(index, createIndex(plans.size()-1, 0, static_cast<void *>(0)));
    }
}

bool PlansList::removeRow(int row, const QModelIndex &parent)
{

}

void PlansList::fillPlans()
{
    plans = da->getPlansList();
    beginInsertRows(QModelIndex(), 0, plans.size() - 1);
    endInsertRows();
}


