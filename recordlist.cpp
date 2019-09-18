#include "recordlist.h"

Record::Record(QObject *parent) : QAbstractListModel(parent)
{
//    roles = QAbstractListModel::roleNames();
//    roles[ListRole] = "list";
//    roles[NameRole] = "name";
//    roles[IsBougtRole] = "isBougt";


    names.append("Test");
    isBoughtMarks.append(true);
    lists.append(0);
}

int Record::rowCount(const QModelIndex &parent) const
{
    if (!parent.isValid())
        return 0;
    return names.size();
}

QVariant Record::data(const QModelIndex &index, int role) const
{
    if (!index.isValid()) {
        return QVariant();
    }

    switch (role) {
    case NameRole:
        return names.at(index.row());
    case ListRole:
        return lists.at(index.row());
    case IsBougtRole:
        return isBoughtMarks.at(index.row());
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> Record::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
    roles[NameRole] = "position";
    roles[ListRole] = "listShoping";
    roles[IsBougtRole] = "isBought";

    return roles;
}

bool Record::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!index.isValid()){
        return false;
    }

    switch (role) {
    case ListRole:
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

Qt::ItemFlags Record::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::ItemIsEnabled;

    return QAbstractListModel::flags(index) | Qt::ItemIsEditable;
}

void Record::add()
{
    beginInsertRows(QModelIndex(), names.size(), names.size());
    names.append("Smthng");
    lists.append(0);
    isBoughtMarks.append(false);
    endInsertRows();

    //m_data[0] = QString("Size: %1").arg(m_data.size());
    QModelIndex index = createIndex(0, 0, static_cast<void *>(0));
    emit dataChanged(index, createIndex(names.size()-1, 0, static_cast<void *>(0)));
}

void Record::add(const QString name)
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

RecordList::RecordList(QObject *parent) : QAbstractListModel(parent)
{
    roles = QAbstractListModel::roleNames();
    roles[NameRole] = "name";
    roles[DateRole] = "date";
}
