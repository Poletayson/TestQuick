#ifndef RECORD_H
#define RECORD_H

#include <QAbstractListModel>
#include <QStringList>
#include <QList>
#include <QDate>
#include <QHash>

class Record: public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles {
        ListRole = Qt::UserRole + 1,
        NameRole,
        IsBougtRole
    };

    explicit Record(QObject *parent = nullptr);

    virtual int rowCount(const QModelIndex &parent) const;
    virtual QVariant data(const QModelIndex &index, int role) const;
    virtual QHash<int, QByteArray> roleNames() const;

    Q_INVOKABLE void add();

signals:

public slots:

private:
    QStringList names;
    QList <int> lists;
    QList <bool> isBoughtMarks;
    QHash<int, QByteArray> roles;
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
