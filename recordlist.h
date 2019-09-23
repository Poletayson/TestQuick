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

class Records: public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles {
        ListRole = Qt::UserRole + 1,
        NameRole,
        IsBougtRole
    };

    Records(QObject *parent = nullptr);

    virtual int rowCount(const QModelIndex &parent) const;
    virtual QVariant data(const QModelIndex &index, int role) const;
    virtual QHash<int, QByteArray> roleNames() const;
    virtual bool setData(const QModelIndex &index, const QVariant &value, int role);

    virtual Qt::ItemFlags flags(const QModelIndex &index) const;

signals:

public slots:
    void add(const QString name);
    virtual bool removeRow(int row, const QModelIndex &parent = QModelIndex());

private:
    QStringList names;
    QList <int> lists;
    QList <bool> isBoughtMarks;
    //QHash<int, QByteArray> roles;
};


class Plans : public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles {
        DateRole = Qt::UserRole + 1,
        NameRole,
        IdRole
    };

    explicit Plans(QObject *parent = nullptr);

    virtual int rowCount(const QModelIndex &parent) const;
    virtual QVariant data(const QModelIndex &index, int role) const;
    virtual QHash<int, QByteArray> roleNames() const;
    virtual bool setData(const QModelIndex &index, const QVariant &value, int role);

    virtual Qt::ItemFlags flags(const QModelIndex &index) const;

signals:

public slots:
    void add(const QString name, const QString date);
    virtual bool removeRow(int row, const QModelIndex &parent = QModelIndex());

private:
    QList <int> ids;
    QStringList names;
    QStringList dates;
    QHash<int, QByteArray> roles;
};

#endif // RECORD_H
