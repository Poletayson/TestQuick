#ifndef RECORD_H
#define RECORD_H

#include <QAbstractListModel>
#include <QModelIndex>
#include <QVariant>
#include <QStringList>
#include <QList>
#include <QDate>
#include <QHash>
#include <QByteArray>
#include <dataaccessor.h>



class RecordsList: public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles {
        PlanRole = Qt::UserRole + 1,
        NameRole,
        IdRole,
        IsBougtRole
    };

    RecordsList(DataAccessor *daA, QObject *parent = nullptr);

    virtual int rowCount(const QModelIndex &parent) const;
    virtual QVariant data(const QModelIndex &index, int role) const;
    virtual QHash<int, QByteArray> roleNames() const;
    virtual bool setData(const QModelIndex &index, const QVariant &value, int role);

    virtual Qt::ItemFlags flags(const QModelIndex &index) const;

signals:

public slots:
    void add(const QString name, int planId);
    virtual bool removeRow(int row, const QModelIndex &parent = QModelIndex());
    void fillRecords (int planId);

private:
//    QStringList names;
//    QList <int> lists;
//    QList <bool> isBoughtMarks;
    QList <Record> records;
    DataAccessor *da;
    QHash<int, QByteArray> roles;
};


class PlansList : public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles {
        DateRole = Qt::UserRole + 1,
        NameRole,
        IdRole
    };

    explicit PlansList(DataAccessor *daA, QObject *parent = nullptr);

    virtual int rowCount(const QModelIndex &parent) const;
    virtual QVariant data(const QModelIndex &index, int role) const;
    virtual QHash<int, QByteArray> roleNames() const;
    virtual bool setData(const QModelIndex &index, const QVariant &value, int role);

    virtual Qt::ItemFlags flags(const QModelIndex &index) const;

signals:

public slots:
    void add(const QString name, const QString date, int id);
    virtual bool removeRow(int row, const QModelIndex &parent = QModelIndex());

private:
    QList <Plan> plans;
    DataAccessor *da;
    QHash<int, QByteArray> roles;

//    QList <int> ids;
//    QStringList names;
//    QStringList dates;
};

#endif // RECORD_H
