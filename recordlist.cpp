#include "recordlist.h"

Record::Record(QObject *parent) : QAbstractListModel(parent)
{
    roles = QAbstractListModel::roleNames();
    roles[ListRole] = "list";
    roles[NameRole] = "name";
    roles[IsBougtRole] = "isBougt";
}

int Record::rowCount(const QModelIndex &parent) const
{
    if (!parent.isValid())
        return 0;
    return names.count();
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
    roles[NameRole] = "name";
    roles[ListRole] = "list";
    roles[IsBougtRole] = "isBought";

    return roles;
}

void Record::add()
{
    beginInsertRows(QModelIndex(), names.size(), names.size());
    names.append("new " + QString::number(names.size()));
    lists.append(0);
    isBoughtMarks.append(false);
    endInsertRows();

    //m_data[0] = QString("Size: %1").arg(m_data.size());
//    QModelIndex index = createIndex(0, 0, static_cast<void *>(0));
//    emit dataChanged(index, index);
}

RecordList::RecordList(QObject *parent) : QAbstractListModel(parent)
{
    roles = QAbstractListModel::roleNames();
    roles[NameRole] = "name";
    roles[DateRole] = "date";
}
