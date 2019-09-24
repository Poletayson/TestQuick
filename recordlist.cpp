#include "recordlist.h"

Records::Records(QObject *parent) : QAbstractListModel(parent)
{
//    roles = QAbstractListModel::roleNames();
//    roles[ListRole] = "list";
//    roles[NameRole] = "name";
//    roles[IsBougtRole] = "isBougt";


    names.append("Test");
    isBoughtMarks.append(false);
    lists.append(0);
}

int Records::rowCount(const QModelIndex &parent) const
{
//    if (!parent.isValid())
//        return 0;
    return names.size();
}

QVariant Records::data(const QModelIndex &index, int role) const
{
    if (!index.isValid()) {
        return QVariant();
    }

    switch (role) {
    case NameRole:
        return names.at(index.row());
    case PlanRole:
        return lists.at(index.row());
    case IsBougtRole:
        return isBoughtMarks.at(index.row());
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> Records::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
    roles[NameRole] = "position";
    roles[PlanRole] = "listShoping";
    roles[IsBougtRole] = "isBought";

    return roles;
}

bool Records::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!index.isValid()){
        return false;
    }

    switch (role) {
    case PlanRole:
        return false;   // This property can not be set
    case NameRole:
        names[index.row()] = value.toString();
        break;
    case IsBougtRole:
        isBoughtMarks[index.row()] = value.toBool();
        break;
    default:
        return false;
    }

    emit dataChanged(index, index, QVector<int>() << role);

    return true;
}

bool Records::removeRow(int row, const QModelIndex &parent)
{
    if (row < names.count()){
        beginRemoveRows(QModelIndex(), row, row);
        names.removeAt(row);
        lists.removeAt(row);
        isBoughtMarks.removeAt(row);
        return true;
    }

    return false;
}

Qt::ItemFlags Records::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::ItemIsEnabled;

    return QAbstractListModel::flags(index) | Qt::ItemIsEditable;
}


void Records::add(const QString name)
{
    beginInsertRows(QModelIndex(), names.size(), names.size());
    names.append(name);
    lists.append(0);
    isBoughtMarks.append(false);
    endInsertRows();

    //m_data[0] = QString("Size: %1").arg(m_data.size());
    QModelIndex index = createIndex(0, 0, static_cast<void *>(0));
    emit dataChanged(index, createIndex(names.size()-1, 0, static_cast<void *>(0)));
}

Plans::Plans(QObject *parent) : QAbstractListModel(parent)
{
    roles = QAbstractListModel::roleNames();
    roles[NameRole] = "name";
    roles[DateRole] = "date";
    roles[IdRole] = "id";
}

int Plans::rowCount(const QModelIndex &parent) const
{
    return names.size();
}

QVariant Plans::data(const QModelIndex &index, int role) const
{
    if (!index.isValid()) {
        return QVariant();
    }

    switch (role) {
    case NameRole:
        return names.at(index.row());
    case DateRole:
        return dates.at(index.row());
    case IdRole:
        return ids.at(index.row());
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> Plans::roleNames() const
{
    return roles;
}

bool Plans::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!index.isValid()){
        return false;
    }

    switch (role) {
    case IdRole:
        return false;   // This property can not be set
    case NameRole:
        names[index.row()] = value.toString();
        break;
    case DateRole:
        dates[index.row()] = value.toString();
        break;
    default:
        return false;
    }

    emit dataChanged(index, index, QVector<int>() << role);

    return true;
}

Qt::ItemFlags Plans::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::ItemIsEnabled;

    return QAbstractListModel::flags(index) | Qt::ItemIsEditable;
}

void Plans::add(const QString name, const QString date, int id)
{
    beginInsertRows(QModelIndex(), names.size(), names.size());
    names.append(name);
    dates.append(date);
    //isBoughtMarks.append(false);
    endInsertRows();

    //m_data[0] = QString("Size: %1").arg(m_data.size());
    QModelIndex index = createIndex(0, 0, static_cast<void *>(0));
    emit dataChanged(index, createIndex(names.size()-1, 0, static_cast<void *>(0)));
}


