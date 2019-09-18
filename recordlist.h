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

class Record: public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles {
        ListRole = Qt::UserRole + 1,
        NameRole,
        IsBougtRole
    };

    Record(QObject *parent = nullptr);

    virtual int rowCount(const QModelIndex &parent) const;
    virtual QVariant data(const QModelIndex &index, int role) const;
    virtual QHash<int, QByteArray> roleNames() const;
    virtual bool setData(const QModelIndex &index, const QVariant &value, int role);
    virtual Qt::ItemFlags flags(const QModelIndex &index) const;


    Q_INVOKABLE void add();

    Q_INVOKABLE void add(const QString name);
//    Q_INVOKABLE bool isBought();
//    Q_INVOKABLE void isBoughtChange();

signals:

public slots:

private:
    QStringList names;
    QList <int> lists;
    QList <bool> isBoughtMarks;
    //QHash<int, QByteArray> roles;
};


class RecordList : public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles {
        DateRole = Qt::UserRole + 1,
        NameRole
    };

    explicit RecordList(QObject *parent = nullptr);

signals:

public slots:

private:
    QStringList names;
    QList <QDate> dates;
    QHash<int, QByteArray> roles;
};

#endif // RECORD_H
