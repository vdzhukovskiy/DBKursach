#include "dbconnector.h"

#include <QSqlTableModel>
#include <QSqlError>
#include <QDebug>
#include <QSqlQuery>

DbConnector::DbConnector(QObject *parent)
    : QObject{parent}
{}

DbConnector &DbConnector::instance()
{
    static DbConnector inst;
    return inst;
}

DbConnector::~DbConnector()
{
    if(db_)
        db_->close();
}


QStringList DbConnector::tables()
{
    auto tables = db_->tables();
    tables.insert(0, "");
    return tables;
}

QSqlDatabase &DbConnector::getDatabase()
{
    return *db_;
}

void DbConnector::addDatabase()
{
    if(db_)
    {
        emit connected();
        return;
    }

    db_ = std::make_shared<QSqlDatabase>(QSqlDatabase::addDatabase("QMYSQL", "conn"));
    db_->setHostName("damsel8s.beget.tech");
    db_->setDatabaseName("damsel8s_zhukkp");
    db_->setUserName("damsel8s_zhukkp");
    db_->setPassword("Admin123");
    bool ok = db_->open();
    qDebug() << ok;

    emit connected();
}
