#pragma once

#include <QObject>
#include <QSql>
#include <QSqlDatabase>

#include <memory>

class DbConnector : public QObject
{
    Q_OBJECT
public:
    explicit DbConnector(QObject *parent = nullptr);
    static DbConnector& instance();
    ~DbConnector();

    Q_INVOKABLE void addDatabase();

private:
    std::unique_ptr<QSqlDatabase> db_;

signals:
};
